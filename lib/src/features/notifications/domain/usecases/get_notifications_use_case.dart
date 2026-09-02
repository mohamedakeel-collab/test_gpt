import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/notification_entity.dart';
import '../repositories/notifications_repository.dart';

@injectable
class GetNotificationsUseCase {
  const GetNotificationsUseCase(this._repository);

  final NotificationsRepository _repository;

  Future<Either<Failure, List<NotificationEntity>>> call({
    int? page,
    int? perPage,
  }) {

    return _repository.getNotifications(
      page: page,
      perPage: perPage ?? 20,
    );

  }
}
