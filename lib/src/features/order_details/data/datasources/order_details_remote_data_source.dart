import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/base/base_remote_source.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/network/http_method.dart';
import '../models/order_details_model.dart';

abstract interface class OrderDetailsRemoteDataSource {
  Future<Either<Failure, OrderDetailsModel>> getDetails(int id);
}

@LazySingleton(as: OrderDetailsRemoteDataSource)
class OrderDetailsRemoteDataSourceImpl extends BaseRemoteSource
    implements OrderDetailsRemoteDataSource {
  OrderDetailsRemoteDataSourceImpl();

  @override
  Future<Either<Failure, OrderDetailsModel>> getDetails(int id) {
    return request<OrderDetailsModel>(
      method: HttpMethod.get,
      endpoint: ApiEndpoints.leaveRequestDetails(id),
      fromJson: _parseDetails,
    );
  }

  static OrderDetailsModel _parseDetails(dynamic json) {
    final data = json is Map<String, dynamic>
        ? (json['data'] ?? json) as Map<String, dynamic>
        : <String, dynamic>{};
    return OrderDetailsModel.fromJson(data);
  }
}
