import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final int id;
  final String comment;
  final DateTime? createdAt;
  final String authorFullName;

  const CommentEntity({
    required this.id,
    required this.comment,
    this.createdAt,
    this.authorFullName = '',
  });

  @override
  List<Object?> get props => [
    id,
    comment,
    createdAt,
    authorFullName,
  ];
}