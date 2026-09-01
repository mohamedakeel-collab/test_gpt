part of '../imports/requests_imports.dart';

enum RequestTab { leaves, permissions, remote }

class _RequestsTabs extends StatelessWidget {
  const _RequestsTabs({required this.controller});

  final RequestsViewController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: controller.selectedTab,
      builder: (context, selected, _) {
        return Row(
          children: [
            Expanded(
              child: _RequestTab(
                title: LocaleKeys.leaves,
                active: selected == 0,
                onTap: () => controller.selectTab(0),
              ),
            ),
            8.szW,
            Expanded(
              child: _RequestTab(
                title: LocaleKeys.permissions,
                active: selected == 1,
                onTap: () => controller.selectTab(1),
              ),
            ),
            8.szW,
            Expanded(
              child: _RequestTab(
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

class _RequestTab extends StatelessWidget {
  const _RequestTab({
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
