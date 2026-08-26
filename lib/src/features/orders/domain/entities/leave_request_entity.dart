import 'package:equatable/equatable.dart';

import 'comment_entity.dart';
import '../../../login/domain/entities/employee_entity.dart';
import 'reviewer_entity.dart';

/// Pure domain object — a single leave request returned by the Orders API.
///
/// No `fromJson`, no Dio, no Flutter widgets. Serialization is handled by
/// `LeaveRequestModel` in `data/models/` and the `OrdersMapper` extension
/// in `data/mappers/`.
class LeaveRequestEntity extends Equatable {
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
  final EmployeeEntity? employee;

  /// Backend-provided localized status label (e.g. "قيد المراجعة").
  final String statusText;
  final String? submittedAt;
  final String? reviewedAt;
  final ReviewerEntity? reviewer;
  final List<CommentEntity> comments;

  const LeaveRequestEntity({
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
    this.employee,
    this.comments = const [],
  });

  @override
  List<Object?> get props => [
    id,
    employeeId,
    reviewerId,
    leaveType,
    startDate,
    endDate,
    duration,
    reason,
    reviewedByManager,
    reviewedByHr,
    file,
    status,
    employee,
    statusText,
    submittedAt,
    reviewedAt,
    reviewer,
    comments,
  ];
}
