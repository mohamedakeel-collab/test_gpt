import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/language/languages.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/base/base_remote_source.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/network/http_method.dart';
import '../../../../core/notifications/notification_manager.dart';
import '../../domain/datasources/login_remote_data_source.dart';
import '../../domain/entities/login_entity.dart';
import '../mappers/login_mappers.dart';
import '../models/login_model.dart';

@LazySingleton(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl extends BaseRemoteSource
    implements LoginRemoteDataSource {

  LoginRemoteDataSourceImpl(this._notificationManager);

  final NotificationManager _notificationManager;

  @override
  Future<Either<Failure, LoginEntity>> login({
    required String login,
    required String password,
  }) async {
    final fcmToken = await _notificationManager.requestToken();

    return request<LoginEntity>(
      method: HttpMethod.post,
      endpoint: ApiEndpoints.login,
      skipAuth: true,

      body: {
        'login': login,
        'password': password,
        'fcm_token': fcmToken,
        'lang': Languages.currentLanguage.languageCode,
      },

      fromJson: _parseLogin,
    );
  }

  static LoginEntity _parseLogin(dynamic json) {
    final data = json is Map<String, dynamic>
        ? json
        : <String, dynamic>{};

    return LoginModel.fromJson(data).toEntity();
  }
}