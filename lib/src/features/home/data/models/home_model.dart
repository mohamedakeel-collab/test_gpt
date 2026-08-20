import '../../../../core/shared/extensions/json_extensions.dart';
import 'home_attendance_model.dart';
import 'home_employee_model.dart';
import 'home_requests_model.dart';
import 'home_reviewer_model.dart';

/// DTO mirroring the Home API response.
///
/// Notes
///   - We use the `JsonGetters` extension to read every field — never
///     throws, always gives back a sensible fallback when a key is missing
///     or mistyped.
///   - `RecentRequestModel` lives here too (same file) because the API
///     nests the whole list under `data.recent_requests`.
class HomeModel {
  final HomeEmployeeModel? employee;
  final int remainingLeaveBalance;
  final int permissionHours;
  final HomeRequestsModel requests;
  final List<RecentRequestModel> recentRequests;
  final HomeAttendanceModel? latestAttendance;

  const HomeModel({
    required this.remainingLeaveBalance,
    required this.permissionHours,
    required this.requests,
    required this.recentRequests,
    this.employee,
    this.latestAttendance,
  });

  /// The wire shape is `{"data": {...}}`; unwrap defensively so the same
  /// `fromJson` works with either a raw payload or an already-unwrapped map.
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final raw = json['data'];
    final Map<String, dynamic> map = raw is Map<String, dynamic>
        ? raw
        : raw is Map
            ? Map<String, dynamic>.from(raw)
            : json;

    return HomeModel(
      employee: map.getObject('employee', HomeEmployeeModel.fromJson),
      remainingLeaveBalance: map.getInt('remaining_leave_balance'),
      permissionHours: map.getInt('permission_hours'),
      requests: map.getObject('requests', HomeRequestsModel.fromJson) ??
          const HomeRequestsModel(
            total: 0,
            pending: 0,
            approved: 0,
            rejected: 0,
          ),
      recentRequests:
          map.getObjectList('recent_requests', RecentRequestModel.fromJson),
      latestAttendance:
          map.getObject('latest_attendance', HomeAttendanceModel.fromJson),
    );
  }
}

class RecentRequestModel {
  final int id;
  final int employeeId;
  final int? reviewerId;
  final String leaveType;
  final String? startDate;
  final String? endDate;
  final String? duration;
  final String reason;
  final bool reviewedByManager;
  final bool reviewedByHr;
  final String? file;
  final String status;
  final String statusText;
  final String? submittedAt;
  final String? reviewedAt;
  final HomeReviewerModel? reviewer;

  const RecentRequestModel({
    required this.id,
    required this.employeeId,
    required this.leaveType,
    required this.reason,
    required this.reviewedByManager,
    required this.reviewedByHr,
    required this.status,
    this.reviewerId,
    this.startDate,
    this.endDate,
    this.duration,
    this.file,
    this.statusText = '',
    this.submittedAt,
    this.reviewedAt,
    this.reviewer,
  });

  factory RecentRequestModel.fromJson(Map<String, dynamic> json) =>
      RecentRequestModel(
        id: json.getInt('id'),
        employeeId: json.getInt('employee_id'),
        reviewerId: json.getIntOrNull('reviewer_id'),
        leaveType: json.getString('leave_type'),
        startDate: json.getStringOrNull('start_date'),
        endDate: json.getStringOrNull('end_date'),
        duration: json.getStringOrNull('duration'),
        reason: json.getString('reason'),
        reviewedByManager: json.getBool('reviewed_by_manager'),
        reviewedByHr: json.getBool('reviewed_by_hr'),
        file: json.getStringOrNull('file'),
        status: json.getString('status'),
        statusText: json.getString('status_text'),
        submittedAt: json.getStringOrNull('submitted_at'),
        reviewedAt: json.getStringOrNull('reviewed_at'),
        reviewer: json.getObject(
          'reviewer',
          HomeReviewerModel.fromJson,
        ),
      );
}