import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/leave_request_details_entity.dart';
import '../repositories/order_details_repository.dart';

@injectable
class GetOrderDetailsUseCase {
  const GetOrderDetailsUseCase(this._repo);

  final OrderDetailsRepository _repo;

  Future<Either<Failure, LeaveRequestDetailsEntity>> call(int id) =>
      _repo.getDetails(id);
}
