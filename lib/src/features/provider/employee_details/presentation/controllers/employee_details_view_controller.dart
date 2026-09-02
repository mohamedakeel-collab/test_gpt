part of '../imports/employee_details_imports.dart';

class EmployeeDetailsViewController implements RequestCardController {


  @override
  String requestTypeLabel(String requestType) {

    return switch (requestType) {

      'leave' ||
      'annual' =>
      LocaleKeys.annualLeave,


      'sick' =>
      LocaleKeys.sick,


      'permission' =>
      LocaleKeys.permission,


      'remote' =>
      LocaleKeys.remote,


      _ =>
      requestType.isEmpty
          ? LocaleKeys.failureUnknown
          : requestType,

    };

  }



  String balanceLabel(int value) =>
      value.toString();



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

      'approved' =>
      AppColors.success,

      'approved_by_manager' =>
      AppColors.success,

      'rejected' =>
      AppColors.error,

      'pending' =>
      AppColors.warning,

      _ =>
      AppColors.icons,

    };
  }



  Color requestStatusSurface(String status) {
    return switch (status) {

      'approved' =>
      AppColors.successSurface,

      'approved_by_manager' =>
      AppColors.successSurface,

      'rejected' =>
      AppColors.dangerSurface,

      'pending' =>
      AppColors.warningSurface,

      _ =>
      AppColors.fill,

    };
  }



  String managerLabel(
      EmployeeDetailsManagerEntity manager,
      ) {

    return manager.name.isEmpty
        ? LocaleKeys.failureUnknown
        : manager.name;

  }



  String departmentLabel(
      EmployeeDetailsDepartmentEntity department,
      ) {

    return department.name.isEmpty
        ? LocaleKeys.failureUnknown
        : department.name;

  }



  String teamLabel(
      EmployeeDetailsTeamEntity team,
      ) {

    return team.name.isEmpty
        ? LocaleKeys.failureUnknown
        : team.name;

  }



  String attendanceTimeLabel(
      EmployeeDetailsAttendanceEntity record,
      ) {

    if(record.checkOut.isEmpty){
      return record.checkIn;
    }

    return '${record.checkIn} - ${record.checkOut}';

  }



  String attendanceDurationLabel(
      EmployeeDetailsAttendanceEntity record,
      ) {

    return record.duration.isEmpty
        ? '0'
        : record.duration;

  }



  void dispose(){}

}