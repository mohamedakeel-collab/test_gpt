part of '../imports/home_imports.dart';

class _BalanceCard extends StatelessWidget {
  const _BalanceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH18),
      margin: EdgeInsets.only(bottom: AppPadding.pH18,top: AppPadding.pH4),
      decoration: BoxDecoration(
        color: AppColors.splashBackground,
        borderRadius: BorderRadius.circular(AppCircular.r15),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: AppSize.sH90,
                height: AppSize.sW90,
                child: CircularProgressIndicator(
                  value: .85,
                  strokeWidth: 7.w,
                  backgroundColor: AppColors.splashBackground,
                  valueColor: AlwaysStoppedAnimation(
                    AppColors.primary,
                  ),
                ),
              ),
              Text(
                '85%',
                style: const TextStyle()
                    .setPrimaryColor
                    .s14
                    .bold,
              ),
            ],
          ),
          AppSize.sW90.szW,
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.balanceDays,
                  style: const TextStyle()
                      .setPrimaryColor
                      .s18
                      .semiBold,
                ),

                Text(
                  '21',
                  style: const TextStyle()
                      .setPrimaryColor
                      .s32
                      .bold,
                ),

                Text(
                  LocaleKeys.balanceTitle(count: '10'),
                  style: const TextStyle()
                      .setWhiteColor
                      .s14
                      .regular,
                ),
              ],
            ),
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: AppPadding.pH16);
  }
}