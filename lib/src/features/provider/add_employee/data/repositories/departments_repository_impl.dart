import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/error/failures.dart';
import '../../domain/datasources/departments_remote_data_source.dart';
import '../../domain/entities/department_entity.dart';
import '../../domain/repositories/departments_repository.dart';

@LazySingleton(as: DepartmentsRepository)
class DepartmentsRepositoryImpl implements DepartmentsRepository {
  const DepartmentsRepositoryImpl(this._remote);

  final DepartmentsRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<DepartmentEntity>>> getDepartments() {
    return _remote.getDepartments();
  }

  @override
  Future<Either<Failure, List<DepartmentEntity>>> getDepartmentManagers(
    int departmentId,
  ) {
    return _remote.getDepartmentManagers(departmentId);
  }
}
