import '../../../../core/shared/extensions/json_extensions.dart';
import 'comment_model.dart';
import 'reviewer_model.dart';

/// DTO mirroring the JSON shape returned by `GET /me/leave-requests`.
///
/// Notes
///   - We use the `JsonGetters` extension to read every field — never
///     throws, always gives back a sensible fallback when a key is missing
///     or mistyped.
///   - Status is kept as a raw string here. The `OrdersMapper` extension
///     in `data/mappers/` is responsible for turning it (and the nested
///     reviewer / comments) into domain entities.
class LeaveRequestModel {
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

  /// Raw status string from the wire — kept here so the data layer never
  /// has to know about domain enums.
  final String status;
  final String statusText;
  final String? submittedAt;
  final String? reviewedAt;
  final ReviewerModel? reviewer;
  final List<CommentModel> comments;

  const LeaveRequestModel({
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
    this.comments = const [],
  });

  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) =>
      LeaveRequestModel(
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
        reviewer: json.getObject('reviewer', ReviewerModel.fromJson),
        comments:
            json.getObjectList('comments', CommentModel.fromJson),
      );
}