import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/base/base_remote_source.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/network/http_method.dart';
import '../../domain/datasources/orders_remote_data_source.dart';
import '../../domain/entities/leave_request_entity.dart';
import '../mappers/orders_mapper.dart';
import '../models/leave_request_model.dart';

/// Concrete data source — talks to the backend via [BaseRemoteSource.request].
///
/// Notes
///   - Registered as `OrdersRemoteDataSource` (the abstract type) so the
///     repository depends on the contract, not the implementation.
///   - Every call uses the unified [request] helper — pass the verb +
///     named params, get back `Either<Failure, T>`.
///   - We map Model → Entity here so callers never see the wire shape.
@LazySingleton(as: OrdersRemoteDataSource)
class OrdersRemoteDataSourceImpl extends BaseRemoteSource
    implements OrdersRemoteDataSource {
  OrdersRemoteDataSourceImpl();

  // ── GET list — query params ──────────────────────────────────────
  @override
  Future<Either<Failure, List<LeaveRequestEntity>>> getOrders({
    String? leaveType,
  }) {
    return request<List<LeaveRequestEntity>>(
      method: HttpMethod.get,
      endpoint: ApiEndpoints.myLeaveRequests,

      queryParameters: {
        if (leaveType != null && leaveType.isNotEmpty) 'leave_type': leaveType,
      },
      fromJson: _parseLeaveRequestList,
    );
  }

  // ── DELETE — message-only success response ───────────────────────
  @override
  Future<Either<Failure, void>> deleteRequest(int id) {
    return request<void>(
      method: HttpMethod.delete,
      endpoint: ApiEndpoints.deleteLeaveRequest(id),
      fromJson: (_) {},
    );
  }

  // ── Parsers (kept private to this file) ──────────────────────────

  static List<LeaveRequestEntity> _parseLeaveRequestList(dynamic json) {
    final list = (json is Map ? json['data'] : json) as List? ?? const [];
    return list
        .whereType<Map<String, dynamic>>()
        .map(LeaveRequestModel.fromJson)
        .map((m) => m.toEntity())
        .toList();
  }
}
