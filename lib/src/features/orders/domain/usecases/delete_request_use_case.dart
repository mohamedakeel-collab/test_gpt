import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../repositories/orders_repository.dart';

@injectable
class DeleteRequestUseCase {
  const DeleteRequestUseCase(this._repository);

  final OrdersRepository _repository;

  Future<Either<Failure, void>> call(int id) => _repository.deleteRequest(id);
}
