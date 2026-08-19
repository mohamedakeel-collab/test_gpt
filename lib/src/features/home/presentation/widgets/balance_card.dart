part of '../imports/home_imports.dart';

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.home});

  final HomeEntity home;

  @override
  Widget build(BuildContext context) {
    // Remaining days come straight from the API; the annual total is taken
    // from the employee payload (falls back to `remaining` when absent so
    // the ring still renders).
    final remaining = home.remainingLeaveBalance;
    final total = home.employee?.leaveBalance ?? remaining;
    final fraction = total > 0
        ? (remaining / total).clamp(0.0, 1.0).toDouble()
        : 0.0;

    return Container(
      padding: EdgeInsets.all(AppPadding.pH18),
      margin: EdgeInsets.only(bottom: AppPadding.pH18, top: AppPadding.pH4),
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
                  value: fraction,
                  strokeWidth: 7.w,
                  backgroundColor: AppColors.splashBackground,
                  valueColor: AlwaysStoppedAnimation(
                    AppColors.primary,
                  ),
                ),
              ),
              Text(
                '${(fraction * 100).round()}%',
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
                  '$remaining',
                  style: const TextStyle()
                      .setPrimaryColor
                      .s32
                      .bold,
                ),

                Text(
                  LocaleKeys.balanceTitle(count: '$total'),
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