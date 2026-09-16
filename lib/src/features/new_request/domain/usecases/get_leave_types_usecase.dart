import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/leave_type_entity.dart';
import '../repositories/leave_type_repository.dart';

@lazySingleton
class GetLeaveTypesUseCase {
  GetLeaveTypesUseCase(this._repository);

  final LeaveTypeRepository _repository;

  Future<Either<Failure, List<LeaveTypeEntity>>> call() =>
      _repository.getLeaveTypes();
}
