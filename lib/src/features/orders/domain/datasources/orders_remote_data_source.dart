import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/leave_request_entity.dart';

/// Abstract contract for fetching leave requests from a remote source.
///
/// Concrete implementation in `data/datasources/` extends `BaseRemoteSource`
/// (Dio + cancellation). Keeping the abstract here means use-cases and
/// tests can swap fakes in without touching the data layer.
abstract interface class OrdersRemoteDataSource {
  // Reads
  Future<Either<Failure, List<LeaveRequestEntity>>> getOrders({
    String? leaveType,
  });

  // Writes
  Future<Either<Failure, void>> deleteRequest(int id);
}
