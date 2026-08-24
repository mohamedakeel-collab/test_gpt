import 'package:equatable/equatable.dart';

import 'department_entity.dart';
import 'team_entity.dart';

/// Pure domain object for an employee — no `fromJson`, no Dio, no Flutter.
///
/// Serialization is handled by `EmployeeModel` in `data/models/` and the
/// `EmployeeMapper` extension in `data/mappers/`.
class EmployeeEntity extends Equatable {
  final int id;
  final String fullName;
  final String phone;
  final String position;
  final int? departmentId;
  final int? teamId;
  final int? managerId;
  final int remainingLeaveBalance;
  final int leaveBalance;
  final DateTime? balanceExpiration;
  final int permissionHours;
  final DepartmentEntity? department;
  final TeamEntity? team;
  final EmployeeEntity? manager;

  const EmployeeEntity({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.position,
    this.departmentId,
    this.teamId,
    this.managerId,
    this.remainingLeaveBalance = 0,
    this.leaveBalance = 0,
    this.balanceExpiration,
    this.permissionHours = 0,
    this.department,
    this.team,
    this.manager,
  });

  factory EmployeeEntity.initial() =>
      const EmployeeEntity(id: 0, fullName: '', phone: '', position: '');

  EmployeeEntity copyWith({
    int? id,
    String? fullName,
    String? phone,
    String? position,
    int? departmentId,
    int? teamId,
    int? managerId,
    int? remainingLeaveBalance,
    int? leaveBalance,
    DateTime? balanceExpiration,
    int? permissionHours,
    DepartmentEntity? department,
    TeamEntity? team,
    EmployeeEntity? manager,
  }) {
    return EmployeeEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      position: position ?? this.position,
      departmentId: departmentId ?? this.departmentId,
      teamId: teamId ?? this.teamId,
      managerId: managerId ?? this.managerId,
      remainingLeaveBalance:
          remainingLeaveBalance ?? this.remainingLeaveBalance,
      leaveBalance: leaveBalance ?? this.leaveBalance,
      balanceExpiration: balanceExpiration ?? this.balanceExpiration,
      permissionHours: permissionHours ?? this.permissionHours,
      department: department ?? this.department,
      team: team ?? this.team,
      manager: manager ?? this.manager,
    );
  }

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
    leaveBalance,
    balanceExpiration,
    permissionHours,
    department,
    team,
    manager,
  ];
}
