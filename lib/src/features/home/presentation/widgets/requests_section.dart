part of '../imports/home_imports.dart';

class _RequestsSection extends StatelessWidget {
  const _RequestsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.homeLatestRequests,
          style: const TextStyle()
              .setMainTextColor
              .s18
              .bold,
        ).paddingSymmetric(vertical: AppPadding.pH16,),
         _RequestCard(
          title: 'إجازة سنوية',
          date: '12 - 15 أكتوبر (4 أيام)',
          icon: AppAssets.svg.baseSvg.holiday.path,
        ),
        12.szH,
         _RequestCard(
          title: 'إجازة مرضية',
          date: '20 أكتوبر (يوم واحد)',
          icon: AppAssets.svg.baseSvg.holiday.path,
        ),
        12.szH,
         _RequestCard(
          title: 'إذن ساعي',
          date: '22 أكتوبر (ساعتان)',
          icon: AppAssets.svg.baseSvg.permission.path,
        ),
      ],
    ).paddingSymmetric(
      horizontal: AppPadding.pH16,
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.title,
    required this.date,
    required this.icon,
  });

  final String title;
  final String date;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        AppPadding.pH16,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppCircular.r15,
        ),
      ),
      child: Row(
        children: [
          IconWidget(
            icon: icon,
            width: AppSize.sW55,
            height: AppSize.sH55,
          ),
          16.szW,
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle()
                      .setMainTextColor
                      .s16
                      .medium,
                ),
                4.szH,
                Text(
                  date,
                  style: const TextStyle()
                      .subHintColor
                      .s14
                      .regular,
                ),
              ],
            ),
          ),
          12.szW,
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.pW12,
              vertical: AppPadding.pH6,
            ),
            decoration: BoxDecoration(
              color: AppColors.warningBackground,
              borderRadius: BorderRadius.circular(
                AppCircular.r20,
              ),
            ),
            child: Text(
              'قيد الانتظار',
              style: const TextStyle()
                  .setHintColor
                  .s12
                  .semiBold,
            ),
          ),
        ],
      ),
    );
  }
}