import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/error/failures.dart';
import '../../../employees/domain/entities/employee_entity.dart';
import '../params/create_employee_params.dart';
import '../repositories/add_employee_repository.dart';

@injectable
class CreateEmployeeUseCase {
  const CreateEmployeeUseCase(this.repository);

  final AddEmployeeRepository repository;

  Future<Either<Failure, EmployeeEntity>> call(CreateEmployeeParams params) {
    return repository.createEmployee(params);
  }
}
