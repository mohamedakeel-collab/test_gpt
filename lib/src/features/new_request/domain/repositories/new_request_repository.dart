import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/new_request_result_entity.dart';
import '../params/create_new_request_params.dart';

/// Domain contract for submitting a new leave request.
abstract interface class NewRequestRepository {
  Future<Either<Failure, NewRequestResultEntity>> createRequest(
    CreateNewRequestParams params,
  );

  Future<Either<Failure, NewRequestResultEntity>> updateRequest(
    int id,
    CreateNewRequestParams params,
  );

  Future<Either<Failure, NewRequestResultEntity>> updateProviderRequest(
    int id,
    CreateNewRequestParams params,
  );
}
