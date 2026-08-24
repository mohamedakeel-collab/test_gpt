import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/leave_request_details_entity.dart';

abstract interface class OrderDetailsRepository {
  Future<Either<Failure, LeaveRequestDetailsEntity>> getDetails(int id);
}
