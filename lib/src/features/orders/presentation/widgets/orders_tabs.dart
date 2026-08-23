part of '../imports/orders_imports.dart';

/// Filter tabs. Each tab maps to a `leave_type` query value through the
/// [OrdersViewController] — switching a tab re-fetches the list from the
/// cubit with that filter.
class _OrdersTabs extends StatelessWidget {
  const _OrdersTabs({required this.controller});

  final OrdersViewController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: controller.selectedTab,
      builder: (context, selected, _) {
        return Row(
          children: [
            Expanded(
              child: _OrderTab(
                title: LocaleKeys.leaves,
                active: selected == 0,
                onTap: () => controller.selectTab(0),
              ),
            ),
            8.szW,
            Expanded(
              child: _OrderTab(
                title: LocaleKeys.permissions,
                active: selected == 1,
                onTap: () => controller.selectTab(1),
              ),
            ),
            8.szW,
            Expanded(
              child: _OrderTab(
                title: LocaleKeys.remote,
                active: selected == 2,
                onTap: () => controller.selectTab(2),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _OrderTab extends StatelessWidget {
  const _OrderTab({
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