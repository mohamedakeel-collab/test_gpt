part of '../imports/orders_imports.dart';

class _OrdersHeader extends StatelessWidget {
  const _OrdersHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          LocaleKeys.myOrders,
          style: const TextStyle().setMainTextColor.s16.semiBold,
        ),
        IconWidget(
          icon: AppAssets.svg.baseSvg.filter.path,
          height: AppSize.sH35,
        ),
      ],
    ).paddingAll(AppPadding.pH10);
  }
}