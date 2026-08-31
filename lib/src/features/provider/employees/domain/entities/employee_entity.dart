import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  const EmployeeEntity({
    required this.id,
    required this.fullName,
    required this.image,
    required this.phone,
    required this.position,
    required this.role,
    required this.department,
    required this.hasPendingRequests,
  });

  final int id;
  final String fullName;
  final String image;
  final String phone;
  final String position;
  final String role;
  final String department;
  final bool hasPendingRequests;

  factory EmployeeEntity.initial() => const EmployeeEntity(
        id: 0,
        fullName: '',
        image: '',
        phone: '',
        position: '',
        role: '',
        department: '',
        hasPendingRequests: false,
      );

  @override
  List<Object?> get props => [
        id,
        fullName,
        image,
        phone,
        position,
        role,
        department,
        hasPendingRequests,
      ];
}
