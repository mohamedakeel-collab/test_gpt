import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/datasources/orders_remote_data_source.dart';
import '../../domain/entities/leave_request_entity.dart';
import '../../domain/repositories/orders_repository.dart';

/// Concrete repository.
///
/// Right now it's a thin pass-through — the remote data source already
/// returns `Either<Failure, T>`. The moment we add a second data source
/// (e.g. a Hive cache, an in-memory mirror) this class is where the
/// "try cache then remote" logic lives — without anyone upstream caring.
@LazySingleton(as: OrdersRepository)
class OrdersRepositoryImpl implements OrdersRepository {
  const OrdersRepositoryImpl(this._remote);

  final OrdersRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<LeaveRequestEntity>>> getOrders({
    int? page,
    int? perPage,
    String? leaveType,
  }) => _remote.getOrders(page: page, perPage: perPage, leaveType: leaveType);

  @override
  Future<Either<Failure, void>> deleteRequest(int id) =>
      _remote.deleteRequest(id);
}
