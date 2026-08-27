import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/base/base_remote_source.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/network/http_method.dart';
import '../../../orders/data/models/leave_request_model.dart';

abstract interface class MyTeamRemoteDataSource {
  Future<Either<Failure, List<LeaveRequestModel>>> getTeamRequests({
    int? perPage,
    String? status,
  });

  Future<Either<Failure, LeaveRequestModel>> reviewRequest(
    int id,
    String status,
  );
}

@LazySingleton(as: MyTeamRemoteDataSource)
class MyTeamRemoteDataSourceImpl extends BaseRemoteSource
    implements MyTeamRemoteDataSource {
  MyTeamRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<LeaveRequestModel>>> getTeamRequests({
    int? perPage,
    String? status,
  }) {
    final queryParameters = <String, dynamic>{'per_page': perPage ?? 15};
    if (status?.isNotEmpty == true) {
      queryParameters['status'] = status;
    }

    return request<List<LeaveRequestModel>>(
      method: HttpMethod.get,
      endpoint: ApiEndpoints.leaveRequests,
      queryParameters: queryParameters,
      fromJson: _parseTeamRequests,
    );
  }

  @override
  Future<Either<Failure, LeaveRequestModel>> reviewRequest(
    int id,
    String status,
  ) {
    return request<LeaveRequestModel>(
      method: HttpMethod.patch,
      endpoint: ApiEndpoints.reviewLeaveRequest(id),
      body: {'status': status},
      fromJson: _parseReviewRequest,
    );
  }

  static List<LeaveRequestModel> _parseTeamRequests(dynamic json) {
    final list = (json is Map ? json['data'] : json) as List? ?? const [];
    return list
        .whereType<Map<String, dynamic>>()
        .map(LeaveRequestModel.fromJson)
        .toList();
  }

  static LeaveRequestModel _parseReviewRequest(dynamic json) {
    final map = json is Map<String, dynamic>
        ? (json['data'] ?? json) as Map<String, dynamic>
        : <String, dynamic>{};
    return LeaveRequestModel.fromJson(map);
  }
}
