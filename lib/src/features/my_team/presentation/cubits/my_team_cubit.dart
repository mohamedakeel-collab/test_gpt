part of '../imports/my_team_imports.dart';

@injectable
class MyTeamCubit extends AsyncCubit<List<LeaveRequestEntity>> {
  MyTeamCubit(this._useCase);

  final GetMyTeamRequestsUseCase _useCase;

  int _currentPage = 1;
  int _perPage = 10;

  String? _currentStatus;
  String? _currentLeaveType;

  bool _hasMore = true;
  bool _isLoadingMore = false;
  bool _isFetching = false;

  bool get hasMore => _hasMore;

  bool get isLoadingMore => _isLoadingMore;

  Future<void> getTeamRequests({
    int? perPage,
    String? status,
    String? leaveType,
  }) async {
    if (_isFetching) return;

    _isFetching = true;

    _currentPage = 1;
    _perPage = perPage ?? 10;

    _currentStatus = status;
    _currentLeaveType = leaveType;

    _hasMore = true;
    _isLoadingMore = false;

    clearData();

    try {
      final result = await _useCase(
        page: 1,

        perPage: _perPage,

        status: _currentStatus,

        leaveType: _currentLeaveType,
      );

      result.fold(
        (failure) {
          setFailure(failure);
        },

        (data) {
          _hasMore = data.isNotEmpty;

          setData(data);
        },
      );
    } finally {
      _isFetching = false;
    }
  }

  Future<void> loadMore() async {
    if (_isFetching || _isLoadingMore || !_hasMore) {
      return;
    }

    final nextPage = _currentPage + 1;

    _isLoadingMore = true;

    try {
      final result = await _useCase(
        page: nextPage,

        perPage: _perPage,

        status: _currentStatus,

        leaveType: _currentLeaveType,
      );

      result.fold(
        (failure) {
          emit(
            AsyncFailure<List<LeaveRequestEntity>>(failure, previous: lastData),
          );
        },

        (data) {
          if (data.isEmpty) {
            _hasMore = false;

            emit(AsyncSuccess(lastData ?? []));

            return;
          }

          _currentPage = nextPage;

          setData([...lastData ?? [], ...data]);
        },
      );
    } finally {
      _isLoadingMore = false;

      _isFetching = false;
    }
  }
}
