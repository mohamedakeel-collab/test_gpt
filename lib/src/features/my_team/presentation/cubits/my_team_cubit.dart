part of '../imports/my_team_imports.dart';

@injectable
class MyTeamCubit extends AsyncCubit<List<LeaveRequestEntity>> {
  MyTeamCubit(this._useCase);

  final GetMyTeamRequestsUseCase _useCase;

  int _currentPage = 1;
  int _perPage = 10;
  String? _currentStatus;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  bool _isFetching = false;

  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  Future<void> getTeamRequests({int? perPage, String? status}) async {
    if (_isFetching) {
      return;
    }

    _isFetching = true;
    _currentPage = 1;
    _perPage = perPage ?? 10;
    _currentStatus = status;
    _hasMore = true;
    _isLoadingMore = false;
    clearData();

    try {
      final result = await _useCase(page: 1, perPage: _perPage, status: status);

      result.fold(
        (failure) {
          if (failure is CancelledFailure) return;
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
    if (_isFetching || _isLoadingMore || !_hasMore || state.isLoading) {
      return;
    }

    final nextPage = _currentPage + 1;
    _isFetching = true;
    _isLoadingMore = true;
    emit(AsyncLoading<List<LeaveRequestEntity>>(previous: lastData));

    try {
      final result = await _useCase(
        page: nextPage,
        perPage: _perPage,
        status: _currentStatus,
      );

      result.fold(
        (failure) {
          if (failure is CancelledFailure) return;
          emit(
            AsyncFailure<List<LeaveRequestEntity>>(failure, previous: lastData),
          );
        },
        (data) {
          if (data.isEmpty) {
            _hasMore = false;
            emit(AsyncSuccess<List<LeaveRequestEntity>>(lastData ?? const []));
            return;
          }

          _currentPage = nextPage;
          _hasMore = true;
          final items = [
            ...(lastData ?? const <LeaveRequestEntity>[]),
            ...data,
          ];
          setData(items);
        },
      );
    } finally {
      _isLoadingMore = false;
      _isFetching = false;
    }
  }
}
