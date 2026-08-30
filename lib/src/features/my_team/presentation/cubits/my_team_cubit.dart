part of '../imports/my_team_imports.dart';

@injectable
class MyTeamCubit extends AsyncCubit<List<LeaveRequestEntity>> {
  MyTeamCubit(this._useCase);

  final GetMyTeamRequestsUseCase _useCase;

  Future<void> getTeamRequests({int? perPage, String? status}) {
    clearData();
    return execute(() => _useCase(perPage: perPage, status: status));
  }
}
