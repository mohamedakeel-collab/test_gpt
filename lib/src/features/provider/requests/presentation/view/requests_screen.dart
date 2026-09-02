part of '../imports/requests_imports.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  late final MyTeamCubit _cubit;

  late final RequestsViewController _controller;

  @override
  void initState() {
    super.initState();

    _cubit = injector<MyTeamCubit>();

    _controller = RequestsViewController(
      onTabChanged: (leaveType) {
        _cubit.getTeamRequests(perPage: 10, leaveType: leaveType);
      },
    );

    _cubit.getTeamRequests(
      perPage: 10,
      leaveType: _controller.selectedLeaveType,
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
    return BlocProvider<MyTeamCubit>.value(
      value: _cubit,

      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,

        appBar: CustomAppBar(),

        body: _RequestsBody(controller: _controller),
      ),
    );
  }
}
