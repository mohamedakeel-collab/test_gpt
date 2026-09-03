import '../../../../core/shared/extensions/json_extensions.dart';

class EmployeeDetailsModel {
  const EmployeeDetailsModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.position,
    required this.leaveBalance,
    required this.remainingLeaveBalance,
    required this.permissionHours,
    this.image,
  });

  final int id;
  final String fullName;
  final String phone;
  final String position;
  final int leaveBalance;
  final int remainingLeaveBalance;
  final int permissionHours;
  final String? image;

  factory EmployeeDetailsModel.fromJson(Map<String, dynamic> json) =>
      EmployeeDetailsModel(
        id: json.getInt('id'),
        fullName: json.getString('full_name'),
        phone: json.getString('phone'),
        position: json.getString('position'),
        remainingLeaveBalance: json.getInt('remaining_leave_balance'),
        leaveBalance: json.getInt('leave_balance'),
        permissionHours: json.getInt('permission_hours'),
        image: json.getStringOrNull('image') ?? json.getStringOrNull('avatar'),
      );
}
