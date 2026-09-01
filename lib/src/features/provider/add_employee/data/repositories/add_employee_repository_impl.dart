import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../employees/domain/entities/employee_entity.dart';
import '../../../../../core/network/error/failures.dart';
import '../../domain/params/create_employee_params.dart';
import '../../domain/repositories/add_employee_repository.dart';
import '../datasources/add_employee_remote_data_source.dart';
import '../mappers/employee_mapper.dart';

@LazySingleton(as: AddEmployeeRepository)
class AddEmployeeRepositoryImpl implements AddEmployeeRepository {
  const AddEmployeeRepositoryImpl(this._remote);

  final AddEmployeeRemoteDataSource _remote;

  @override
  Future<Either<Failure, EmployeeEntity>> createEmployee(
    CreateEmployeeParams params,
  ) async {
    final result = await _remote.createEmployee(params);
    return result.map((employee) => employee.toEntity());
  }

  @override
  Future<Either<Failure, EmployeeEntity>> updateEmployee(
    int id,
    CreateEmployeeParams params,
  ) async {
    final result = await _remote.updateEmployee(id, params);
    return result.map((employee) => employee.toEntity());
  }
}
