import 'package:dartz/dartz.dart';

import '../../../../../core/network/error/failures.dart';
import '../../../../orders/domain/entities/comment_entity.dart';
import '../../../../orders/domain/entities/leave_request_entity.dart';

abstract interface class RequestDetailsRepository {
  Future<Either<Failure, LeaveRequestEntity>> getRequestDetails(int id);

  Future<Either<Failure, List<CommentEntity>>> getComments(int requestId);
}
