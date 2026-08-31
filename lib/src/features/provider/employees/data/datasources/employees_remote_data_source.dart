import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/network/base/base_remote_source.dart';
import '../../../../../core/network/error/failures.dart';
import '../../../../../core/network/http_method.dart';
import '../../domain/datasources/employees_remote_data_source.dart';
import '../../domain/entities/employee_entity.dart';
import '../mappers/employee_mapper.dart';
import '../models/employee_model.dart';

@LazySingleton(as: EmployeesRemoteDataSource)
class EmployeesRemoteDataSourceImpl extends BaseRemoteSource
    implements EmployeesRemoteDataSource {
  EmployeesRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<EmployeeEntity>>> getEmployees({
    int? page,
    int? perPage,
    String? search,
  }) {

    final queryParameters = <String, dynamic>{};


    if (page != null) {
      queryParameters['page'] = page;
    }


    if (perPage != null) {
      queryParameters['per_page'] = perPage;
    }


    if (search != null && search.trim().isNotEmpty) {
      queryParameters['search'] = search.trim();
    }


    return request<List<EmployeeEntity>>(
      method: HttpMethod.get,
      endpoint: ApiEndpoints.employees,
      queryParameters: queryParameters,
      fromJson: _parseEmployees,
    );
  }

  static List<EmployeeEntity> _parseEmployees(dynamic json) {
    final list = json is List
        ? json
        : json is Map<String, dynamic>
            ? json['data'] as List?
            : null;

    return (list ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(EmployeeModel.fromJson)
        .map((employee) => employee.toEntity())
        .toList();
  }
}
