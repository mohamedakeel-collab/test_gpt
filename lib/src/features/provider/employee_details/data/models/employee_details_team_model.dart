import '../../../../../core/shared/extensions/json_extensions.dart';

class EmployeeDetailsTeamModel {
  const EmployeeDetailsTeamModel({required this.id, required this.name});

  final int id;
  final String name;

  factory EmployeeDetailsTeamModel.fromJson(Map<String, dynamic> json) {
    return EmployeeDetailsTeamModel(
      id: json.getInt('id'),
      name: json.getString('team_name'),
    );
  }
}
