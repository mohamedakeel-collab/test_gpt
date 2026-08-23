import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/new_request_result_entity.dart';
import '../params/create_new_request_params.dart';
import '../repositories/new_request_repository.dart';

@injectable
class UpdateRequestUseCase {
  const UpdateRequestUseCase(this._repository);

  final NewRequestRepository _repository;

  Future<Either<Failure, NewRequestResultEntity>> call(
    int id,
    CreateNewRequestParams params,
  ) => _repository.updateRequest(id, params);
}
