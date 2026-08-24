import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/base/base_remote_source.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/network/http_method.dart';
import '../models/attendance_model.dart';

abstract interface class AttendanceRemoteDataSource {
  Future<Either<Failure, List<AttendanceModel>>> getAttendance();
}

@LazySingleton(as: AttendanceRemoteDataSource)
class AttendanceRemoteDataSourceImpl extends BaseRemoteSource
    implements AttendanceRemoteDataSource {
  AttendanceRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<AttendanceModel>>> getAttendance() {
    return request<List<AttendanceModel>>(
      method: HttpMethod.get,
      endpoint: ApiEndpoints.myAttendance,
      fromJson: _parseAttendance,
    );
  }

  static List<AttendanceModel> _parseAttendance(dynamic json) {
    final list = json is Map
        ? json['data'] as List?
        : json is List
        ? json
        : null;
    return (list ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(AttendanceModel.fromJson)
        .toList();
  }
}
