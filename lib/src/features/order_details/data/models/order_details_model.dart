import '../../../../core/shared/extensions/json_extensions.dart';
import 'attendance_record_model.dart';
import 'comment_model.dart';
import 'employee_details_model.dart';
import 'reviewer_details_model.dart';

class OrderDetailsModel {
  const OrderDetailsModel({
    required this.id,
    required this.employeeId,
    required this.leaveType,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.duration,
    required this.reason,
    required this.status,
    required this.statusText,
    required this.employee,
    required this.comments,
    required this.attendanceRecords,
    this.reviewerId,
    this.file,
    this.submittedAt,
    this.reviewedAt,
    this.reviewer,
  });

  final int id;
  final int employeeId;
  final int? reviewerId;
  final String leaveType;
  final String startDate;
  final String startTime;
  final String endDate;
  final String endTime;
  final String duration;
  final String reason;
  final String? file;
  final String status;
  final String statusText;
  final String? submittedAt;
  final String? reviewedAt;
  final EmployeeDetailsModel employee;
  final ReviewerDetailsModel? reviewer;
  final List<CommentModel> comments;
  final List<AttendanceRecordModel> attendanceRecords;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        id: json.getInt('id'),
        employeeId: json.getInt('employee_id'),
        reviewerId: json.getIntOrNull('reviewer_id'),
        leaveType: json.getString('leave_type'),
        startDate: json.getString('start_date'),
        startTime: json.getString('start_time'),
        endDate: json.getString('end_date'),
        endTime: json.getString('end_time'),
        duration: json.getString('duration'),
        reason: json.getString('reason'),
        file: json.getStringOrNull('file'),
        status: json.getString('status'),
        statusText: json.getString('status_text'),
        submittedAt: json.getStringOrNull('submitted_at'),
        reviewedAt: json.getStringOrNull('reviewed_at'),
        employee:
            json.getObject('employee', EmployeeDetailsModel.fromJson) ??
            EmployeeDetailsModel.fromJson(const {}),
        reviewer: json.getObject('reviewer', ReviewerDetailsModel.fromJson),
        comments: json.getObjectList('comments', CommentModel.fromJson),
        attendanceRecords: json.getObjectList(
          'attendance_records',
          AttendanceRecordModel.fromJson,
        ),
      );
}
