part of '../imports/home_imports.dart';

class _HomeTabs extends StatelessWidget {
  const _HomeTabs({
    required this.selectedTab,
  });

  final ValueNotifier<int> selectedTab;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedTab,
      builder: (context, activeIndex, _) {
        return Container(
          padding: EdgeInsets.all(AppPadding.pH4),
          decoration: BoxDecoration(
            color: AppColors.fill,
            borderRadius: BorderRadius.circular(
              AppCircular.r20,
            ),
          ),
          child: Row(
            children: [
              _TabItem(
                title: LocaleKeys.homeLeaves,
                isActive: activeIndex == 0,
                onTap: () => selectedTab.value = 0,
              ),

              _TabItem(
                title: LocaleKeys.homePermissions,
                isActive: activeIndex == 1,
                onTap: () => selectedTab.value = 1,
              ),
            ],
          ),
        );
      },
    ).paddingSymmetric(
      horizontal: AppPadding.pH16,
    );
  }
}


class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  final String title;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppPadding.pH10,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.white
              : Colors.transparent,
          borderRadius: BorderRadius.circular(
            AppCircular.r20,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: isActive
              ? const TextStyle()
              .setBrandSurfaceColor
              .s16
              .semiBold
              : const TextStyle()
              .subHintColor
              .s16
              .semiBold,
        ),
      ).onClick(onTap: onTap),
    );
  }
}