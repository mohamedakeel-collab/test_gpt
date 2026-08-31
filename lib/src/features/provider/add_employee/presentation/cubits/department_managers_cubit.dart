part of '../imports/add_employee_imports.dart';

@injectable
class DepartmentManagersCubit extends AsyncCubit<List<DepartmentEntity>> {
  DepartmentManagersCubit(this._useCase);

  final GetDepartmentManagersUseCase _useCase;
  int? _currentDepartmentId;

  Future<void> getManagers(int departmentId) async {
    _currentDepartmentId = departmentId;
    clearData();
    final result = await _useCase(departmentId);
    if (_currentDepartmentId != departmentId) {
      return;
    }
    result.fold(
      (failure) {
        if (failure is CancelledFailure) return;
        setFailure(failure);
      },
      setData,
    );
  }

  void resetManagers() {
    _currentDepartmentId = null;
    clearData();
  }
}
