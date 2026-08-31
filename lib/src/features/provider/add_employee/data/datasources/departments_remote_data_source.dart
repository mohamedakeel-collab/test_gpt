import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/network/base/base_remote_source.dart';
import '../../../../../core/network/error/failures.dart';
import '../../../../../core/network/http_method.dart';
import '../../domain/datasources/departments_remote_data_source.dart';
import '../../domain/entities/department_entity.dart';
import '../mappers/department_mapper.dart';
import '../models/department_model.dart';

@LazySingleton(as: DepartmentsRemoteDataSource)
class DepartmentsRemoteDataSourceImpl extends BaseRemoteSource
    implements DepartmentsRemoteDataSource {
  DepartmentsRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<DepartmentEntity>>> getDepartments() {
    return request<List<DepartmentEntity>>(
      method: HttpMethod.get,
      endpoint: ApiEndpoints.departments,
      fromJson: _parseDepartments,
    );
  }

  @override
  Future<Either<Failure, List<DepartmentEntity>>> getDepartmentManagers(
    int departmentId,
  ) {
    return request<List<DepartmentEntity>>(
      method: HttpMethod.get,
      endpoint: ApiEndpoints.departmentManagers(departmentId),
      fromJson: _parseDepartmentManagers,
    );
  }

  static List<DepartmentEntity> _parseDepartments(dynamic json) {
    final list = json is Map<String, dynamic>
        ? json['data'] as List?
        : json is List
            ? json
            : null;

    return (list ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(DepartmentModel.fromJson)
        .map((department) => department.toEntity())
        .toList();
  }

  static List<DepartmentEntity> _parseDepartmentManagers(dynamic json) {
    final list = json is Map<String, dynamic>
        ? json['data'] as List?
        : json is List
            ? json
            : null;

    return (list ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(DepartmentModel.fromJson)
        .map(
          (manager) => DepartmentEntity(
            id: manager.id,
            name: manager.managerName,
            managerId: manager.managerId,
            employeesCount: manager.employeesCount,
            managerName: manager.managerName,
            phone: manager.phone,
            position: manager.position,
          ),
        )
        .toList();
  }
}
