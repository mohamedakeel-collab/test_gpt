import 'package:equatable/equatable.dart';

import 'employee_entity.dart';

/// Pure domain object representing the full login session payload —
/// no `fromJson`, no Dio, no Flutter.
///
/// Serialization is handled by `LoginModel` in `data/models/` and the
/// `LoginMapper` extension in `data/mappers/`. The access token lives here
/// so callers can hand it straight to `TokenStorage.save(...)`.
class LoginEntity extends Equatable {
  final String message;
  final String tokenType;
  final String token;
  final int id;
  final String email;
  final String role;
  final String image;
  final EmployeeEntity? employee;

  const LoginEntity({
    required this.message,
    required this.tokenType,
    required this.token,
    required this.id,
    required this.email,
    required this.role,
    required this.image,
    this.employee,
  });

  factory LoginEntity.initial() => const LoginEntity(
    message: '',
    tokenType: '',
    token: '',
    id: 0,
    email: '',
    role: '',
    image: '',
  );

  LoginEntity copyWith({
    String? message,
    String? tokenType,
    String? token,
    int? id,
    String? email,
    String? role,
    String? image,
    EmployeeEntity? employee,
  }) {
    return LoginEntity(
      message: message ?? this.message,
      tokenType: tokenType ?? this.tokenType,
      token: token ?? this.token,
      id: id ?? this.id,
      email: email ?? this.email,
      role: role ?? this.role,
      image: image ?? this.image,
      employee: employee ?? this.employee,
    );
  }

  @override
  List<Object?> get props => [
    message,
    tokenType,
    token,
    id,
    email,
    role,
    image,
    employee,
  ];
}
