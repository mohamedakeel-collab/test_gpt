import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:flutter/material.dart' hide DismissAction;

import 'models/notification_enums.dart' as app_enums;
import 'models/notification_payload.dart';
import 'notification_manager.dart';
import 'notification_router.dart';

class NotificationController {
  static const String _isolatePortName = 'notification_action_port';

  // ── 1. Initialize Local ─────────────────────────────────────────
  static Future<void> initializeLocalNotifications({bool debug = false}) async {
    await AwesomeNotifications().initialize(
      'resource://drawable/ic_launcher',
      [
        NotificationChannel(
          channelKey: app_enums.NotificationChannel.messaging.name,
          channelName: 'Messaging',
          channelDescription: 'Chat and message notifications',
          importance: NotificationImportance.High,
          defaultColor: Colors.blue,
          ledColor: Colors.blue,
          playSound: true,
          enableVibration: true,
        ),
        NotificationChannel(
          channelKey: app_enums.NotificationChannel.general.name,
          channelName: 'General',
          channelDescription: 'General notifications',
          importance: NotificationImportance.Default,
        ),
        NotificationChannel(
          channelKey: app_enums.NotificationChannel.system.name,
          channelName: 'System',
          channelDescription: 'System alerts',
          importance: NotificationImportance.High,
        ),
      ],
      debug: debug,
    );
  }

  // ── 2. Initialize Remote (FCM) ──────────────────────────────────
  static Future<void> initializeRemoteNotifications({bool debug = false}) async {
    await AwesomeNotificationsFcm().initialize(
      onFcmTokenHandle: myFcmTokenHandle,
      onNativeTokenHandle: myNativeTokenHandle,
      onFcmSilentDataHandle: mySilentDataHandle,
      // licenseKeys removed — no longer required since awesome_notifications_fcm 0.11
      debug: debug,
    );
  }

  // ── 3. Start Listening ──────────────────────────────────────────
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  // ── BG / Terminated Handler ─────────────────────────────────────
  @pragma('vm:entry-point')
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    try {
      final data = silentData.data;
      if (data == null || data.isEmpty) return;

      final payload = NotificationPayload.fromMap(
        Map<String, dynamic>.from(data),
      );
      final content = _buildContent(payload);

      await AwesomeNotifications().createNotification(
        content: content,
        actionButtons: _buildActionButtons(payload),
      );
    } catch (e) {
      debugPrint('mySilentDataHandle error: $e');
    }
  }

  @pragma('vm:entry-point')
  static Future<void> myFcmTokenHandle(String token) async {
    debugPrint('FCM Token: $token');
  }

  @pragma('vm:entry-point')
  static Future<void> myNativeTokenHandle(String token) async {
    debugPrint('Native Token: $token');
  }

  // ── Click Handler ───────────────────────────────────────────────
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    try {
      if (receivedAction.actionType == ActionType.SilentAction ||
          receivedAction.actionType == ActionType.SilentBackgroundAction) {
        await _handleSilentAction(receivedAction);
        return;
      }

      final sendPort = IsolateNameServer.lookupPortByName(_isolatePortName);
      if (sendPort != null) {
        sendPort.send(receivedAction);
        return;
      }

      await routeAction(receivedAction);
    } catch (e) {
      debugPrint('onActionReceivedMethod error: $e');
    }
  }

  @pragma('vm:entry-point')
  static Future<void> onNotificationCreatedMethod(ReceivedNotification n) async {
    debugPrint('Notification created: ${n.id}');
  }

  @pragma('vm:entry-point')
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification n) async {
    debugPrint('Notification displayed: ${n.id}');
  }

  @pragma('vm:entry-point')
  static Future<void> onDismissActionReceivedMethod(ReceivedAction action) async {
    debugPrint('Notification dismissed: ${action.id}');
  }

  // ── Build NotificationContent ───────────────────────────────────
  static NotificationContent _buildContent(NotificationPayload payload) {
    final layout = switch (payload.type) {
      app_enums.NotificationType.media => NotificationLayout.BigPicture,
      app_enums.NotificationType.message => NotificationLayout.BigText,
      app_enums.NotificationType.call => NotificationLayout.Default,
      app_enums.NotificationType.alert => NotificationLayout.Default,
    };

    return NotificationContent(
      id: payload.id.hashCode,
      channelKey: payload.channel.name,
      title: payload.title,
      body: payload.body,
      notificationLayout: layout,
      bigPicture: payload.imageUrl,
      largeIcon: payload.imageUrl,
      category: switch (payload.type) {
        app_enums.NotificationType.message => NotificationCategory.Message,
        app_enums.NotificationType.call => NotificationCategory.Call,
        _ => NotificationCategory.Social,
      },
      payload: Map<String, String>.from(
        payload.data.map((k, v) => MapEntry(k, v.toString())),
      ),
    );
  }

  // ── Build Action Buttons ────────────────────────────────────────
  static List<NotificationActionButton>? _buildActionButtons(
    NotificationPayload payload,
  ) {
    return switch (payload.type) {
      app_enums.NotificationType.call => [
          NotificationActionButton(
            key: 'ACCEPT',
            label: 'قبول',
            color: Colors.green,
          ),
          NotificationActionButton(
            key: 'REJECT',
            label: 'رفض',
            color: Colors.red,
            actionType: ActionType.DismissAction,
          ),
        ],
      _ => null,
    };
  }

  // ── Parse Action from data map ──────────────────────────────────
  static NotificationAction _parseAction(Map<String, String?> data) {
    return switch (data['action_type']) {
      'navigate_chat' => NavigateToChat(data['chat_id'] ?? ''),
      'navigate_screen' => NavigateToScreen(data['route'] ?? '/'),
      'open_url' => OpenUrl(Uri.parse(data['url'] ?? '')),
      _ => const DismissAction(),
    };
  }

  // ── Route Action ────────────────────────────────────────────────
  static Future<void> routeAction(ReceivedAction receivedAction) async {
    final action = _parseAction(receivedAction.payload ?? {});
    await NotificationManager.instance.router.route(action);
  }

  static Future<void> _handleSilentAction(ReceivedAction receivedAction) async {
    debugPrint('Silent action received: ${receivedAction.buttonKeyPressed}');
  }
}
