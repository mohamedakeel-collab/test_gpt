part of '../imports/add_employee_imports.dart';

@injectable
class AddEmployeeCubit extends AsyncCubit<EmployeeEntity> {
  AddEmployeeCubit(this._useCase);

  final CreateEmployeeUseCase _useCase;

  Future<void> createEmployee(CreateEmployeeParams params) {
    return execute(() => _useCase(params));
  }
}
