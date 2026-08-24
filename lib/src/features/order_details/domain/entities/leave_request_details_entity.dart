import 'package:equatable/equatable.dart';

import 'attendance_record_entity.dart';
import 'comment_entity.dart';
import 'employee_details_entity.dart';
import 'reviewer_details_entity.dart';

class LeaveRequestDetailsEntity extends Equatable {
  const LeaveRequestDetailsEntity({
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
  final EmployeeDetailsEntity employee;
  final ReviewerDetailsEntity? reviewer;
  final List<CommentEntity> comments;
  final List<AttendanceRecordEntity> attendanceRecords;

  bool get isPending => status == 'pending';

  factory LeaveRequestDetailsEntity.initial() => LeaveRequestDetailsEntity(
    id: 0,
    employeeId: 0,
    leaveType: '',
    startDate: '',
    startTime: '',
    endDate: '',
    endTime: '',
    duration: '',
    reason: '',
    status: '',
    statusText: '',
    employee: EmployeeDetailsEntity.initial(),
    comments: const [],
    attendanceRecords: const [],
  );

  @override
  List<Object?> get props => [
    id,
    employeeId,
    reviewerId,
    leaveType,
    startDate,
    startTime,
    endDate,
    endTime,
    duration,
    reason,
    file,
    status,
    statusText,
    submittedAt,
    reviewedAt,
    employee,
    reviewer,
    comments,
    attendanceRecords,
  ];
}
