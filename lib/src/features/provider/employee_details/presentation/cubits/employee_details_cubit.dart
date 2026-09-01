part of '../imports/employee_details_imports.dart';

@injectable
class EmployeeDetailsCubit extends AsyncCubit<EmployeeDetailsEntity> {
  EmployeeDetailsCubit(this._useCase);

  final GetEmployeeDetailsUseCase _useCase;

  Future<void> getEmployeeDetails(int id) {
    return execute(() => _useCase(id));
  }
}
