part of '../imports/remote_work_imports.dart';

class RemoteWorkViewController {
  const RemoteWorkViewController();

  AttendanceEntity? activeRecord(List<AttendanceEntity> records) {
    for (final record in records) {
      if (record.isActive) return record;
    }
    return null;
  }

  String timeRange(AttendanceEntity record) {
    if (record.checkOutTime.isEmpty) return record.checkInTime;
    return '${record.checkInTime} - ${record.checkOutTime} ';
  }

  String durationLabel(AttendanceEntity record) {
    final duration = record.duration.toStringAsFixed(2);
    return '$duration ${LocaleKeys.hour}';
  }

  String statusLabel(String status) {
    return switch (status) {
      'present' => LocaleKeys.present,
      'late' => LocaleKeys.late,
      'absent' => LocaleKeys.absent,
      'leave' => LocaleKeys.leave,
      _ => status,
    };
  }

  Color statusColor(String status) {
    return switch (status) {
      'present' => AppColors.success,
      'late' => AppColors.warning,
      'absent' => AppColors.error,
      'leave' => AppColors.info,
      _ => AppColors.icons,
    };
  }

  Color statusSurface(String status) {
    return switch (status) {
      'present' => AppColors.successSurface,
      'late' => AppColors.warningSurface,
      'absent' => AppColors.dangerSurface,
      'leave' => AppColors.infoSurface,
      _ => AppColors.lightGray,
    };
  }

  void dispose() {}
}
