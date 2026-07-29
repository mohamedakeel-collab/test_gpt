part of '../imports/home_imports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.onTap,this.actions,   this.title=ConstantManager.appName,   this.showArrow = false,});
  final void Function()? onTap;
  final bool showArrow;
  final String title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: AppSize.sH60,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.splashBackground,
      title: Row(
        children: [
          if (showArrow) ...[
            ArrowWidget(onTap: onTap),
          ] else ...[
            const SizedBox.shrink(),
          ],
          if (!showArrow)   CustomLogoApp(),
          Text(
            title,
            style: const TextStyle().setPrimaryColor.s16.medium,
          ).paddingSymmetric(horizontal: AppPadding.pH10),
        ],
      ),
      actions:actions ,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppSize.sH60);
}