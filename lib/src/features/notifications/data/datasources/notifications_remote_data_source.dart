import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/base/base_remote_source.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/network/http_method.dart';
import '../models/notification_model.dart';

abstract interface class NotificationsRemoteDataSource {
  Future<Either<Failure, List<NotificationModel>>> getNotifications({
    required int perPage,
  });
}

@LazySingleton(as: NotificationsRemoteDataSource)
class NotificationsRemoteDataSourceImpl extends BaseRemoteSource
    implements NotificationsRemoteDataSource {
  NotificationsRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications({
    required int perPage,
  }) {
    return request<List<NotificationModel>>(
      method: HttpMethod.get,
      endpoint: ApiEndpoints.notifications,
      queryParameters: {'per_page': perPage},
      fromJson: _parseNotifications,
    );
  }

  static List<NotificationModel> _parseNotifications(dynamic json) {
    final list = (json is Map ? json['data'] : json) as List? ?? const [];
    return list
        .whereType<Map<String, dynamic>>()
        .map(NotificationModel.fromJson)
        .toList();
  }
}
