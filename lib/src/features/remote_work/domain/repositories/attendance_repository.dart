import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/attendance_entity.dart';

abstract interface class AttendanceRepository {
  Future<Either<Failure, List<AttendanceEntity>>> getAttendance();

  Future<Either<Failure, AttendanceEntity>> checkIn();

  Future<Either<Failure, AttendanceEntity>> checkOut();
}
