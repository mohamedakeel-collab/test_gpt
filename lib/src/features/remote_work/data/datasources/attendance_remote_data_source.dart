import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/base/base_remote_source.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/network/http_method.dart';
import '../models/attendance_model.dart';

abstract interface class AttendanceRemoteDataSource {
  Future<Either<Failure, List<AttendanceModel>>> getAttendance();

  Future<Either<Failure, AttendanceModel>> checkIn();

  Future<Either<Failure, AttendanceModel>> checkOut();
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

  @override
  Future<Either<Failure, AttendanceModel>> checkIn() {
    return request<AttendanceModel>(
      method: HttpMethod.post,
      endpoint: ApiEndpoints.checkIn,
      fromJson: _parseAttendanceRecord,
    );
  }

  @override
  Future<Either<Failure, AttendanceModel>> checkOut() {
    return request<AttendanceModel>(
      method: HttpMethod.post,
      endpoint: ApiEndpoints.checkOut,
      fromJson: _parseAttendanceRecord,
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

  static AttendanceModel _parseAttendanceRecord(dynamic json) {
    final data = json is Map<String, dynamic>
        ? (json['data'] ?? json) as Map<String, dynamic>
        : <String, dynamic>{};
    return AttendanceModel.fromJson(data);
  }
}
