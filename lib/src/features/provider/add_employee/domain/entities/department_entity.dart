import 'package:equatable/equatable.dart';

class DepartmentEntity extends Equatable {
  const DepartmentEntity({
    required this.id,
    required this.name,
    required this.managerId,
    required this.employeesCount,
    required this.managerName,
    required this.phone,
    required this.position,
  });

  final int id;
  final String name;
  final int? managerId;
  final int employeesCount;
  final String managerName;
  final String phone;
  final String position;

  factory DepartmentEntity.initial() => const DepartmentEntity(
        id: 0,
        name: '',
        managerId: null,
        employeesCount: 0,
        managerName: '',
        phone: '',
        position: '',
      );

  @override
  List<Object?> get props => [
        id,
        name,
        managerId,
        employeesCount,
        managerName,
        phone,
        position,
      ];
}
