import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/network/base/base_remote_source.dart';
import '../../../../../core/network/error/failures.dart';
import '../../../../../core/network/http_method.dart';
import '../../domain/params/create_employee_params.dart';
import '../models/employee_create_model.dart';

@LazySingleton()
class AddEmployeeRemoteDataSource extends BaseRemoteSource {
  AddEmployeeRemoteDataSource();

  Future<Either<Failure, EmployeeCreateModel>> createEmployee(
    CreateEmployeeParams params,
  ) async {
    final body = await _buildBody(params);

    return request<EmployeeCreateModel>(
      method: HttpMethod.post,
      endpoint: ApiEndpoints.employees,
      body: body,
      asFormData: true,
      fromJson: _parseEmployee,
    );
  }

  Future<Either<Failure, EmployeeCreateModel>> updateEmployee(
    int id,
    CreateEmployeeParams params,
  ) async {
    final body = await _buildBody(params);

    return request<EmployeeCreateModel>(
      method: HttpMethod.patch,
      endpoint: ApiEndpoints.updateEmployee(id),
      body: body,
      asFormData: true,
      fromJson: _parseEmployee,
    );
  }

  static Future<Map<String, dynamic>> _buildBody(
    CreateEmployeeParams params,
  ) async {
    final body = <String, dynamic>{
      'full_name': params.fullName,
      'position': params.position,
      'phone': params.phone,
      'department_id': params.departmentId,
      'email': params.email,
      'manager_id': params.managerId,
      'remaining_leave_balance': params.remainingLeaveBalance,
      'balance_expiration': params.balanceExpiration,
      'permission_hours': params.permissionHours,
      'role': params.role,
    };

    if (params.password.trim().isNotEmpty) {
      body['password'] = params.password;
    }

    if (params.image != null) {
      body['image'] = await MultipartFile.fromFile(params.image!.path);
    }

    return body;
  }

  static EmployeeCreateModel _parseEmployee(dynamic json) {
    final data = json is Map<String, dynamic>
        ? (json['data'] ?? json) as Map<String, dynamic>
        : <String, dynamic>{};

    return EmployeeCreateModel.fromJson(data);
  }
}
