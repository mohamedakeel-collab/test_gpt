part of '../imports/add_employee_imports.dart';

@injectable
class DepartmentsCubit extends AsyncCubit<List<DepartmentEntity>> {
  DepartmentsCubit(this._useCase);

  final GetDepartmentsUseCase _useCase;

  Future<void> getDepartments() => execute(() => _useCase());
}
