import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/base/base_remote_source.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/network/http_method.dart';
import '../../domain/datasources/leave_type_remote_data_source.dart';
import '../../domain/entities/leave_type_entity.dart';
import '../mappers/leave_type_mapper.dart';
import '../models/leave_type_model.dart';

@LazySingleton(as: LeaveTypeRemoteDataSource)
class LeaveTypeRemoteDataSourceImpl extends BaseRemoteSource
    implements LeaveTypeRemoteDataSource {
  LeaveTypeRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<LeaveTypeEntity>>> getLeaveTypes() {
    return request<List<LeaveTypeEntity>>(
      method: HttpMethod.get,
      endpoint: ApiEndpoints.leaveTypes,
      fromJson: _parseLeaveTypes,
    );
  }

  static List<LeaveTypeEntity> _parseLeaveTypes(dynamic json) {
    final list = json is Map<String, dynamic>
        ? json['data'] as List?
        : json is List
        ? json
        : null;

    return (list ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(LeaveTypeModel.fromJson)
        .map((leaveType) => leaveType.toEntity())
        .toList();
  }
}
