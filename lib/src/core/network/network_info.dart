import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  NetworkInfo._() {
    _sub = _connectivity.onConnectivityChanged.listen(_emit);
  }
  static final NetworkInfo _instance = NetworkInfo._();
  factory NetworkInfo() => _instance;

  final Connectivity _connectivity = Connectivity();
  late final StreamSubscription<List<ConnectivityResult>> _sub;

  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  Stream<bool> get onStatusChange => _controller.stream;

  bool _lastKnown = true;
  bool get isOnline => _lastKnown;

  Future<bool> check() async {
    final results = await _connectivity.checkConnectivity();
    _emit(results);
    return _lastKnown;
  }

  void _emit(List<ConnectivityResult> results) {
    final online = results.any((r) => r != ConnectivityResult.none);
    if (online != _lastKnown) {
      _lastKnown = online;
      _controller.add(online);
    } else {
      _lastKnown = online;
    }
  }

  void dispose() {
    _sub.cancel();
    _controller.close();
  }
}
