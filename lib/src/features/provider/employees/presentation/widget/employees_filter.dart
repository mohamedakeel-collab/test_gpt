part of '../imports/employees_imports.dart';

class _EmployeesFilter extends StatelessWidget {
  const _EmployeesFilter({required this.controller});

  final EmployeesViewController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<EmployeeFilterState>(
      valueListenable: controller.filterState,
      child: IconWidget(
        icon: Icons.filter_list,
        color: AppColors.hintText,
        height: AppSize.sH20,
      ),
      builder: (_, state, child) {
        final borderColor = state == EmployeeFilterState.all
            ? AppColors.border
            : AppColors.primary;

        return Container(
          width: AppSize.sW45,
          height: AppSize.sH45,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppCircular.r10),
            border: Border.all(color: borderColor),
          ),
          child: child,
        );
      },
    );
  }
}
