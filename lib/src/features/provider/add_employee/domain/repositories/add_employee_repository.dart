import 'package:dartz/dartz.dart';

import '../../../../../core/network/error/failures.dart';
import '../../../employees/domain/entities/employee_entity.dart';
import '../params/create_employee_params.dart';

abstract interface class AddEmployeeRepository {
  Future<Either<Failure, EmployeeEntity>> createEmployee(
    CreateEmployeeParams params,
  );

  Future<Either<Failure, EmployeeEntity>> updateEmployee(
    int id,
    CreateEmployeeParams params,
  );
}
