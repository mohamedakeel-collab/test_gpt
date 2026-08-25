part of '../imports/notifications_imports.dart';

@injectable
class NotificationsCubit extends AsyncCubit<List<NotificationEntity>> {
  NotificationsCubit(this._getNotifications);

  final GetNotificationsUseCase _getNotifications;

  Future<void> getNotifications({int perPage = 20}) {
    return execute(() => _getNotifications(perPage: perPage));
  }
}
