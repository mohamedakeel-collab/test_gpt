import '../../domain/entities/comment_entity.dart';
import '../../domain/entities/leave_request_entity.dart';
import '../../domain/entities/reviewer_entity.dart';
import '../../../login/data/mappers/login_mappers.dart';
import '../models/comment_model.dart';
import '../models/leave_request_model.dart';
import '../models/reviewer_model.dart';

/// Maps between the data-layer models (wire shape) and the domain-layer
/// entities (clean shape).
///
/// Architectural note
///   The mapper lives in the **data** layer because it knows both the
///   `Model` (data) and the `Entity` (domain). Domain code never imports
///   it — the data-source uses `.toEntity()` before returning.
///
/// Usage
///   ```dart
///   final entity = leaveRequestModel.toEntity();
///   ```
extension LeaveRequestModelMapper on LeaveRequestModel {
  LeaveRequestEntity toEntity() => LeaveRequestEntity(
    id: id,
    employeeId: employeeId,
    reviewerId: reviewerId,
    leaveType: leaveType,
    startDate: startDate,
    endDate: endDate,
    duration: duration,
    reason: reason,
    reviewedByManager: reviewedByManager,
    reviewedByHr: reviewedByHr,
    file: file,
    status: status,
    employee: employee?.toEntity(),
    statusText: statusText,
    submittedAt: submittedAt,
    reviewedAt: reviewedAt,
    reviewer: reviewer?.toEntity(),
    comments: comments.map((c) => c.toEntity()).toList(),
  );
}

extension ReviewerModelMapper on ReviewerModel {
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
  );
}

extension CommentModelMapper on CommentModel {
  CommentEntity toEntity() =>
      CommentEntity(id: id, comment: comment, createdAt: createdAt);
}
