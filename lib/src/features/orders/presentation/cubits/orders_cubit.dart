part of '../imports/orders_imports.dart';

/// Lists leave requests with an optional `leave_type` filter.
///
/// Pattern recap (from `core/state/async_cubit.dart`)
///   - `execute(() => useCase(...))`  → emits Loading → Success/Failure
///                                     by folding the `Either<Failure,T>`.
///
/// The cubit holds **list state only**. The selected filter tab lives in
/// [OrdersViewController] (bloc owns server data, controller owns ephemeral
/// UI state).
@injectable
class OrdersCubit extends AsyncCubit<List<LeaveRequestEntity>> {
  OrdersCubit(this._getOrders, this._deleteRequestUseCase);

  final GetOrdersUseCase _getOrders;
  final DeleteRequestUseCase _deleteRequestUseCase;
  int _currentPage = 1;
  int _perPage = 15;
  String? _currentLeaveType;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  bool _isFetching = false;
  bool _deleteSucceeded = false;

  bool get hasMore => _hasMore;

  bool get isLoadingMore => _isLoadingMore;

  Future<void> getOrders({String? leaveType, int? perPage}) async {
    if (_isFetching) {
      return;
    }

    _isFetching = true;
    _currentPage = 1;
    _perPage = perPage ?? 15;
    _currentLeaveType = leaveType;
    _hasMore = true;
    _isLoadingMore = false;
    clearData();

    try {
      final result = await _getOrders(
        page: 1,
        perPage: _perPage,
        leaveType: leaveType,
      );

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
    if (_isLoadingMore || !_hasMore || _isFetching) {
      return;
    }

    final nextPage = _currentPage + 1;
    _isFetching = true;
    _isLoadingMore = true;
    emit(AsyncLoading<List<LeaveRequestEntity>>(previous: lastData));

    try {
      final result = await _getOrders(
        page: nextPage,
        perPage: _perPage,
        leaveType: _currentLeaveType,
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

  Future<void> deleteRequest(int id, {String? leaveType}) async {
    final result = await _deleteRequestUseCase(id);
    await result.fold((failure) async => setFailure(failure), (_) async {
      _deleteSucceeded = true;
      await getOrders(leaveType: leaveType, perPage: _perPage);
    });
  }

  bool consumeDeleteSucceeded() {
    final succeeded = _deleteSucceeded;
    _deleteSucceeded = false;
    return succeeded;
  }
}
