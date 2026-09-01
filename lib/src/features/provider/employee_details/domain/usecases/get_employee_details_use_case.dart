import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/error/failures.dart';
import '../entities/employee_details_entity.dart';
import '../repositories/employee_details_repository.dart';

@injectable
class GetEmployeeDetailsUseCase {
  const GetEmployeeDetailsUseCase(this.repository);

  final EmployeeDetailsRepository repository;

  Future<Either<Failure, EmployeeDetailsEntity>> call(int id) {
    return repository.getEmployeeDetails(id);
  }
}
