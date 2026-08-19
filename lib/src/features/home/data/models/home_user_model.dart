import '../../../../core/shared/extensions/json_extensions.dart';

/// DTO mirroring the `user` object nested inside an employee/reviewer.
class HomeUserModel {
  final int id;
  final String email;
  final String role;
  final String lang;
  final String? image;

  const HomeUserModel({
    required this.id,
    required this.email,
    required this.role,
    required this.lang,
    this.image,
  });

  factory HomeUserModel.fromJson(Map<String, dynamic> json) => HomeUserModel(
        id: json.getInt('id'),
        email: json.getString('email'),
        role: json.getString('role'),
        lang: json.getString('lang'),
        image: json.getStringOrNull('image'),
      );
}