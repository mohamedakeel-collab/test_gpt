import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';

import 'notification_controller.dart';
import 'notification_router.dart';

final class NotificationManager {
  NotificationManager._();

  static final NotificationManager instance =
  NotificationManager._();

  static const String _isolatePortName =
      'notification_action_port';

  ReceivePort? _receivePort;

  late NotificationRouter router;

  bool _initialized = false;

  Future<void> initialize({
    required NotificationRouter router,
    bool debug = false,
  }) async {
    if (_initialized) {
      return;
    }

    this.router = router;

    await NotificationController.initializeLocalNotifications(
      debug: debug,
    );

    await NotificationController.initializeRemoteNotifications(
      debug: debug,
    );

    await _initializeIsolateReceivePort();

    await NotificationController
        .startListeningNotificationEvents();

    await _getInitialNotificationAction();

    _initialized = true;
  }

  Future<void> _initializeIsolateReceivePort() async {
    _receivePort?.close();

    _receivePort = ReceivePort();

    IsolateNameServer.removePortNameMapping(
      _isolatePortName,
    );

    final registered = IsolateNameServer.registerPortWithName(
      _receivePort!.sendPort,
      _isolatePortName,
    );

    if (!registered) {
      return;
    }

    _receivePort!.listen((receivedAction) async {
      if (receivedAction is ReceivedAction) {
        await NotificationController.routeAction(
          receivedAction,
        );
      }
    });
  }

  Future<void> _getInitialNotificationAction() async {
    final receivedAction =
    await AwesomeNotifications().getInitialNotificationAction(
      removeFromActionEvents: true,
    );

    if (receivedAction == null) {
      return;
    }

    await NotificationController.routeAction(
      receivedAction,
    );
  }
  Future<String> requestToken() async {
    return await AwesomeNotificationsFcm()
        .requestFirebaseAppToken();
  }

  Future<bool> requestPermissions() async {
    return AwesomeNotifications()
        .requestPermissionToSendNotifications();
  }

  Future<void> dispose() async {
    IsolateNameServer.removePortNameMapping(
      _isolatePortName,
    );

    _receivePort?.close();
    _receivePort = null;

    _initialized = false;
  }
}