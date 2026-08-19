import 'package:equatable/equatable.dart';

/// Pure domain object — the department nested inside the home employee.
class DepartmentEntity extends Equatable {
  final int id;
  final String name;
  final int managerId;

  const DepartmentEntity({
    required this.id,
    required this.name,
    required this.managerId,
  });

  @override
  List<Object?> get props => [id, name, managerId];
}