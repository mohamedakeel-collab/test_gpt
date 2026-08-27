part of '../imports/request_details_imports.dart';

@injectable
class RequestDetailsCubit extends AsyncCubit<LeaveRequestEntity> {
  RequestDetailsCubit(this._useCase);

  final GetRequestDetailsUseCase _useCase;

  Future<void> getRequestDetails(int id) => execute(() => _useCase(id));
}
