part of '../imports/employees_imports.dart';

@injectable
class EmployeesCubit extends AsyncCubit<List<EmployeeEntity>> {
  EmployeesCubit(this._useCase);

  final GetEmployeesUseCase _useCase;

  int _currentPage = 1;
  int _perPage = 15;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  bool get hasMore => _hasMore;
  String? _search;
  bool get isLoadingMore => _isLoadingMore;

  Future<void> getEmployees({
    int? perPage,
    String? search,
  }) {

    _search = search;

    return execute(
          () => _useCase(
        page: 1,
        perPage: perPage ?? 15,
        search: search,
      ),
    );
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore || lastData == null) {
      return;
    }

    final current = lastData ?? const <EmployeeEntity>[];
    final nextPage = _currentPage + 1;
    _isLoadingMore = true;
    emit(AsyncLoading<List<EmployeeEntity>>(previous: current));

    final result = await _useCase(page: nextPage, perPage: _perPage);
    _isLoadingMore = false;

    result.fold(
      (failure) {
        if (failure is CancelledFailure) return;
        emit(AsyncFailure<List<EmployeeEntity>>(failure, previous: lastData));
      },
      (employees) {
        if (employees.isEmpty) {
          _hasMore = false;
          emit(AsyncSuccess<List<EmployeeEntity>>(current));
          return;
        }

        _currentPage = nextPage;
        _hasMore = true;
        setData(_dedupeById([...current, ...employees]));
      },
    );
  }

  List<EmployeeEntity> _dedupeById(List<EmployeeEntity> employees) {
    final seen = <int>{};
    final deduped = <EmployeeEntity>[];

    for (final employee in employees) {
      if (seen.add(employee.id)) {
        deduped.add(employee);
      }
    }

    return deduped;
  }
}
