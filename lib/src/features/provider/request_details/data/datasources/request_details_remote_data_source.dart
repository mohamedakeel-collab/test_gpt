import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/network/base/base_remote_source.dart';
import '../../../../../core/network/error/failures.dart';
import '../../../../../core/network/http_method.dart';
import '../../../../orders/data/models/comment_model.dart';
import '../../../../orders/data/models/leave_request_model.dart';

abstract interface class RequestDetailsRemoteDataSource {
  Future<Either<Failure, LeaveRequestModel>> getRequestDetails(int id);

  Future<Either<Failure, List<CommentModel>>> getComments(int requestId);
}

@LazySingleton(as: RequestDetailsRemoteDataSource)
class RequestDetailsRemoteDataSourceImpl extends BaseRemoteSource
    implements RequestDetailsRemoteDataSource {
  RequestDetailsRemoteDataSourceImpl();

  @override
  Future<Either<Failure, LeaveRequestModel>> getRequestDetails(int id) {
    return request<LeaveRequestModel>(
      method: HttpMethod.get,
      endpoint: ApiEndpoints.leaveRequestDetails(id),
      fromJson: _parseDetails,
    );
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getComments(int requestId) {
    return request<List<CommentModel>>(
      method: HttpMethod.get,
      endpoint: ApiEndpoints.leaveRequestComments(requestId),
      fromJson: _parseComments,
    );
  }

  static LeaveRequestModel _parseDetails(dynamic json) {
    final data = json is Map<String, dynamic>
        ? (json['data'] ?? json) as Map<String, dynamic>
        : <String, dynamic>{};
    return LeaveRequestModel.fromJson(data);
  }

  static List<CommentModel> _parseComments(dynamic json) {
    final list = (json is Map ? json['data'] : json) as List? ?? const [];
    return list
        .whereType<Map<String, dynamic>>()
        .map(CommentModel.fromJson)
        .toList();
  }
}
