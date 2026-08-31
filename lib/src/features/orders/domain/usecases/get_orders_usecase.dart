import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/leave_request_entity.dart';
import '../repositories/orders_repository.dart';

/// Thin use-case wrapping a single repository call.
///
/// Why use-cases exist:
///   - Cubits stay tiny — they only know which use-case to run.
///   - Business rules live here, not in the cubit or the data source.
///   - Easy to unit-test: feed a fake repo, assert the use-case behaviour.
///
/// Returns `Either<Failure, ...>` — the cubit `.execute`s on it.
@injectable
class GetOrdersUseCase {
  const GetOrdersUseCase(this._repo);

  final OrdersRepository _repo;

  /// Callable syntax: `useCase(leaveType: 'sick')`.
  Future<Either<Failure, List<LeaveRequestEntity>>> call({
    int? page,
    int? perPage,
    String? leaveType,
  }) {
    return _repo.getOrders(
      page: page,
      perPage: perPage,
      leaveType: leaveType,
    );
  }
}
