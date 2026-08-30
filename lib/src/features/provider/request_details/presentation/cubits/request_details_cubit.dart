part of '../imports/request_details_imports.dart';

@injectable
class RequestDetailsCubit extends AsyncCubit<LeaveRequestEntity> {
  RequestDetailsCubit(this._useCase, this._reviewRequest);

  final GetRequestDetailsUseCase _useCase;
  final ReviewRequestUseCase _reviewRequest;

  Future<void> getRequestDetails(int id) => execute(() => _useCase(id));

  Future<void> reviewRequest(int id, String status) async {
    final current = lastData;
    emit(AsyncLoading<LeaveRequestEntity>(previous: current));

    final result = await _reviewRequest(id, status);
    result.fold(
      (failure) =>
          emit(AsyncFailure<LeaveRequestEntity>(failure, previous: current)),
      (updatedRequest) => setData(updatedRequest),
    );
  }
}
