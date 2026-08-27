import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/new_request_result_entity.dart';
import '../params/create_new_request_params.dart';
import '../repositories/new_request_repository.dart';

@injectable
class UpdateProviderRequestUseCase {
  const UpdateProviderRequestUseCase(this.repository);

  final NewRequestRepository repository;

  Future<Either<Failure, NewRequestResultEntity>> call(
    int id,
    CreateNewRequestParams params,
  ) {
    return repository.updateProviderRequest(id, params);
  }
}
