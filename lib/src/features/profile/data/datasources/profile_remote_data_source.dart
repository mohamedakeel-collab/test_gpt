import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/base/base_remote_source.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/network/http_method.dart';
import '../../../login/data/models/login_model.dart';

abstract interface class ProfileRemoteDataSource {
  Future<Either<Failure, LoginModel>> getProfile();
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl extends BaseRemoteSource
    implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl();

  @override
  Future<Either<Failure, LoginModel>> getProfile() {
    return request<LoginModel>(
      method: HttpMethod.get,
      endpoint: ApiEndpoints.profile,
      fromJson: _parseProfile,
    );
  }

  static LoginModel _parseProfile(dynamic json) {
    final data = json is Map<String, dynamic> ? json : <String, dynamic>{};
    return LoginModel.fromJson(data);
  }
}
