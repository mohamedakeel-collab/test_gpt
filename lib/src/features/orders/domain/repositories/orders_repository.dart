import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/leave_request_entity.dart';

/// Abstract repository — the use-case-facing surface of the Orders feature.
///
/// Use-cases depend on this, not on the data source directly, so we can
/// add cross-cutting concerns (caching, retry policy, logging) inside
/// `OrdersRepositoryImpl` without touching anyone's code.
abstract interface class OrdersRepository {
  // Reads
  Future<Either<Failure, List<LeaveRequestEntity>>> getOrders({
    String? leaveType,
  });

  // Writes
  Future<Either<Failure, void>> deleteRequest(int id);
}
