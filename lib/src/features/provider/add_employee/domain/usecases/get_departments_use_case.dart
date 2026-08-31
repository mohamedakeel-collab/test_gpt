import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/error/failures.dart';
import '../entities/department_entity.dart';
import '../repositories/departments_repository.dart';

@injectable
class GetDepartmentsUseCase {
  const GetDepartmentsUseCase(this.repository);

  final DepartmentsRepository repository;

  Future<Either<Failure, List<DepartmentEntity>>> call() {
    return repository.getDepartments();
  }
}
