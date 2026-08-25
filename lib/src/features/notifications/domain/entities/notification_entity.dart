import 'package:equatable/equatable.dart';

import '../enums/notification_type.dart';

class NotificationEntity extends Equatable {
  const NotificationEntity({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.type,
    required this.isRead,
    required this.readAt,
  });

  final int id;
  final String title;
  final String message;
  final DateTime? createdAt;
  final NotificationType type;
  final bool isRead;
  final DateTime? readAt;

  factory NotificationEntity.initial() => const NotificationEntity(
    id: 0,
    title: '',
    message: '',
    createdAt: null,
    type: NotificationType.system,
    isRead: false,
    readAt: null,
  );

  @override
  List<Object?> get props => [
    id,
    title,
    message,
    createdAt,
    type,
    isRead,
    readAt,
  ];
}
