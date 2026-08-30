import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/error/failures.dart';
import '../../../../orders/domain/entities/comment_entity.dart';
import '../repositories/request_details_repository.dart';

@injectable
class AddRequestCommentUseCase {
  const AddRequestCommentUseCase(this.repository);

  final RequestDetailsRepository repository;

  Future<Either<Failure, CommentEntity>> call(int requestId, String comment) {
    return repository.addComment(requestId, comment);
  }
}
