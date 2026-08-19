import '../../../../core/shared/extensions/json_extensions.dart';

/// DTO mirroring the `department` object nested inside the employee.
class DepartmentModel {
  final int id;
  final String name;
  final int? managerId;

  const DepartmentModel({
    required this.id,
    required this.name,
    this.managerId,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      DepartmentModel(
        id: json.getInt('id'),
        name: json.getString('name'),
        managerId: json.getIntOrNull('manager_id'),
      );
}