import 'package:equatable/equatable.dart';

import 'attendance_entity.dart';
import 'employee_entity.dart';
import 'recent_request_entity.dart';
import 'request_summary_entity.dart';

/// Pure domain object — aggregate of the Home dashboard data.
///
/// Serialization is handled by the data layer (`HomeModel` + `HomeMapper`).
class HomeEntity extends Equatable {
  final EmployeeEntity? employee;
  final int remainingLeaveBalance;
  final int permissionHours;
  final RequestSummaryEntity requests;
  final List<RecentRequestEntity> recentRequests;
  final AttendanceEntity? latestAttendance;

  const HomeEntity({
    required this.remainingLeaveBalance,
    required this.permissionHours,
    required this.requests,
    required this.recentRequests,
    this.employee,
    this.latestAttendance,
  });

  /// Placeholder used by loading states so the UI can lay out before the
  /// real data arrives.
  factory HomeEntity.initial() => HomeEntity(
        employee: null,
        remainingLeaveBalance: 0,
        permissionHours: 0,
        requests: RequestSummaryEntity.initial(),
        recentRequests: [],
        latestAttendance: null,
      );

  @override
  List<Object?> get props => [
        employee,
        remainingLeaveBalance,
        permissionHours,
        requests,
        recentRequests,
        latestAttendance,
      ];
}