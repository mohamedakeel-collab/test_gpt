import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repository.dart';

/// Authenticates the user with email/phone + password.
///
/// One-shot use case — the cubit calls it and folds the `Either` to
/// Loading → Success/Failure.
@injectable
class LoginUseCase {
  const LoginUseCase(this._repo);

  final LoginRepository _repo;

  Future<Either<Failure, LoginEntity>> call({
    required String login,
    required String password,
  }) {
    return _repo.login(login: login, password: password);
  }
}
