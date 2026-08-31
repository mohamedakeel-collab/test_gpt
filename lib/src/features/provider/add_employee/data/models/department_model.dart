import '../../../../../core/shared/extensions/json_extensions.dart';

class DepartmentModel {
  const DepartmentModel({
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

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    final manager = json.getMapOrNull('manager');
    final fullName = json.getString('full_name');
    final name = json.getString('name').isNotEmpty ? json.getString('name') : fullName;

    return DepartmentModel(
      id: json.getInt('id'),
      name: name,
      managerId: json.getIntOrNull('manager_id'),
      employeesCount: json.getInt('employees_count'),
      managerName: manager?.getString('full_name') ?? fullName,
      phone: manager?.getString('phone') ?? json.getString('phone'),
      position: manager?.getString('position') ?? json.getString('position'),
    );
  }
}
