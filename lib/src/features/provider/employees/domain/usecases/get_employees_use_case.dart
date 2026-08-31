import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/error/failures.dart';
import '../entities/employee_entity.dart';
import '../repositories/employees_repository.dart';

@injectable
class GetEmployeesUseCase {
  const GetEmployeesUseCase(this.repository);

  final EmployeesRepository repository;

  Future<Either<Failure, List<EmployeeEntity>>> call({
    int? page,
    int? perPage,
    String? search,
  }) {
    return repository.getEmployees(
      page: page,
      perPage: perPage,
      search: search,
    );
  }
}
