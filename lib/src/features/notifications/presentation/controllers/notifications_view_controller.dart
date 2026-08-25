part of '../imports/notifications_imports.dart';

class NotificationsViewController {
  const NotificationsViewController();


  String createdAtLabel(DateTime? createdAt) {
    if (createdAt == null) return '';

    final hour = createdAt.hour % 12 == 0 ? 12 : createdAt.hour % 12;
    final minute = createdAt.minute.toString().padLeft(2, '0');
    final period = createdAt.hour < 12
        ? LocaleKeys.amPeriod
        : LocaleKeys.pmPeriod;
    return '$hour:$minute $period';
  }



  void dispose() {}
}
