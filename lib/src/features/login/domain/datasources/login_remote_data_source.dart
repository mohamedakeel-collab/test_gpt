import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/login_entity.dart';

/// Abstract contract for authenticating on the remote source.
///
/// Concrete implementation in `data/datasources/` extends `BaseRemoteSource`
/// and calls the unified [request] helper. Keeping the abstract here means
/// use-cases and tests can swap fakes in without touching the data layer.
abstract interface class LoginRemoteDataSource {
  /// Authenticate with an email-or-phone [login] + [password].
  ///
  /// The endpoint is public — no Bearer token needed — so the implementation
  /// must pass `skipAuth: true`. On success the returned [LoginEntity]
  /// carries the Sanctum token for `TokenStorage.save(...)`.
  Future<Either<Failure, LoginEntity>> login({
    required String login,
    required String password,
  });
}