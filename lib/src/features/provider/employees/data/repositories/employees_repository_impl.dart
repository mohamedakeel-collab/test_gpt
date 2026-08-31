import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/error/failures.dart';
import '../../domain/datasources/employees_remote_data_source.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/repositories/employees_repository.dart';

@LazySingleton(as: EmployeesRepository)
class EmployeesRepositoryImpl implements EmployeesRepository {
  const EmployeesRepositoryImpl(this._remote);

  final EmployeesRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<EmployeeEntity>>> getEmployees({
    int? page,
    int? perPage,
    String? search,
  }) {
    return _remote.getEmployees(
      page: page,
      perPage: perPage,
      search: search,
    );
  }
}
