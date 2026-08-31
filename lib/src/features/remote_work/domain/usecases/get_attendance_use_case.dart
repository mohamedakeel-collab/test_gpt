import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

@injectable
class GetAttendanceUseCase {
  const GetAttendanceUseCase(this._repository);

  final AttendanceRepository _repository;

  Future<Either<Failure, List<AttendanceEntity>>> call({
    int? page,
    int? perPage,
  }) {
    return _repository.getAttendance(
      page: page,
      perPage: perPage,
    );
  }
}
