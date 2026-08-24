part of '../imports/profile_imports.dart';

class _ProfileBalanceCard extends StatelessWidget {
  const _ProfileBalanceCard({
    required this.title,
    required this.value,
    required this.sub,
    required this.isPermission,
  });

  final String title;
  final String value;
  final String sub;
  final bool isPermission;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH12),
      decoration: BoxDecoration(
        color: AppColors.splashBackground,
        borderRadius: BorderRadius.circular(AppCircular.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle().setWhiteColor.s12.regular),
          10.szH,
          Row(
            children: [
              Text(value, style: const TextStyle().setPrimaryColor.s28.bold),
              8.szW,
              Text(
                sub,
                textAlign: TextAlign.start,
                style: const TextStyle().setWhiteColor.s12.regular,
              ),
              if (isPermission) ...[
                const Spacer(),
                Icon(
                  Icons.access_time_outlined,
                  color: AppColors.primary,
                  size: AppSize.sH18,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
