part of '../imports/my_team_imports.dart';

@injectable
class MyTeamCubit extends AsyncCubit<List<LeaveRequestEntity>> {
  MyTeamCubit(this._useCase, this._reviewRequest);

  final GetMyTeamRequestsUseCase _useCase;
  final ReviewRequestUseCase _reviewRequest;

  Future<void> getTeamRequests({int? perPage, String? status}) {
    clearData();
    return execute(() => _useCase(perPage: perPage, status: status));
  }

  Future<void> reviewRequest(int id, String status) async {
    final current = lastData ?? const <LeaveRequestEntity>[];
    emit(AsyncLoading<List<LeaveRequestEntity>>(previous: current));

    final result = await _reviewRequest(id, status);
    result.fold(
      (failure) => emit(AsyncFailure<List<LeaveRequestEntity>>(
          failure,
          previous: current,
        )),
      (updatedRequest) {
        final updated = current
            .map((item) => item.id == updatedRequest.id ? updatedRequest : item)
            .toList();
        setData(updated);
      },
    );
  }
}
