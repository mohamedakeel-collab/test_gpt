import 'package:equatable/equatable.dart';

/// Pure domain object — the auth user nested inside an employee/reviewer.
class UserEntity extends Equatable {
  final int id;
  final String email;
  final String role;
  final String lang;
  final String? image;

  const UserEntity({
    required this.id,
    required this.email,
    required this.role,
    required this.lang,
    this.image,
  });

  @override
  List<Object?> get props => [id, email, role, lang, image];
}