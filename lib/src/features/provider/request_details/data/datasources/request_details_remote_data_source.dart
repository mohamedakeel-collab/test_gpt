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

  Future<Either<Failure, LeaveRequestModel>> reviewRequest(
    int id,
    String status,
  );

  Future<Either<Failure, List<CommentModel>>> getComments(int requestId);

  Future<Either<Failure, CommentModel>> addComment(
    int requestId,
    String comment,
  );
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
  Future<Either<Failure, LeaveRequestModel>> reviewRequest(
    int id,
    String status,
  ) {
    return request<LeaveRequestModel>(
      method: HttpMethod.post,
      endpoint: ApiEndpoints.reviewLeaveRequest(id),
      body: {'status': status},
      fromJson: _parseReviewRequest,
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

  @override
  Future<Either<Failure, CommentModel>> addComment(
    int requestId,
    String comment,
  ) {
    return request<CommentModel>(
      method: HttpMethod.post,
      endpoint: ApiEndpoints.leaveRequestComments(requestId),
      body: {'comment_text': comment},
      fromJson: _parseComment,
    );
  }

  static LeaveRequestModel _parseDetails(dynamic json) {
    final data = json is Map<String, dynamic>
        ? (json['data'] ?? json) as Map<String, dynamic>
        : <String, dynamic>{};
    return LeaveRequestModel.fromJson(data);
  }

  static LeaveRequestModel _parseReviewRequest(dynamic json) {
    final map = json is Map<String, dynamic>
        ? (json['data'] ?? json) as Map<String, dynamic>
        : <String, dynamic>{};
    return LeaveRequestModel.fromJson(map);
  }

  static List<CommentModel> _parseComments(dynamic json) {
    final list = (json is Map ? json['data'] : json) as List? ?? const [];
    return list
        .whereType<Map<String, dynamic>>()
        .map(CommentModel.fromJson)
        .toList();
  }

  static CommentModel _parseComment(dynamic json) {
    final data = json is Map<String, dynamic>
        ? (json['data'] ?? json) as Map<String, dynamic>
        : <String, dynamic>{};
    return CommentModel.fromJson(data);
  }
}
