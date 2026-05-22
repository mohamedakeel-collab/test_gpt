import 'package:hive_ce/hive.dart';

part 'queued_operation.g.dart';

@HiveType(typeId: 10)
class QueuedOperation extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String endpoint;

  @HiveField(2)
  final String method; // POST | PUT | PATCH | DELETE

  @HiveField(3)
  final Map<String, dynamic>? body;

  @HiveField(4)
  final Map<String, dynamic>? headers;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  int retryCount;

  @HiveField(7)
  final String? localId;

  QueuedOperation({
    required this.id,
    required this.endpoint,
    required this.method,
    this.body,
    this.headers,
    required this.createdAt,
    this.retryCount = 0,
    this.localId,
  });
}
