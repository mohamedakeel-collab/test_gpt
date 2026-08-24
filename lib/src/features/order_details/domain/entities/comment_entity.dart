import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  const CommentEntity({
    required this.id,
    required this.authorFullName,
    required this.commentText,
    this.createdAt,
  });

  final int id;
  final String authorFullName;
  final String commentText;
  final String? createdAt;

  factory CommentEntity.initial() =>
      const CommentEntity(id: 0, authorFullName: '', commentText: '');

  @override
  List<Object?> get props => [id, authorFullName, commentText, createdAt];
}
