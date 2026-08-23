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
  bool _deleteSucceeded = false;

  Future<void> getOrders({String? leaveType}) {
    clearData();

    return execute(() => _getOrders(leaveType: leaveType));
  }

  Future<void> deleteRequest(int id, {String? leaveType}) async {
    final result = await _deleteRequestUseCase(id);
    await result.fold((failure) async => setFailure(failure), (_) async {
      _deleteSucceeded = true;
      await getOrders(leaveType: leaveType);
    });
  }

  bool consumeDeleteSucceeded() {
    final succeeded = _deleteSucceeded;
    _deleteSucceeded = false;
    return succeeded;
  }
}
