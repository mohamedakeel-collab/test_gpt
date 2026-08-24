import '../../../../core/shared/extensions/json_extensions.dart';

class CommentModel {
  const CommentModel({
    required this.id,
    required this.authorFullName,
    required this.commentText,
    this.createdAt,
  });

  final int id;
  final String authorFullName;
  final String commentText;
  final String? createdAt;

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    final author = json.getMap('author');
    return CommentModel(
      id: json.getInt('id'),
      authorFullName: author.getString('full_name').isNotEmpty
          ? author.getString('full_name')
          : json.getString('author_full_name'),
      commentText: json.getString('comment_text').isNotEmpty
          ? json.getString('comment_text')
          : json.getString('comment'),
      createdAt: json.getStringOrNull('created_at'),
    );
  }
}
