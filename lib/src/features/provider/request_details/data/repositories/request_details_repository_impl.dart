import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/error/failures.dart';
import '../../../../orders/data/mappers/orders_mapper.dart';
import '../../../../orders/domain/entities/comment_entity.dart';
import '../../../../orders/domain/entities/leave_request_entity.dart';
import '../../domain/repositories/request_details_repository.dart';
import '../datasources/request_details_remote_data_source.dart';

@LazySingleton(as: RequestDetailsRepository)
class RequestDetailsRepositoryImpl implements RequestDetailsRepository {
  const RequestDetailsRepositoryImpl(this._remote);

  final RequestDetailsRemoteDataSource _remote;

  @override
  Future<Either<Failure, LeaveRequestEntity>> getRequestDetails(int id) {
    return _remote.getRequestDetails(id).then(
          (result) => result.map((model) => model.toEntity()),
        );
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(int requestId) {
    return _remote.getComments(requestId).then(
          (result) => result.map(
            (models) => models.map((model) => model.toEntity()).toList(),
          ),
        );
  }
}
