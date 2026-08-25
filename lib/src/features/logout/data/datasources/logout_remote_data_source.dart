import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/base/base_remote_source.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/network/http_method.dart';

abstract interface class LogOutRemoteDataSource {
  Future<Either<Failure, String>> logout();
}

@LazySingleton(as: LogOutRemoteDataSource)
class LogOutRemoteDataSourceImpl extends BaseRemoteSource
    implements LogOutRemoteDataSource {
  LogOutRemoteDataSourceImpl();

  @override
  Future<Either<Failure, String>> logout() {
    return request<String>(
      method: HttpMethod.post,
      endpoint: ApiEndpoints.logout,
      fromJson: _parseLogoutMessage,
    );
  }

  static String _parseLogoutMessage(dynamic json) {
    if (json is Map<String, dynamic>) {
      return json['message']?.toString() ?? '';
    }
    return '';
  }
}
