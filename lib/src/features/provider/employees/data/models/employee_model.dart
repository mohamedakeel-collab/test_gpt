import '../../../../../core/shared/extensions/json_extensions.dart';

class EmployeeModel {
  const EmployeeModel({
    required this.id,
    required this.fullName,
    required this.image,
    required this.phone,
    required this.position,
    required this.role,
    required this.department,
    required this.hasPendingRequests,
  });

  final int id;
  final String fullName;
  final String image;
  final String phone;
  final String position;
  final String role;
  final String department;
  final bool hasPendingRequests;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        id: json.getInt('id'),
        fullName: json.getString('full_name'),
        image: json.getString('image'),
        phone: json.getString('phone'),
        position: json.getString('position'),
        role: json.getString('role'),
        department: json.getString('department'),
        hasPendingRequests: json.getBool('has_pending_requests'),
      );
}
