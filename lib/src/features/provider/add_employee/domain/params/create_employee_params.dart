import 'dart:io';

class CreateEmployeeParams {
  const CreateEmployeeParams({
    this.image,
    required this.fullName,
    required this.position,
    required this.phone,
    required this.departmentId,
    required this.email,
    required this.password,
    required this.managerId,
    required this.remainingLeaveBalance,
    required this.balanceExpiration,
    required this.permissionHours,
    required this.role,
  });

  final File? image;
  final String fullName;
  final String position;
  final String phone;
  final int departmentId;
  final String email;
  final String password;
  final int managerId;
  final int remainingLeaveBalance;
  final String balanceExpiration;
  final int permissionHours;
  final String role;
}
