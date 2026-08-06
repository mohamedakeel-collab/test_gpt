part of '../imports/employee_details_imports.dart';

enum EmployeeDetailsTab { requests, attendance, information }

class _EmployeeDetailsTabs extends StatelessWidget {
  const _EmployeeDetailsTabs({required this.selectedTab});

  final ValueNotifier<int> selectedTab;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedTab,

      builder: (context, selected, _) {
        return Row(
          children: [
            Expanded(
              child: _EmployeeDetailsTab(
                title: LocaleKeys.all,
                active: selected == 0,

                onTap: () {
                  selectedTab.value = 0;
                },
              ),
            ),

            8.szW,

            Expanded(
              child: _EmployeeDetailsTab(
                title: LocaleKeys.leaves,
                active: selected == 1,

                onTap: () {
                  selectedTab.value = 1;
                },
              ),
            ),

            8.szW,

            Expanded(
              child: _EmployeeDetailsTab(
                title: LocaleKeys.permissions,
                active: selected == 2,

                onTap: () {
                  selectedTab.value = 2;
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EmployeeDetailsTab extends StatelessWidget {
  const _EmployeeDetailsTab({
    required this.title,
    required this.active,
    required this.onTap,
  });

  final String title;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        padding: EdgeInsets.symmetric(vertical: AppPadding.pH8),

        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.white,

          borderRadius: BorderRadius.circular(AppCircular.r10),

          border: Border.all(color: AppColors.border),
        ),

        child: Text(
          title,

          textAlign: TextAlign.center,

          style: active
              ? const TextStyle().setBlackColor.s13.medium
              : const TextStyle().setMainTextColor.s13.medium,
        ),
      ),
    );
  }
}
