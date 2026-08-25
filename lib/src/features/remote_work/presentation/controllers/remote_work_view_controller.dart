part of '../imports/remote_work_imports.dart';

class RemoteWorkViewController {
  DateTime? startedAt;

  Future<void> init() async {
    startedAt = await RemoteWorkStorage.getStartTime();
  }

  AttendanceEntity? activeRecord(List<AttendanceEntity> records) {
    for (final record in records) {
      if (record.isActive) {
        return record;
      }
    }

    return null;
  }

  String timeRange(AttendanceEntity record) {
    if (record.checkOutTime.isEmpty) {
      return record.checkInTime;
    }

    return '${record.checkInTime} - ${record.checkOutTime}';
  }

  String durationLabel(AttendanceEntity record) {
    final duration = record.duration.toStringAsFixed(2);

    return '$duration ${LocaleKeys.hour}';
  }

  String elapsedLabel() {
    if (startedAt == null) {
      return '00:00:00';
    }

    final elapsed = DateTime.now().difference(startedAt!);

    if (elapsed.isNegative) {
      return '00:00:00';
    }

    final hours = elapsed.inHours.toString().padLeft(2, '0');

    final minutes = (elapsed.inMinutes % 60).toString().padLeft(2, '0');

    final seconds = (elapsed.inSeconds % 60).toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }

  void setStartTime(DateTime time) {
    startedAt = time;
  }

  void clearStartTime() {
    startedAt = null;
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
