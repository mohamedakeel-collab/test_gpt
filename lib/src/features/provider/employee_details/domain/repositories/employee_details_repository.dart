import 'package:dartz/dartz.dart';

import '../../../../../core/network/error/failures.dart';
import '../entities/employee_details_entity.dart';

abstract class EmployeeDetailsRepository {
  Future<Either<Failure, EmployeeDetailsEntity>> getEmployeeDetails(int id);
}
