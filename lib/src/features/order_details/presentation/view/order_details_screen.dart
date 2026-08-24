part of '../imports/order_details_imports.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.id});

  final int id;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late final OrderDetailsCubit _cubit;
  late final OrderDetailsViewController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = injector<OrderDetailsCubit>()..getDetails(widget.id);
    _controller = OrderDetailsViewController(requestId: widget.id);
  }

  @override
  void dispose() {
    _controller.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderDetailsCubit>.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,

        appBar: CustomAppBar(title: LocaleKeys.requestDetails, showArrow: true),
        body: _OrderDetailsBody(controller: _controller),
      ),
    );
  }
}
