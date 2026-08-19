import '../../../../core/shared/extensions/json_extensions.dart';
import 'employee_model.dart';

/// DTO mirroring the JSON shape returned by `POST /auth/login`.
///
/// Response shape (see `Laravel HR Backend.postman_collection.json`):
/// ```json
/// {
///   "message": "Login successful.",
///   "token_type": "Bearer",
///   "token": "1|...",
///   "data": {
///     "id": 2,
///     "email": "engineering.manager@company.com",
///     "role": "manager",
///     "image": "/storage/default.png",
///     "employee": { ... }
///   }
/// }
/// ```
class LoginModel {
  /// Top-level message, e.g. "Login successful.".
  final String message;

  /// `token_type` — typically "Bearer".
  final String tokenType;

  /// The Sanctum access token handed to `TokenStorage.save(...)`.
  final String token;

  // ── Nested `data` object ────────────────────────────────────────

  final int id;
  final String email;
  final String role;
  final String image;
  final EmployeeModel? employee;

  const LoginModel({
    required this.message,
    required this.tokenType,
    required this.token,
    required this.id,
    required this.email,
    required this.role,
    required this.image,
    this.employee,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final data = json.getMap('data');
    return LoginModel(
      message: json.getString('message'),
      tokenType: json.getString('token_type', fallback: 'Bearer'),
      token: json.getString('token'),
      id: data.getInt('id'),
      email: data.getString('email'),
      role: data.getString('role'),
      image: data.getString('image'),
      employee: data.getObject('employee', EmployeeModel.fromJson),
    );
  }
}