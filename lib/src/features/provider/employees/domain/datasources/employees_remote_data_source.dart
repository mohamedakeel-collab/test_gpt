import 'package:dartz/dartz.dart';

import '../../../../../core/network/error/failures.dart';
import '../entities/employee_entity.dart';

abstract interface class EmployeesRemoteDataSource {
  Future<Either<Failure, List<EmployeeEntity>>> getEmployees({
    int? page,
    int? perPage,
    String? search,
  });
}
