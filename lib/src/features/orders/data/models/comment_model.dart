import '../../../../core/shared/extensions/json_extensions.dart';

/// DTO mirroring the `comment` object nested inside a leave request.
///
/// Uses the `JsonGetters` extension to read every field — never throws,
/// always gives back a sensible fallback when a key is missing or mistyped.
class CommentModel {
  final int id;
  final String comment;
  final String? createdAt;

  const CommentModel({
    required this.id,
    required this.comment,
    this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json.getInt('id'),
        comment: json.getString('comment'),
        createdAt: json.getStringOrNull('created_at'),
      );
}