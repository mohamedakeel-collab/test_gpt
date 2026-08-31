import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/error/failures.dart';
import '../entities/department_entity.dart';
import '../repositories/departments_repository.dart';

@injectable
class GetDepartmentManagersUseCase {
  const GetDepartmentManagersUseCase(this.repository);

  final DepartmentsRepository repository;

  Future<Either<Failure, List<DepartmentEntity>>> call(int departmentId) {
    return repository.getDepartmentManagers(departmentId);
  }
}
