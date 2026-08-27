import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/error/failures.dart';
import '../../../../orders/domain/entities/comment_entity.dart';
import '../repositories/request_details_repository.dart';

@injectable
class GetRequestCommentsUseCase {
  const GetRequestCommentsUseCase(this.repository);

  final RequestDetailsRepository repository;

  Future<Either<Failure, List<CommentEntity>>> call(int requestId) {
    return repository.getComments(requestId);
  }
}
