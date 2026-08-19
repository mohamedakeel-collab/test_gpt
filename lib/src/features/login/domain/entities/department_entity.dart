import 'package:equatable/equatable.dart';

/// Pure domain object for a department — no `fromJson`, no Dio, no Flutter.
///
/// Serialization is handled by `DepartmentModel` in `data/models/` and the
/// `DepartmentMapper` extension in `data/mappers/`.
class DepartmentEntity extends Equatable {
  final int id;
  final String name;
  final int? managerId;

  const DepartmentEntity({
    required this.id,
    required this.name,
    this.managerId,
  });

  factory DepartmentEntity.initial() => const DepartmentEntity(
        id: 0,
        name: '',
      );

  DepartmentEntity copyWith({
    int? id,
    String? name,
    int? managerId,
  }) {
    return DepartmentEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      managerId: managerId ?? this.managerId,
    );
  }

  @override
  List<Object?> get props => [id, name, managerId];
}