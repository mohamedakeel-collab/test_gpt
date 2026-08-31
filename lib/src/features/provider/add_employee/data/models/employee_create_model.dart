import '../../../../../core/shared/extensions/json_extensions.dart';

class EmployeeCreateModel {
  const EmployeeCreateModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.position,
    required this.role,
    required this.image,
  });

  final int id;
  final String fullName;
  final String phone;
  final String position;
  final String role;
  final String image;

  factory EmployeeCreateModel.fromJson(Map<String, dynamic> json) {
    return EmployeeCreateModel(
      id: json.getInt('id'),
      fullName: json.getString('full_name'),
      phone: json.getString('phone'),
      position: json.getString('position'),
      role: json.getString('role'),
      image: json.getString('image'),
    );
  }
}
