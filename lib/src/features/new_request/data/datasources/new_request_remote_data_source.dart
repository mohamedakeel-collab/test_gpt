import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/base/base_remote_source.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/network/http_method.dart';
import '../../domain/datasources/new_request_remote_data_source.dart';
import '../../domain/entities/new_request_result_entity.dart';
import '../../domain/params/create_new_request_params.dart';
import '../mappers/new_request_mapper.dart';
import '../models/new_request_response_model.dart';

/// Concrete data source — talks to the backend via [BaseRemoteSource.request].
///
/// Notes
///   - Registered as `NewRequestRemoteDataSource` (the abstract type) so the
///     repository depends on the contract, not the implementation.
///   - Uses multipart `FormData` (via `asFormData: true`) for the optional
///     file upload — no raw Dio here.
///   - Auth (Bearer token) is handled by `TokenStorage` + `AuthInterceptor`;
///     no manual token is added.
///   - Maps Model → Entity here so callers never see the wire shape.
@LazySingleton(as: NewRequestRemoteDataSource)
class NewRequestRemoteDataSourceImpl extends BaseRemoteSource
    implements NewRequestRemoteDataSource {
  NewRequestRemoteDataSourceImpl();

  /// POST /leave-requests/store (multipart/form-data)
  @override
  Future<Either<Failure, NewRequestResultEntity>> createRequest(
    CreateNewRequestParams params,
  ) async {
    return request<NewRequestResultEntity>(
      method: HttpMethod.post,
      endpoint: ApiEndpoints.storeLeaveRequest,
      asFormData: true,
      body: {
        'leave_type': params.leaveType,
        'start_date': _formatDateTime(params.startDate),
        'end_date': _formatDateTime(params.endDate),
        'reason': params.reason,
        if (params.file != null)
          'file': await MultipartFile.fromFile(params.file!.path),
      },
      fromJson: _parseResponse,
    );
  }

  /// PUT /leave-requests/{id} (multipart/form-data)
  @override
  Future<Either<Failure, NewRequestResultEntity>> updateRequest(
    int id,
    CreateNewRequestParams params,
  ) async {
    return request<NewRequestResultEntity>(
      method: HttpMethod.put,
      endpoint: ApiEndpoints.updateLeaveRequest(id),
      asFormData: true,
      body: {
        'leave_type': params.leaveType,
        'start_date': _formatDateTime(params.startDate),
        'end_date': _formatDateTime(params.endDate),
        'reason': params.reason,
        if (params.file != null)
          'file': await MultipartFile.fromFile(params.file!.path),
      },
      fromJson: _parseResponse,
    );
  }

  /// PATCH /leave-requests/{id} (multipart/form-data)
  @override
  Future<Either<Failure, NewRequestResultEntity>> updateProviderRequest(
    int id,
    CreateNewRequestParams params,
  ) async {
    return request<NewRequestResultEntity>(
      method: HttpMethod.patch,
      endpoint: ApiEndpoints.updateLeaveRequest(id),
      asFormData: true,
      body: {
        'leave_type': params.leaveType,
        'start_date': _formatDate(params.startDate),
        'end_date': _formatDate(params.endDate),
        'reason': params.reason,
        if (params.file != null)
          'file': await MultipartFile.fromFile(params.file!.path),
      },
      fromJson: _parseResponse,
    );
  }

  static NewRequestResultEntity _parseResponse(dynamic json) {
    final map = json is Map<String, dynamic>
        ? json
        : json is Map
        ? Map<String, dynamic>.from(json)
        : <String, dynamic>{};
    return NewRequestResponseModel.fromJson(map).toEntity();
  }

  /// `YYYY-MM-DD HH:mm:ss` — the exact wire format the API expects.
  static String _formatDateTime(DateTime date) {
    String pad(int n) => n.toString().padLeft(2, '0');
    return '${date.year}-${pad(date.month)}-${pad(date.day)} '
        '${pad(date.hour)}:${pad(date.minute)}:${pad(date.second)}';
  }

  static String _formatDate(DateTime date) {
    String pad(int n) => n.toString().padLeft(2, '0');
    return '${date.year}-${pad(date.month)}-${pad(date.day)}';
  }
}
