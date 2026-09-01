import '../../../../../core/shared/extensions/json_extensions.dart';

class EmployeeDetailsManagerModel {
  const EmployeeDetailsManagerModel({required this.id, required this.name});

  final int id;
  final String name;

  factory EmployeeDetailsManagerModel.fromJson(Map<String, dynamic> json) {
    return EmployeeDetailsManagerModel(
      id: json.getInt('id'),
      name: json.getString('full_name', fallback: json.getString('name')),
    );
  }
}
