import '../../../../core/shared/extensions/json_extensions.dart';

/// DTO mirroring the `department` object nested inside the home employee.
class HomeDepartmentModel {
  final int id;
  final String name;
  final int managerId;

  const HomeDepartmentModel({
    required this.id,
    required this.name,
    required this.managerId,
  });

  factory HomeDepartmentModel.fromJson(Map<String, dynamic> json) =>
      HomeDepartmentModel(
        id: json.getInt('id'),
        name: json.getString('name'),
        managerId: json.getInt('manager_id'),
      );
}