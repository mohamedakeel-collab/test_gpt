part of '../imports/employee_details_imports.dart';

class EmployeeDetailsViewController {
  String balanceLabel(int value) => value.toString();

  String requestTypeLabel(String requestType) {
    return switch (requestType) {
      'annual' => LocaleKeys.annualLeave,
      'sick' => LocaleKeys.sick,
      'permission' => LocaleKeys.permission,
      _ => requestType.isEmpty ? LocaleKeys.failureUnknown : requestType,
    };
  }

  String requestStatusLabel(String status) {
    return switch(status) {

      'approved' =>
      LocaleKeys.approved,

      'approved_by_manager' =>
      LocaleKeys.approved,

      'rejected' =>
      LocaleKeys.rejected,

      'pending' =>
      LocaleKeys.pending,

      _ =>
      LocaleKeys.failureUnknown,
    };
  }

  Color requestStatusColor(String status) {
    return switch (status) {
      'approved' => AppColors.success,
      'rejected' => AppColors.error,
      'pending' => AppColors.warning,
      _ => AppColors.icons,
    };
  }

  Color requestStatusSurface(String status) {
    return switch (status) {
      'approved' => AppColors.successSurface,
      'rejected' => AppColors.dangerSurface,
      'pending' => AppColors.warningSurface,
      _ => AppColors.fill,
    };
  }

  String managerLabel(EmployeeDetailsManagerEntity manager) {
    return manager.name.isEmpty ? LocaleKeys.failureUnknown : manager.name;
  }

  String departmentLabel(EmployeeDetailsDepartmentEntity department) {
    return department.name.isEmpty ? LocaleKeys.failureUnknown : department.name;
  }

  String teamLabel(EmployeeDetailsTeamEntity team) {
    return team.name.isEmpty ? LocaleKeys.failureUnknown : team.name;
  }

  String attendanceTimeLabel(EmployeeDetailsAttendanceEntity record) {
    if (record.checkOut.isEmpty) {
      return record.checkIn;
    }

    return '${record.checkIn} - ${record.checkOut}';
  }

  String attendanceDurationLabel(EmployeeDetailsAttendanceEntity record) {
    return record.duration.isEmpty ? '0' : record.duration;
  }

  String attendanceStatusLabel(String status) {
    return switch (status) {
      'present' => LocaleKeys.present,
      'late' => LocaleKeys.late,
      'absent' => LocaleKeys.absent,
      'leave' => LocaleKeys.leave,
      _ => status.isEmpty ? LocaleKeys.failureUnknown : status,
    };
  }

  Color attendanceStatusColor(String status) {
    return switch (status) {
      'present' => AppColors.success,
      'late' => AppColors.warning,
      'absent' => AppColors.error,
      'leave' => AppColors.info,
      _ => AppColors.icons,
    };
  }

  Color attendanceStatusSurface(String status) {
    return switch (status) {
      'present' => AppColors.successSurface,
      'late' => AppColors.warningSurface,
      'absent' => AppColors.dangerSurface,
      'leave' => AppColors.infoSurface,
      _ => AppColors.fill,
    };
  }

  void dispose() {}
}
