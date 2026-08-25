import '../../../../core/shared/extensions/json_extensions.dart';

class NotificationModel {
  const NotificationModel({
    required this.id,
    required this.title,
    required this.text,
    required this.createdAt,
    required this.type,
    required this.isRead,
    required this.readAt,
  });

  final int id;
  final String title;
  final String text;
  final DateTime? createdAt;
  final String type;
  final bool isRead;
  final DateTime? readAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json.getInt('id'),
        title: json.getString('title'),
        text: json.getString('text'),
        createdAt: json.getDateTime('created_at'),
        type: json.getString('type', fallback: 'system'),
        isRead: json.getBool(
          'is_read',
          fallback: json.getStringOrNull('read_at') != null,
        ),
        readAt: json.getDateTime('read_at'),
      );
}
