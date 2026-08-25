import '../../domain/entities/notification_entity.dart';
import '../../domain/enums/notification_type.dart';
import '../models/notification_model.dart';

extension NotificationModelMapper on NotificationModel {
  NotificationEntity toEntity() => NotificationEntity(
    id: id,
    title: title,
    message: text,
    createdAt: createdAt,
    type: _mapType(type),
    isRead: isRead,
    readAt: readAt,
  );

  NotificationType _mapType(String value) {
    return switch (value) {
      'leave_request_approved' => NotificationType.leaveRequestApproved,
      'leave_request_rejected' => NotificationType.leaveRequestRejected,
      'leave_request_pending' => NotificationType.leaveRequestPending,
      _ => NotificationType.system,
    };
  }
}
