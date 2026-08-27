part of '../imports/orders_imports.dart';

/// Public entry point — wire navigators to `const OrdersScreen()`.
///
/// Responsibilities of a *screen* file:
///   - Provide the cubit(s).
///   - Own the `ViewController` lifecycle (init / dispose).
///   - Compose scaffold + body. **Never** layout content directly here —
///     that's the body widget's job. No methods beyond the lifecycle ones.
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key, this.refreshToken = 0});

  final int refreshToken;

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late final OrdersCubit _cubit;
  late final OrdersViewController _vc;

  @override
  void initState() {
    super.initState();
    _cubit = injector<OrdersCubit>()..getOrders(leaveType: 'leave');
    _vc = OrdersViewController(
      onTabChanged: (leaveType) => _cubit.getOrders(leaveType: leaveType),
    );
  }



  @override
  void dispose() {
    _vc.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersCubit>.value(
      value: _cubit,
      child: BlocListener<OrdersCubit, AsyncState<List<LeaveRequestEntity>>>(
        // Only snackbar on a failure that surfaces while we already have
        // data — the no-data case is handled by AppErrorHandler inline.
        listenWhen: (previous, current) => switch (current) {
          AsyncSuccess<List<LeaveRequestEntity>>() => true,
          AsyncFailure<List<LeaveRequestEntity>>(:final failure) =>
            failure is! CancelledFailure &&
                previous is AsyncSuccess<List<LeaveRequestEntity>>,
          _ => false,
        },
        listener: (context, state) {
          if (state case AsyncSuccess<List<LeaveRequestEntity>>()) {
            if (context.read<OrdersCubit>().consumeDeleteSucceeded()) {
              MessageUtils.showSnackBar(
                context: context,
                baseStatus: BaseStatus.success,
                message: LocaleKeys.requestDeletedSuccessfully,
              );
            }
          } else if (state case AsyncFailure()) {
            context.read<OrdersCubit>().consumeDeleteSucceeded();
          }
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: AppColors.main,
          ),
          child: Scaffold(
            appBar: CustomAppBar(actions: []),
            backgroundColor: AppColors.scaffoldBackground,
            body: _OrdersBody(controller: _vc),
          ),
        ),
      ),
    );
  }
}
