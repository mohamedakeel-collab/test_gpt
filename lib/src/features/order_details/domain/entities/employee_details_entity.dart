import 'package:equatable/equatable.dart';

class EmployeeDetailsEntity extends Equatable {
  const EmployeeDetailsEntity({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.position,
    required this.leaveBalance,
    required this.permissionHours,
    required this.remainingLeaveBalance,
    this.image,
  });

  final int id;
  final String fullName;
  final String phone;
  final String position;
  final int leaveBalance;
  final int permissionHours;
  final int remainingLeaveBalance;
  final String? image;

  factory EmployeeDetailsEntity.initial() => const EmployeeDetailsEntity(
    id: 0,
    fullName: '',
    phone: '',
    position: '',
    leaveBalance: 0,
    remainingLeaveBalance: 0,
    permissionHours: 0,
  );

  @override
  List<Object?> get props => [
    id,
    fullName,
    phone,
    position,
    leaveBalance,
    remainingLeaveBalance,
    permissionHours,
    image,
  ];
}
