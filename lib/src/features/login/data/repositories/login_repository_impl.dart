import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/datasources/login_remote_data_source.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repository.dart';

/// Concrete repository — a thin pass-through to the remote data source.
///
/// The moment we add a second source (e.g. caching the last logged-in user,
/// or an offline login attempt queue) this class is where the orchestration
/// lives — without anyone upstream caring.
@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  const LoginRepositoryImpl(this._remote);

  final LoginRemoteDataSource _remote;

  @override
  Future<Either<Failure, LoginEntity>> login({
    required String login,
    required String password,
  }) =>
      _remote.login(login: login, password: password);
}