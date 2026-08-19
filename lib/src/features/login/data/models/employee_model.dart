import '../../../../core/shared/extensions/json_extensions.dart';
import 'department_model.dart';
import 'team_model.dart';

/// DTO mirroring the `employee` object inside the login response `data`.
class EmployeeModel {
  final int id;
  final String fullName;
  final String phone;
  final String position;
  final int? departmentId;
  final int? teamId;
  final int? managerId;
  final int remainingLeaveBalance;
  final DateTime? balanceExpiration;
  final int permissionHours;
  final DepartmentModel? department;
  final TeamModel? team;
  final EmployeeModel? manager;

  const EmployeeModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.position,
    this.departmentId,
    this.teamId,
    this.managerId,
    this.remainingLeaveBalance = 0,
    this.balanceExpiration,
    this.permissionHours = 0,
    this.department,
    this.team,
    this.manager,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        id: json.getInt('id'),
        fullName: json.getString('full_name'),
        phone: json.getString('phone'),
        position: json.getString('position'),
        departmentId: json.getIntOrNull('department_id'),
        teamId: json.getIntOrNull('team_id'),
        managerId: json.getIntOrNull('manager_id'),
        remainingLeaveBalance: json.getInt('remaining_leave_balance'),
        balanceExpiration: json.getDateTime('balance_expiration'),
        permissionHours: json.getInt('permission_hours'),
        department: json.getObject('department', DepartmentModel.fromJson),
        team: json.getObject('team', TeamModel.fromJson),
        manager: json.getObject('manager', EmployeeModel.fromJson),
      );
}