part of '../imports/add_employee_imports.dart';

@injectable
class AddEmployeeCubit extends AsyncCubit<EmployeeEntity> {
  AddEmployeeCubit(this._createEmployeeUseCase, this._updateEmployeeUseCase);

  final CreateEmployeeUseCase _createEmployeeUseCase;
  final UpdateEmployeeUseCase _updateEmployeeUseCase;

  Future<void> createEmployee(CreateEmployeeParams params) {
    return execute(() => _createEmployeeUseCase(params));
  }

  Future<void> updateEmployee(int id, CreateEmployeeParams params) {
    return execute(() => _updateEmployeeUseCase(id, params));
  }
}
