import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../../orders/domain/entities/leave_request_entity.dart';

abstract interface class MyTeamRepository {
  Future<Either<Failure, List<LeaveRequestEntity>>> getTeamRequests({
    int? page,
    int? perPage,
    String? status,
  });
}
