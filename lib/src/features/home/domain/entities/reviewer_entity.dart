import 'package:equatable/equatable.dart';

import 'user_entity.dart';

/// Pure domain object — the reviewer attached to a recent request.
///
/// Shares the employee's top-level wire shape (the reviewer object carries
/// the same fields, minus the nested department/team/manager).
class ReviewerEntity extends Equatable {
  final int id;
  final String fullName;
  final String phone;
  final String position;
  final int departmentId;
  final int teamId;
  final int managerId;
  final int remainingLeaveBalance;
  final DateTime? balanceExpiration;
  final int permissionHours;
  final int leaveBalance;
  final UserEntity? user;

  const ReviewerEntity({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.position,
    required this.departmentId,
    required this.teamId,
    required this.managerId,
    required this.remainingLeaveBalance,
    required this.permissionHours,
    required this.leaveBalance,
    this.balanceExpiration,
    this.user,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        phone,
        position,
        departmentId,
        teamId,
        managerId,
        remainingLeaveBalance,
        balanceExpiration,
        permissionHours,
        leaveBalance,
        user,
      ];
}