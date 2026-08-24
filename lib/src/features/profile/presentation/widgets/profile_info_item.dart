part of '../imports/profile_imports.dart';

class _ProfileInfoItem extends StatelessWidget {
  const _ProfileInfoItem({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH12),
      decoration: BoxDecoration(
        color: AppColors.fill,
        borderRadius: BorderRadius.circular(AppCircular.r10),
      ),
      child: Row(
        children: [
          IconWidget(icon: icon, height: AppSize.sH35),
          12.szW,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle().setHintColor.s12.regular),
                Text(
                  value,
                  style: const TextStyle().setMainTextColor.s13.medium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
