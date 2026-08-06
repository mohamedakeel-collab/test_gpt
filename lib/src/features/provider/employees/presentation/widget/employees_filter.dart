part of '../imports/employees_imports.dart';

class _EmployeesFilter extends StatelessWidget {
  const _EmployeesFilter();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.sW45,
      height: AppSize.sH45,

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppCircular.r10),

        border: Border.all(color: AppColors.border),
      ),

      child: Icon(Icons.filter_list, color: AppColors.hintText),
    );
  }
}
