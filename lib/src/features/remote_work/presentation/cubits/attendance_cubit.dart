part of '../imports/remote_work_imports.dart';

@injectable
class AttendanceCubit extends AsyncCubit<List<AttendanceEntity>> {
  AttendanceCubit(this._getAttendance, this._checkIn, this._checkOut);

  final GetAttendanceUseCase _getAttendance;
  final CheckInUseCase _checkIn;
  final CheckOutUseCase _checkOut;

  int _currentPage = 1;
  int _perPage = 15;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  bool get hasMore => _hasMore;

  bool get isLoadingMore => _isLoadingMore;

  Future<void> getAttendance({int? perPage}) async {
    _currentPage = 1;
    _perPage = perPage ?? 15;
    _hasMore = true;
    _isLoadingMore = false;
    clearData();

    final result = await _getAttendance(page: 1, perPage: _perPage);
    result.fold(
      (failure) {
        if (failure is CancelledFailure) return;
        setFailure(failure);
      },
      (records) {
        _hasMore = records.isNotEmpty;
        setData(_dedupeById(records));
      },
    );
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore || lastData == null) {
      return;
    }

    final current = lastData ?? const <AttendanceEntity>[];
    final nextPage = _currentPage + 1;
    _isLoadingMore = true;
    emit(AsyncLoading<List<AttendanceEntity>>(previous: current));

    final result = await _getAttendance(page: nextPage, perPage: _perPage);
    _isLoadingMore = false;

    result.fold(
      (failure) {
        if (failure is CancelledFailure) return;
        emit(AsyncFailure<List<AttendanceEntity>>(failure, previous: lastData));
      },
      (records) {
        if (records.isEmpty) {
          _hasMore = false;
          emit(AsyncSuccess<List<AttendanceEntity>>(current));
          return;
        }

        _currentPage = nextPage;
        _hasMore = true;
        final merged = _dedupeById([...current, ...records]);
        setData(merged);
      },
    );
  }

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

  List<AttendanceEntity> _dedupeById(List<AttendanceEntity> records) {
    final seen = <int>{};
    final deduped = <AttendanceEntity>[];

    for (final record in records) {
      if (seen.add(record.id)) {
        deduped.add(record);
      }
    }

    return deduped;
  }
}
