import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/base/base_remote_source.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/network/http_method.dart';
import '../../domain/datasources/login_remote_data_source.dart';
import '../../domain/entities/login_entity.dart';
import '../mappers/login_mappers.dart';
import '../models/login_model.dart';

/// Concrete login data source — talks to the backend via
/// [BaseRemoteSource.request].
///
/// Notes
///   - Registered as `LoginRemoteDataSource` (the abstract type) so the
///     repository depends on the contract, not the implementation.
///   - `POST /auth/login` is **public** — no Bearer token exists yet —
///     hence `skipAuth: true` (see the AuthInterceptor).
///   - Request body uses the backend contract: `login` = email **or** phone,
///     plus `password`.
///   - We map Model → Entity here so callers never see the wire shape.
@LazySingleton(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl extends BaseRemoteSource
    implements LoginRemoteDataSource {
  LoginRemoteDataSourceImpl();

  @override
  Future<Either<Failure, LoginEntity>> login({
    required String login,
    required String password,
  }) {
    return request<LoginEntity>(
      method: HttpMethod.post,
      endpoint: ApiEndpoints.login,
      skipAuth: true,
      // `login` is "email or phone" — sent verbatim in the backend key.
      body: {'login': login, 'password': password},
      fromJson: _parseLogin,
    );
  }

  static LoginEntity _parseLogin(dynamic json) {
    final data = json is Map<String, dynamic> ? json : <String, dynamic>{};
    return LoginModel.fromJson(data).toEntity();
  }
}