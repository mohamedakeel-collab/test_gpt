import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:uuid/uuid.dart';

import '../dio_client.dart';
import '../network_info.dart';
import 'queued_operation.dart';

enum SyncStatus { idle, syncing }

/// Persists Add/Update/Delete operations that the user triggers while
/// offline and replays them in FIFO order once the network comes back.
class OfflineQueueManager {
  OfflineQueueManager._();
  static final OfflineQueueManager _instance = OfflineQueueManager._();
  factory OfflineQueueManager() => _instance;

  static const String _boxName = 'offline_queue';
  static const int _maxRetries = 5;

  late final Box<QueuedOperation> _box;
  final _uuid = const Uuid();
  final NetworkInfo _network = NetworkInfo();
  final Dio _dio = DioClient().dio;

  final StreamController<int> _pendingController =
      StreamController<int>.broadcast();
  final StreamController<SyncStatus> _statusController =
      StreamController<SyncStatus>.broadcast();

  /// Optional callback invoked when an operation is dropped permanently
  /// (4xx or retry exhausted). Wire to your local DB if you keep optimistic
  /// records that need to be marked as failed.
  void Function(QueuedOperation op, Object? error)? onOperationFailed;

  /// Optional callback invoked when an operation succeeds. Receives the
  /// server response so you can sync the local record (e.g. assign the
  /// server id to a row keyed by `localId`).
  void Function(QueuedOperation op, Response response)? onOperationSucceeded;

  bool _processing = false;
  StreamSubscription<bool>? _netSub;

  Stream<int> get pendingStream => _pendingController.stream;
  Stream<SyncStatus> get statusStream => _statusController.stream;
  int get pendingCount => _box.length;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(10)) {
      Hive.registerAdapter(QueuedOperationAdapter());
    }
    _box = await Hive.openBox<QueuedOperation>(_boxName);
    _pendingController.add(_box.length);

    _netSub = _network.onStatusChange.listen((online) {
      if (online) _processQueue();
    });

    // App-start sync.
    if (await _network.check() && _box.isNotEmpty) {
      unawaited(_processQueue());
    }
  }

  Future<QueuedOperation> enqueue({
    required String endpoint,
    required String method,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    String? localId,
  }) async {
    final op = QueuedOperation(
      id: _uuid.v4(),
      endpoint: endpoint,
      method: method.toUpperCase(),
      body: body,
      headers: headers,
      createdAt: DateTime.now(),
      retryCount: 0,
      localId: localId,
    );
    await _box.put(op.id, op);
    _pendingController.add(_box.length);

    // Try immediately if online.
    if (_network.isOnline) unawaited(_processQueue());
    return op;
  }

  Future<void> _processQueue() async {
    if (_processing || _box.isEmpty) return;
    _processing = true;
    _statusController.add(SyncStatus.syncing);

    try {
      // FIFO order by createdAt.
      final ops = _box.values.toList()
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

      for (final op in ops) {
        if (!_network.isOnline) break;
        await _runOne(op);
      }
    } finally {
      _processing = false;
      _statusController.add(SyncStatus.idle);
      _pendingController.add(_box.length);
    }
  }

  Future<void> _runOne(QueuedOperation op) async {
    try {
      final res = await _dio.request<dynamic>(
        op.endpoint,
        data: op.body,
        options: Options(
          method: op.method,
          headers: op.headers,
        ),
      );

      final code = res.statusCode ?? 0;
      if (code >= 200 && code < 300) {
        await _box.delete(op.id);
        onOperationSucceeded?.call(op, res);
        return;
      }

      // 4xx = hard fail, drop.
      if (code >= 400 && code < 500) {
        await _box.delete(op.id);
        onOperationFailed?.call(op, 'status:$code');
        return;
      }

      // 5xx → retry.
      await _bumpRetry(op);
    } on DioException catch (e) {
      final code = e.response?.statusCode ?? 0;
      if (code >= 400 && code < 500) {
        await _box.delete(op.id);
        onOperationFailed?.call(op, e);
        return;
      }
      await _bumpRetry(op, error: e);
    } catch (e) {
      await _bumpRetry(op, error: e);
    }
  }

  Future<void> _bumpRetry(QueuedOperation op, {Object? error}) async {
    op.retryCount += 1;
    if (op.retryCount >= _maxRetries) {
      await _box.delete(op.id);
      onOperationFailed?.call(op, error);
      return;
    }
    await op.save();
  }

  @visibleForTesting
  Future<void> clearAll() async {
    await _box.clear();
    _pendingController.add(0);
  }

  Future<void> dispose() async {
    await _netSub?.cancel();
    await _pendingController.close();
    await _statusController.close();
  }
}
