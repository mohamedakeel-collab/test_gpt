import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';

import 'notification_controller.dart';
import 'notification_router.dart';

final class NotificationManager {
  NotificationManager._();
  static final NotificationManager instance = NotificationManager._();

  static const String _isolatePortName = 'notification_action_port';

  ReceivePort? _receivePort;
  late NotificationRouter router;

  Future<void> initialize({
    required NotificationRouter router,
    bool debug = false,
  }) async {
    this.router = router;

    await NotificationController.initializeLocalNotifications(debug: debug);
    await NotificationController.initializeRemoteNotifications(debug: debug);
    await _initializeIsolateReceivePort();
    await NotificationController.startListeningNotificationEvents();
    await _getInitialNotificationAction();
  }

  Future<void> _initializeIsolateReceivePort() async {
    _receivePort = ReceivePort('notification_main_port');

    IsolateNameServer.removePortNameMapping(_isolatePortName);
    IsolateNameServer.registerPortWithName(
      _receivePort!.sendPort,
      _isolatePortName,
    );

    _receivePort!.listen((receivedAction) {
      if (receivedAction is ReceivedAction) {
        NotificationController.routeAction(receivedAction);
      }
    });
  }

  Future<void> _getInitialNotificationAction() async {
    final receivedAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: true);

    if (receivedAction == null) return;
    await NotificationController.routeAction(receivedAction);
  }

  Future<void> requestToken() async {
    await AwesomeNotificationsFcm().requestFirebaseAppToken();
  }

  Future<bool> requestPermissions() async {
    return AwesomeNotifications().requestPermissionToSendNotifications();
  }

  Future<void> dispose() async {
    IsolateNameServer.removePortNameMapping(_isolatePortName);
    _receivePort?.close();
    _receivePort = null;
  }
}
