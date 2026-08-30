import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../mappers/my_team_mapper.dart';
import '../../../orders/domain/entities/leave_request_entity.dart';
import '../../domain/repositories/my_team_repository.dart';
import '../datasources/my_team_remote_data_source.dart';

@LazySingleton(as: MyTeamRepository)
class MyTeamRepositoryImpl implements MyTeamRepository {
  const MyTeamRepositoryImpl(this._remote);

  final MyTeamRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<LeaveRequestEntity>>> getTeamRequests({
    int? perPage,
    String? status,
  }) async {
    final result = await _remote.getTeamRequests(
      perPage: perPage,
      status: status,
    );
    return result.map((items) => items.toEntities());
  }
}
