import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/entities/leave_request_details_entity.dart';
import '../../domain/repositories/order_details_repository.dart';
import '../datasources/order_details_remote_data_source.dart';
import '../mappers/order_details_mapper.dart';

@LazySingleton(as: OrderDetailsRepository)
class OrderDetailsRepositoryImpl implements OrderDetailsRepository {
  const OrderDetailsRepositoryImpl(this._remote);

  final OrderDetailsRemoteDataSource _remote;

  @override
  Future<Either<Failure, LeaveRequestDetailsEntity>> getDetails(int id) async {
    final result = await _remote.getDetails(id);
    return result.map((model) => model.toEntity());
  }
}
