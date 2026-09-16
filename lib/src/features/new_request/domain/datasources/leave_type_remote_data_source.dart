import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/leave_type_entity.dart';

abstract interface class LeaveTypeRemoteDataSource {
  Future<Either<Failure, List<LeaveTypeEntity>>> getLeaveTypes();
}
