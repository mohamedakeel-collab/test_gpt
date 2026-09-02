import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_remote_data_source.dart';
import '../mappers/notification_mapper.dart';

@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  const NotificationsRepositoryImpl(this._remote);

  final NotificationsRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    int? page,
    int? perPage,
  }) async {

    final result =
    await _remote.getNotifications(
      page: page,
      perPage: perPage,
    );


    return result.map(
          (items) =>
          items.map(
                (item)=>item.toEntity(),
          ).toList(),
    );

  }
}
