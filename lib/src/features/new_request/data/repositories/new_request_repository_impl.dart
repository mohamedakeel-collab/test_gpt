import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/datasources/new_request_remote_data_source.dart';
import '../../domain/entities/new_request_result_entity.dart';
import '../../domain/params/create_new_request_params.dart';
import '../../domain/repositories/new_request_repository.dart';

/// Concrete repository — a thin pass-through to the remote data source,
/// which already returns `Either<Failure, T>`.
@LazySingleton(as: NewRequestRepository)
class NewRequestRepositoryImpl implements NewRequestRepository {
  const NewRequestRepositoryImpl(this._remote);

  final NewRequestRemoteDataSource _remote;

  @override
  Future<Either<Failure, NewRequestResultEntity>> createRequest(
    CreateNewRequestParams params,
  ) =>
      _remote.createRequest(params);
}