import 'package:equatable/equatable.dart';

/// Pure domain object — a single comment attached to a leave request.
///
/// Serialization is handled by `CommentModel` in `data/models/` and the
/// `OrdersMapper` extension in `data/mappers/`.
class CommentEntity extends Equatable {
  final int id;
  final String comment;
  final String? createdAt;
  final String authorFullName;

  const CommentEntity({
    required this.id,
    required this.comment,
    this.createdAt,
    this.authorFullName = '',
  });

  @override
  List<Object?> get props => [id, comment, createdAt, authorFullName];
}
