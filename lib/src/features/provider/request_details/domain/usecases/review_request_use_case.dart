import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/error/failures.dart';
import '../../../../orders/domain/entities/leave_request_entity.dart';
import '../repositories/request_details_repository.dart';

@injectable
class ReviewRequestUseCase {
  const ReviewRequestUseCase(this.repository);

  final RequestDetailsRepository repository;

  Future<Either<Failure, LeaveRequestEntity>> call(int id, String status) {
    return repository.reviewRequest(id, status);
  }
}
