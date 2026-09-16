part of '../imports/new_request_imports.dart';

@injectable
class LeaveTypesCubit extends AsyncCubit<List<LeaveTypeEntity>> {
  LeaveTypesCubit(this._getLeaveTypes);

  final GetLeaveTypesUseCase _getLeaveTypes;

  Future<void> getLeaveTypes() => execute(() => _getLeaveTypes());
}
