part of '../imports/orders_imports.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.main,
      ),
      child: Scaffold(
        appBar: CustomAppBar(actions: []),
        backgroundColor: AppColors.scaffoldBackground,
        body: _OrdersBody(),
      ),
    );
  }
}
