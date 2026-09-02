part of '../../imports/employees_imports.dart';

class _EmployeesSearchSkeleton extends StatelessWidget {
  const _EmployeesSearchSkeleton();

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
          Container(
            width: AppSize.sH20,

            height: AppSize.sH20,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,

              shape: BoxShape.circle,
            ),
          ),

          8.szW,

          Container(
            height: 13,

            width: 80,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,

              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
    );
  }
}
