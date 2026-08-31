import '../../../../core/shared/extensions/json_extensions.dart';
import 'package:intl/intl.dart';

class CommentModel {
  final int id;
  final String comment;
  final DateTime? createdAt;
  final String authorFullName;

  const CommentModel({
    required this.id,
    required this.comment,
    this.createdAt,
    this.authorFullName = '',
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    id: json.getInt('id'),
    comment: json.getString(
      'comment_text',
      fallback: json.getString('comment'),
    ),
    createdAt: _parseDate(json.getStringOrNull('created_at')),
    authorFullName: json.getMap('author').getString('full_name'),
  );

  static DateTime? _parseDate(String? value) {
    if (value == null || value.isEmpty) return null;

    try {
      return DateTime.parse(value).toLocal();
    } catch (_) {
      return null;
    }
  }

  String get formattedCreatedAt {
    if (createdAt == null) return '';

    return DateFormat(
      'dd MMM yyyy - hh:mm a',
      'ar',
    ).format(createdAt!);
  }
}