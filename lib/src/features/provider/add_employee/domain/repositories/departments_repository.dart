import 'package:dartz/dartz.dart';

import '../../../../../core/network/error/failures.dart';
import '../entities/department_entity.dart';

abstract interface class DepartmentsRepository {
  Future<Either<Failure, List<DepartmentEntity>>> getDepartments();

  Future<Either<Failure, List<DepartmentEntity>>> getDepartmentManagers(
    int departmentId,
  );
}
