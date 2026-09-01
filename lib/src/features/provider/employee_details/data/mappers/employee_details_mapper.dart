import '../../domain/entities/employee_details_entity.dart';
import '../models/employee_details_department_model.dart';
import '../models/employee_details_manager_model.dart';
import '../models/employee_details_model.dart';
import '../models/employee_details_team_model.dart';

extension EmployeeDetailsModelMapper on EmployeeDetailsModel {
  EmployeeDetailsEntity toEntity() {
    return EmployeeDetailsEntity(
      id: id,
      fullName: fullName,
      image: image,
      phone: phone,
      position: position,
      email: email,
      role: role,
      department: department.toEntity(),
      team: team.toEntity(),
      manager: manager.toEntity(),
      remainingLeaveBalance: remainingLeaveBalance,
      leaveBalance: leaveBalance,
      permissionHours: permissionHours,
      leaveRequests: leaveRequests
          .map((request) => request.toEntity())
          .toList(),
      attendanceRecords: attendanceRecords
          .map((record) => record.toEntity())
          .toList(),
    );
  }
}

extension EmployeeDetailsDepartmentModelMapper
    on EmployeeDetailsDepartmentModel {
  EmployeeDetailsDepartmentEntity toEntity() {
    return EmployeeDetailsDepartmentEntity(id: id, name: name);
  }
}

extension EmployeeDetailsTeamModelMapper on EmployeeDetailsTeamModel {
  EmployeeDetailsTeamEntity toEntity() {
    return EmployeeDetailsTeamEntity(id: id, name: name);
  }
}

extension EmployeeDetailsManagerModelMapper on EmployeeDetailsManagerModel {
  EmployeeDetailsManagerEntity toEntity() {
    return EmployeeDetailsManagerEntity(id: id, name: name);
  }
}

extension EmployeeDetailsLeaveRequestModelMapper
    on EmployeeDetailsLeaveRequestModel {
  EmployeeDetailsLeaveRequestEntity toEntity() {
    return EmployeeDetailsLeaveRequestEntity(
      id: id,

      requestType: requestType,

      date: date,

      duration: duration,

      reason: reason,

      status: status,

      statusText: statusText,
    );
  }
}

extension EmployeeDetailsAttendanceModelMapper
    on EmployeeDetailsAttendanceModel {
  EmployeeDetailsAttendanceEntity toEntity() {
    return EmployeeDetailsAttendanceEntity(
      checkIn: checkIn,
      checkOut: checkOut,
      status: status,
      duration: duration,
    );
  }
}
