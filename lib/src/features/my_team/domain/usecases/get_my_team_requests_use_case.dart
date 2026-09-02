import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../../../orders/domain/entities/leave_request_entity.dart';
import '../repositories/my_team_repository.dart';

@injectable
class GetMyTeamRequestsUseCase {
  const GetMyTeamRequestsUseCase(this.repository);

  final MyTeamRepository repository;

  Future<Either<Failure, List<LeaveRequestEntity>>> call({
    int? page,
    int? perPage,
    String? status,
    String? leaveType,
  }) {
    return repository.getTeamRequests(
      page: page,
      perPage: perPage,
      status: status,
      leaveType: leaveType
    );
  }
}
