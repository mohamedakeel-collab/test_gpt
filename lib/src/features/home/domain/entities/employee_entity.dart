import 'package:equatable/equatable.dart';

import 'department_entity.dart';
import 'team_entity.dart';
import 'user_entity.dart';

/// Pure domain object — the employee object returned by the Home API.
///
/// The nested `manager` reuses this same type because the wire shape of a
/// manager is identical to an employee's top-level fields.
class EmployeeEntity extends Equatable {
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
  final DepartmentEntity? department;
  final TeamEntity? team;
  final EmployeeEntity? manager;

  const EmployeeEntity({
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
    this.department,
    this.team,
    this.manager,
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
        department,
        team,
        manager,
      ];
}