import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/error/failures.dart';
import '../../../../orders/domain/entities/leave_request_entity.dart';
import '../repositories/request_details_repository.dart';

@injectable
class GetRequestDetailsUseCase {
  const GetRequestDetailsUseCase(this.repository);

  final RequestDetailsRepository repository;

  Future<Either<Failure, LeaveRequestEntity>> call(int id) {
    return repository.getRequestDetails(id);
  }
}
