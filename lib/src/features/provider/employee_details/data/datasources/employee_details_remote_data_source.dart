import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/network/base/base_remote_source.dart';
import '../../../../../core/network/error/failures.dart';
import '../../../../../core/network/http_method.dart';
import '../models/employee_details_model.dart';

abstract interface class EmployeeDetailsRemoteDataSource {
  Future<Either<Failure, EmployeeDetailsModel>> getEmployeeDetails(int id);
}

@LazySingleton(as: EmployeeDetailsRemoteDataSource)
class EmployeeDetailsRemoteDataSourceImpl extends BaseRemoteSource
    implements EmployeeDetailsRemoteDataSource {
  EmployeeDetailsRemoteDataSourceImpl();

  @override
  Future<Either<Failure, EmployeeDetailsModel>> getEmployeeDetails(int id) {
    return request<EmployeeDetailsModel>(
      method: HttpMethod.get,
      endpoint: ApiEndpoints.employeeDetails(id),
      fromJson: _parseEmployeeDetails,
    );
  }

  static EmployeeDetailsModel _parseEmployeeDetails(dynamic json) {
    final data = json is Map<String, dynamic>
        ? (json['data'] ?? json) as Map<String, dynamic>
        : <String, dynamic>{};
    return EmployeeDetailsModel.fromJson(data);
  }
}
