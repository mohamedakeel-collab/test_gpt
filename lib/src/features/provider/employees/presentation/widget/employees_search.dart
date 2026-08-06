part of '../imports/employees_imports.dart';

class _EmployeesSearch extends StatelessWidget {
  const _EmployeesSearch();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.sH45,

      padding: EdgeInsets.symmetric(horizontal: AppPadding.pW12),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppCircular.r10),

        border: Border.all(color: AppColors.border),
      ),

      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.hintText),

          8.szW,

          Text(
            'بحث عن موظف...',
            style: const TextStyle().setHintColor.s13.regular,
          ),
        ],
      ),
    );
  }
}
