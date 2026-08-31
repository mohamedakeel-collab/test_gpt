import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/entities/attendance_entity.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_data_source.dart';
import '../mappers/attendance_mapper.dart';

@LazySingleton(as: AttendanceRepository)
class AttendanceRepositoryImpl implements AttendanceRepository {
  const AttendanceRepositoryImpl(this._remote);

  final AttendanceRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<AttendanceEntity>>> getAttendance({
    int? page,
    int? perPage,
  }) async {
    final result = await _remote.getAttendance(
      page: page,
      perPage: perPage,
    );
    return result.map(
      (records) => records.map((record) => record.toEntity()).toList(),
    );
  }

  @override
  Future<Either<Failure, AttendanceEntity>> checkIn() async {
    final result = await _remote.checkIn();
    return result.map((record) => record.toEntity());
  }

  @override
  Future<Either<Failure, AttendanceEntity>> checkOut() async {
    final result = await _remote.checkOut();
    return result.map((record) => record.toEntity());
  }
}
