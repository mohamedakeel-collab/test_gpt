import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/base/base_remote_source.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/network/http_method.dart';
import '../../domain/datasources/home_remote_data_source.dart';
import '../../domain/entities/home_entity.dart';
import '../mappers/home_mapper.dart';
import '../models/home_model.dart';

/// Concrete data source — talks to the backend via [BaseRemoteSource.request].
///
/// Notes
///   - Registered as `HomeRemoteDataSource` (the abstract type) so the
///     repository depends on the contract, not the implementation.
///   - Uses the unified [request] helper — get back `Either<Failure, T>`.
///   - Maps Model → Entity here so callers never see the wire shape.
///   - Auth (Bearer token) is handled by `TokenStorage` + `AuthInterceptor`;
///     no manual token is added.
@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends BaseRemoteSource
    implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl();

  // ── GET /home ────────────────────────────────────────────────────
  @override
  Future<Either<Failure, HomeEntity>> getHome() {
    return request<HomeEntity>(
      method: HttpMethod.get,
      endpoint: ApiEndpoints.home,
      fromJson: _parseHome,
    );
  }

  static HomeEntity _parseHome(dynamic json) {
    final map = json is Map<String, dynamic>
        ? json
        : json is Map
            ? Map<String, dynamic>.from(json)
            : <String, dynamic>{};
    return HomeModel.fromJson(map).toEntity();
  }
}