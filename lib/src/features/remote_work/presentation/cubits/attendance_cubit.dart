part of '../imports/remote_work_imports.dart';

@injectable
class AttendanceCubit extends AsyncCubit<List<AttendanceEntity>> {
  AttendanceCubit(this._useCase);

  final GetAttendanceUseCase _useCase;

  Future<void> getAttendance() => execute(_useCase.call);
}
