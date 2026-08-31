part of '../imports/employees_imports.dart';

class _EmployeesSearch extends StatelessWidget {
  const _EmployeesSearch({required this.controller});

  final EmployeesViewController controller;

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
          IconWidget(
            icon: Icons.search,

            color: AppColors.hintText,

            height: AppSize.sH20,
          ),

          8.szW,

          Expanded(
            child: TextField(
              controller: controller.searchController,

              onChanged: controller.onSearchChanged,

              decoration: InputDecoration(
                hintText: LocaleKeys.search,

                border: InputBorder.none,

                isDense: true,

                hintStyle: const TextStyle().setHintColor.s13.regular,
              ),

              style: const TextStyle().setMainTextColor.s13.regular,
            ),
          ),
        ],
      ),
    );
  }
}
