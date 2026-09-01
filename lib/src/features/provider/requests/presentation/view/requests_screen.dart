part of '../imports/requests_imports.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  late final OrdersCubit _cubit;
  late final RequestsViewController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = injector<OrdersCubit>()
      ..getOrders(leaveType: 'leave', perPage: 15);
    _controller = RequestsViewController(
      onTabChanged: (leaveType) =>
          _cubit.getOrders(leaveType: leaveType, perPage: 15),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersCubit>.value(
      value: _cubit,
      child: BlocListener<OrdersCubit, AsyncState<List<LeaveRequestEntity>>>(
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
            backgroundColor: AppColors.scaffoldBackground,
            appBar: CustomAppBar(title: LocaleKeys.requests),
            body: _RequestsBody(controller: _controller),
          ),
        ),
      ),
    );
  }
}
