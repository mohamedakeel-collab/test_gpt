part of '../imports/request_details_imports.dart';

class RequestBalanceCard extends StatelessWidget {
  const RequestBalanceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH12),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppCircular.r12),

        border: Border.all(color: AppColors.border),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          IconWidget(
            icon: AppAssets.svg.baseSvg.vacationBalance.path,
            height: AppSize.sH20,
          ),
          Text(
            'رصيد الإجازات المتبقي',
            style: const TextStyle().setHintColor.s13.regular,
          ),
          Text(
            '18 / 21 يوم',
            style: const TextStyle().setMainTextColor.s18.bold,
          ),
        ],
      ),
    );
  }
}
