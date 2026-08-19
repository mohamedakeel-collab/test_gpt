import 'package:equatable/equatable.dart';

import 'reviewer_entity.dart';

/// Pure domain object — a leave / permission request shown on the home feed.
class RecentRequestEntity extends Equatable {
  final int id;
  final int employeeId;
  final int? reviewerId;
  final String leaveType;
  final String? startDate;
  final String? endDate;
  final String reason;
  final bool reviewedByManager;
  final bool reviewedByHr;
  final String? file;
  final String status;
  final String statusText;
  final String? submittedAt;
  final String? reviewedAt;
  final ReviewerEntity? reviewer;

  const RecentRequestEntity({
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
    this.file,
    this.statusText = '',
    this.submittedAt,
    this.reviewedAt,
    this.reviewer,
  });

  @override
  List<Object?> get props => [
        id,
        employeeId,
        reviewerId,
        leaveType,
        startDate,
        endDate,
        reason,
        reviewedByManager,
        reviewedByHr,
        file,
        status,
        statusText,
        submittedAt,
        reviewedAt,
        reviewer,
      ];
}