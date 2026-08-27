import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/new_request_result_entity.dart';
import '../params/create_new_request_params.dart';

/// Contract for the remote create-request call.
///
/// The data layer implements this; the repository depends on the contract,
/// never on Dio or the concrete implementation.
abstract interface class NewRequestRemoteDataSource {
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
