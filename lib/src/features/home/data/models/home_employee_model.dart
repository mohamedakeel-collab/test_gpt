import '../../../../core/shared/extensions/json_extensions.dart';
import 'home_department_model.dart';
import 'home_team_model.dart';
import 'home_user_model.dart';

/// DTO mirroring the `employee` object returned by the Home API.
///
/// The nested `manager` reuses this same type because the wire shape of a
/// manager is identical to an employee's top-level fields.
class HomeEmployeeModel {
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
  final HomeUserModel? user;
  final HomeDepartmentModel? department;
  final HomeTeamModel? team;
  final HomeEmployeeModel? manager;

  const HomeEmployeeModel({
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

  factory HomeEmployeeModel.fromJson(Map<String, dynamic> json) =>
      HomeEmployeeModel(
        id: json.getInt('id'),
        fullName: json.getString('full_name'),
        phone: json.getString('phone'),
        position: json.getString('position'),
        departmentId: json.getInt('department_id'),
        teamId: json.getInt('team_id'),
        managerId: json.getInt('manager_id'),
        remainingLeaveBalance: json.getInt('remaining_leave_balance'),
        balanceExpiration: json.getDateTime('balance_expiration'),
        permissionHours: json.getInt('permission_hours'),
        leaveBalance: json.getInt('leave_balance'),
        user: json.getObject('user', HomeUserModel.fromJson),
        department: json.getObject('department', HomeDepartmentModel.fromJson),
        team: json.getObject('team', HomeTeamModel.fromJson),
        manager: json.getObject('manager', HomeEmployeeModel.fromJson),
      );
}