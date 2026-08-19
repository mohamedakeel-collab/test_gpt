import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/new_request_result_entity.dart';
import '../params/create_new_request_params.dart';
import '../repositories/new_request_repository.dart';

/// Thin use-case wrapping the single `createRequest` repository call.
@injectable
class CreateNewRequestUseCase {
  const CreateNewRequestUseCase(this._repo);

  final NewRequestRepository _repo;

  Future<Either<Failure, NewRequestResultEntity>> call(
    CreateNewRequestParams params,
  ) =>
      _repo.createRequest(params);
}