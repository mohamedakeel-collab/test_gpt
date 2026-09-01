import '../../../../../core/shared/extensions/json_extensions.dart';

class EmployeeDetailsDepartmentModel {
  const EmployeeDetailsDepartmentModel({required this.id, required this.name});

  final int id;
  final String name;

  factory EmployeeDetailsDepartmentModel.fromJson(Map<String, dynamic> json) {
    return EmployeeDetailsDepartmentModel(
      id: json.getInt('id'),
      name: json.getString('name'),
    );
  }
}
