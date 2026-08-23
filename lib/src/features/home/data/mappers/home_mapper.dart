import '../../domain/entities/attendance_entity.dart';
import '../../domain/entities/department_entity.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/entities/recent_request_entity.dart';
import '../../domain/entities/request_summary_entity.dart';
import '../../domain/entities/reviewer_entity.dart';
import '../../domain/entities/team_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../models/home_attendance_model.dart';
import '../models/home_department_model.dart';
import '../models/home_employee_model.dart';
import '../models/home_model.dart';
import '../models/home_requests_model.dart';
import '../models/home_reviewer_model.dart';
import '../models/home_team_model.dart';
import '../models/home_user_model.dart';

/// Maps between the data-layer models (wire shape) and the domain-layer
/// entities (clean shape).
///
/// Architectural note
///   The mapper lives in the **data** layer because it knows both the
///   `Model` (data) and the `Entity` (domain). Domain code never imports
///   it — the data-source uses `.toEntity()` before returning.
extension HomeModelMapper on HomeModel {
  HomeEntity toEntity() => HomeEntity(
        employee: employee?.toEntity(),
        remainingLeaveBalance: remainingLeaveBalance,
        permissionHours: permissionHours,
        requests: requests.toEntity(),
        recentRequests: recentRequests.map((r) => r.toEntity()).toList(),
        latestAttendance: latestAttendance?.toEntity(),
      );
}

extension HomeRequestsModelMapper on HomeRequestsModel {
  RequestSummaryEntity toEntity() => RequestSummaryEntity(
        total: total,
        pending: pending,
        approved: approved,
        rejected: rejected,
      );
}

extension RecentRequestModelMapper on RecentRequestModel {
  RecentRequestEntity toEntity() => RecentRequestEntity(
        id: id,
        employeeId: employeeId,
        reviewerId: reviewerId,
        leaveType: leaveType,
        startDate: startDate,
        endDate: endDate,
        reason: reason,
        reviewedByManager: reviewedByManager,
        reviewedByHr: reviewedByHr,
        file: file,
        duration: duration,
        status: status,
        statusText: statusText,
        submittedAt: submittedAt,
        reviewedAt: reviewedAt,
        reviewer: reviewer?.toEntity(),
      );
}

extension HomeEmployeeModelMapper on HomeEmployeeModel {
  EmployeeEntity toEntity() => EmployeeEntity(
        id: id,
        fullName: fullName,
        phone: phone,
        position: position,
        departmentId: departmentId,
        teamId: teamId,
        managerId: managerId,
        remainingLeaveBalance: remainingLeaveBalance,
        balanceExpiration: balanceExpiration,
        permissionHours: permissionHours,
        leaveBalance: leaveBalance,
        user: user?.toEntity(),
        department: department?.toEntity(),
        team: team?.toEntity(),
        manager: manager?.toEntity(),
      );
}

extension HomeReviewerModelMapper on HomeReviewerModel {
  ReviewerEntity toEntity() => ReviewerEntity(
        id: id,
        fullName: fullName,
        phone: phone,
        position: position,
        departmentId: departmentId,
        teamId: teamId,
        managerId: managerId,
        remainingLeaveBalance: remainingLeaveBalance,
        balanceExpiration: balanceExpiration,
        permissionHours: permissionHours,
        leaveBalance: leaveBalance,
        user: user?.toEntity(),
      );
}

extension HomeUserModelMapper on HomeUserModel {
  UserEntity toEntity() => UserEntity(
        id: id,
        email: email,
        role: role,
        lang: lang,
        image: image,
      );
}

extension HomeDepartmentModelMapper on HomeDepartmentModel {
  DepartmentEntity toEntity() =>
      DepartmentEntity(id: id, name: name, managerId: managerId);
}

extension HomeTeamModelMapper on HomeTeamModel {
  TeamEntity toEntity() =>
      TeamEntity(id: id, teamName: teamName, leadId: leadId);
}

extension HomeAttendanceModelMapper on HomeAttendanceModel {
  AttendanceEntity toEntity() => AttendanceEntity(
        id: id,
        employeeId: employeeId,
        leaveRequestId: leaveRequestId,
        checkIn: checkIn,
        checkOut: checkOut,
        status: status,
        locationGps: locationGps,
        duration: duration,
        dayName: dayName,
      );
}