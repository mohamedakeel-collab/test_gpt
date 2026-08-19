import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/login_entity.dart';

/// Abstract repository — the use-case-facing surface of the login feature.
///
/// Use-cases depend on this, not on the data source directly, so we can add
/// cross-cutting concerns (retry policy, token persistence) inside
/// `LoginRepositoryImpl` without touching anyone's code.
abstract interface class LoginRepository {
  /// Authenticate with an email-or-phone [login] + [password].
  ///
  /// Returns a [LoginEntity] with the token + authenticated user/employee
  /// on success, or a [Failure] (401 → [UnauthorizedFailure], no net →
  /// [NetworkFailure], …).
  Future<Either<Failure, LoginEntity>> login({
    required String login,
    required String password,
  });
}