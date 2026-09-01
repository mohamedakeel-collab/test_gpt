import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/error/failures.dart';
import '../../domain/entities/employee_details_entity.dart';
import '../../domain/repositories/employee_details_repository.dart';
import '../datasources/employee_details_remote_data_source.dart';
import '../mappers/employee_details_mapper.dart';

@LazySingleton(as: EmployeeDetailsRepository)
class EmployeeDetailsRepositoryImpl implements EmployeeDetailsRepository {
  const EmployeeDetailsRepositoryImpl(this._remote);

  final EmployeeDetailsRemoteDataSource _remote;

  @override
  Future<Either<Failure, EmployeeDetailsEntity>> getEmployeeDetails(int id) async {
    final result = await _remote.getEmployeeDetails(id);
    return result.map((employee) => employee.toEntity());
  }
}
