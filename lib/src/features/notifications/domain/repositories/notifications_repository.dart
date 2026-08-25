import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/notification_entity.dart';

abstract interface class NotificationsRepository {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    required int perPage,
  });
}
