part of '../imports/remote_work_imports.dart';

@injectable
class AttendanceCubit extends AsyncCubit<List<AttendanceEntity>> {
  AttendanceCubit(this._getAttendance, this._checkIn, this._checkOut);

  final GetAttendanceUseCase _getAttendance;
  final CheckInUseCase _checkIn;
  final CheckOutUseCase _checkOut;

  Future<void> getAttendance() => execute(_getAttendance.call);

  Future<Either<Failure, AttendanceEntity>> checkIn() async {
    final current = lastData ?? const <AttendanceEntity>[];
    final result = await _checkIn();
    return result.fold(Left.new, (record) {
      final exists = current.any((item) => item.id == record.id);
      final updated = exists
          ? current.map((item) => item.id == record.id ? record : item).toList()
          : [record, ...current];
      setData(updated);
      return Right(record);
    });
  }

  Future<Either<Failure, AttendanceEntity>> checkOut() async {
    final current = lastData ?? const <AttendanceEntity>[];
    final result = await _checkOut();
    return result.fold(Left.new, (record) {
      final updated = current
          .map((item) => item.id == record.id ? record : item)
          .toList();
      setData(updated);
      return Right(record);
    });
  }
}
