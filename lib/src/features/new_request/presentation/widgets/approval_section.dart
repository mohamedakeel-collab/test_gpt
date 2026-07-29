part of '../imports/new_request_imports.dart';

class _ApprovalSection extends StatelessWidget {
  const _ApprovalSection();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH16),
      decoration: BoxDecoration(
        color: AppColors.fill,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.approvalParty,
            style: const TextStyle().setMainTextColor.s16.semiBold,
          ),

          16.szH,

          _ApprovalItem(
            title: LocaleKeys.teamLeader,
            subtitle: LocaleKeys.teamLeaderApproval,
            icon: AppAssets.svg.baseSvg.team.path,
          ),

          Divider(color: AppColors.border, height: AppSize.sH24),

          _ApprovalItem(
            title: LocaleKeys.hrDepartment,
            subtitle: LocaleKeys.hrApproval,
            icon: AppAssets.svg.baseSvg.company.path,
          ),
        ],
      ),
    );
  }
}

class _ApprovalItem extends StatelessWidget {
  const _ApprovalItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppSize.sW40,
          height: AppSize.sH40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.grey1,
          ),
          child: IconWidget(icon: icon, height: AppSize.sH22),
        ),

        12.szW,

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle().setMainTextColor.s14.medium),

            2.szH,

            Text(subtitle, style: const TextStyle().setHintColor.s12.regular),
          ],
        ),

        const Spacer(),

        Container(
          width: AppSize.sW18,
          height: AppSize.sH18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.brandSurface,
          ),
          child: Center(
            child: Container(
              width: AppSize.sW6,
              height: AppSize.sH6,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
