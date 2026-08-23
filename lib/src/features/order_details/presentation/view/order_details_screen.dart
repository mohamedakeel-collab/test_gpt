part of '../imports/order_details_imports.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
  });


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      appBar: CustomAppBar(
        title: LocaleKeys.requestDetails,
        showArrow: true,
      ),
      body: const _OrderDetailsBody(),

    );
  }
}