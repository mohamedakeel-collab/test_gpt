import 'package:awesome_notifications/awesome_notifications.dart'
    hide NotificationChannel;

import 'notification_enums.dart';

final class NotificationPayload {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final NotificationChannel channel;
  final String? imageUrl;
  final Map<String, dynamic> data;
  final DateTime receivedAt;

  const NotificationPayload({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.channel,
    required this.receivedAt,
    this.imageUrl,
    this.data = const {},
  });

  factory NotificationPayload.fromMap(Map<String, dynamic> data) {
    return NotificationPayload(
      id: (data['id']?.toString()) ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: data['title']?.toString() ?? '',
      body: data['body']?.toString() ?? '',
      type: _parseEnum(
        NotificationType.values,
        data['type']?.toString(),
        NotificationType.message,
      ),
      channel: _parseEnum(
        NotificationChannel.values,
        data['channel']?.toString(),
        NotificationChannel.general,
      ),
      imageUrl: data['image_url']?.toString(),
      data: Map<String, dynamic>.from(data),
      receivedAt: DateTime.now(),
    );
  }

  factory NotificationPayload.fromReceivedNotification(ReceivedNotification n) {
    final payloadMap = <String, dynamic>{
      if (n.payload != null) ...n.payload!,
      'title': n.title ?? '',
      'body': n.body ?? '',
    };
    return NotificationPayload(
      id: n.id?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: n.title ?? '',
      body: n.body ?? '',
      type: _parseEnum(
        NotificationType.values,
        payloadMap['type']?.toString(),
        NotificationType.message,
      ),
      channel: _parseEnum(
        NotificationChannel.values,
        n.channelKey,
        NotificationChannel.general,
      ),
      imageUrl: n.bigPicture ?? n.largeIcon,
      data: payloadMap,
      receivedAt: DateTime.now(),
    );
  }

  static T _parseEnum<T extends Enum>(List<T> values, String? raw, T fallback) {
    if (raw == null || raw.isEmpty) return fallback;
    for (final v in values) {
      if (v.name == raw) return v;
    }
    return fallback;
  }
}
