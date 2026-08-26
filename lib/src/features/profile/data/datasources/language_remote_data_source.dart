import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/base/base_remote_source.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/network/http_method.dart';
import '../../../login/data/models/login_model.dart';

abstract interface class LanguageRemoteDataSource {
  Future<Either<Failure, LoginModel>> setLanguage(String language);
}

@LazySingleton(as: LanguageRemoteDataSource)
class LanguageRemoteDataSourceImpl extends BaseRemoteSource
    implements LanguageRemoteDataSource {
  LanguageRemoteDataSourceImpl();

  @override
  Future<Either<Failure, LoginModel>> setLanguage(String language) {
    return request<LoginModel>(
      method: HttpMethod.post,
      endpoint: ApiEndpoints.setLanguage,
      body: {'lang': language},
      fromJson: _parseLanguageResponse,
    );
  }

  static LoginModel _parseLanguageResponse(dynamic json) {
    final data = json is Map<String, dynamic> ? json : <String, dynamic>{};
    return LoginModel.fromJson(data);
  }
}
