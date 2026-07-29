part of '../imports/new_request_imports.dart';

class _BalanceInfoCard extends StatelessWidget {
  const _BalanceInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pH16,
        vertical: AppPadding.pH14,
      ),
      decoration: BoxDecoration(
        color: AppColors.splashBackground,
        borderRadius: BorderRadius.circular(AppCircular.r15),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: AppSize.sW28,
                height: AppSize.sH28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: Center(
                  child: Text(
                    'i',
                    style: const TextStyle().setPrimaryColor.s18.bold,
                  ),
                ),
              ),
              8.szW,
              Text(
                LocaleKeys.remainingVacationBalance,
                style: const TextStyle().setPrimaryColor.s18.semiBold,
              ),
            ],
          ),
          const Spacer(),
          Text("14 يوم", style: const TextStyle().setPrimaryColor.s18.bold),
        ],
      ),
    );
  }
}
