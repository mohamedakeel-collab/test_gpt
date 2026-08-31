part of '../imports/employees_imports.dart';

enum EmployeeFilterState { all, pending, noPending }

class EmployeesViewController {
  EmployeesViewController({required this.onSearchChangedApi});

  final ValueChanged<String> onSearchChangedApi;

  final TextEditingController searchController = TextEditingController();

  final ValueNotifier<String> searchQuery = ValueNotifier('');

  final ValueNotifier<EmployeeFilterState> filterState = ValueNotifier(
    EmployeeFilterState.all,
  );

  void onSearchChanged(String value) {
    searchQuery.value = value;

    onSearchChangedApi(value);
  }

  void changeFilter(EmployeeFilterState filter) {
    filterState.value = filter;
  }

  List<EmployeeEntity> filterEmployees(List<EmployeeEntity> employees) {
    var filtered = employees;

    final query = searchQuery.value.trim().toLowerCase();

    if (query.isNotEmpty) {
      filtered = filtered.where((employee) {
        return employee.fullName.toLowerCase().contains(query) ||
            employee.phone.toLowerCase().contains(query) ||
            employee.position.toLowerCase().contains(query);
      }).toList();
    }

    switch (filterState.value) {
      case EmployeeFilterState.pending:
        filtered = filtered
            .where((employee) => employee.hasPendingRequests)
            .toList();

        break;

      case EmployeeFilterState.noPending:
        filtered = filtered
            .where((employee) => !employee.hasPendingRequests)
            .toList();

        break;

      case EmployeeFilterState.all:
        break;
    }

    return filtered;
  }

  String statusLabel(EmployeeEntity employee) {
    return employee.hasPendingRequests
        ? LocaleKeys.pendingRequest
        : LocaleKeys.noPendingRequests;
  }

  Color statusColor(EmployeeEntity employee) {
    return employee.hasPendingRequests ? AppColors.warning : AppColors.success;
  }

  Color statusSurface(EmployeeEntity employee) {
    return employee.hasPendingRequests
        ? AppColors.warningSurface
        : AppColors.successSurface;
  }

  int pendingCount(List<EmployeeEntity> employees) {
    return employees.where((employee) => employee.hasPendingRequests).length;
  }

  void dispose() {
    searchController.dispose();

    searchQuery.dispose();

    filterState.dispose();
  }
}
