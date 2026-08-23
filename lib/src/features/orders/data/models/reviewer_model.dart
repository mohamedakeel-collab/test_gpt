import '../../../../core/shared/extensions/json_extensions.dart';

/// DTO mirroring the `reviewer` object attached to a leave request.
///
/// Shares the employee's top-level wire shape (same fields, minus the
/// nested department/team/manager).
class ReviewerModel {
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

  const ReviewerModel({
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
  });

  factory ReviewerModel.fromJson(Map<String, dynamic> json) => ReviewerModel(
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
      );
}