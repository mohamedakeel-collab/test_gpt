part of '../imports/my_team_imports.dart';
class MyTeamScreen extends StatefulWidget {
  const MyTeamScreen({
    super.key,
    this.refreshToken = 0,
  });


  final int refreshToken;
  @override
  State<MyTeamScreen> createState() => _MyTeamScreenState();
}

class _MyTeamScreenState extends State<MyTeamScreen> {
  late final MyTeamCubit _cubit;
  late final MyTeamViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = MyTeamViewController(
      onStatusChanged: (status) =>
          _cubit.getTeamRequests(
            perPage: 10,
            status: status,
          ),
    );


    _cubit = injector<MyTeamCubit>()
      ..getTeamRequests(
        perPage: 10,
        status: _controller.selectedStatusFilter,
      );
  }

  @override
  void didUpdateWidget(covariant MyTeamScreen oldWidget) {
    super.didUpdateWidget(oldWidget);


    if (widget.refreshToken != oldWidget.refreshToken) {

      _cubit.getTeamRequests(
        perPage: 10,
        status: _controller.selectedStatusFilter,
      );

    }
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
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.main,
        ),
        child: Scaffold(
          appBar: CustomAppBar(actions: []),
          backgroundColor: AppColors.scaffoldBackground,
          body: _MyTeamBody(controller: _controller),
        ),
      ),
    );
  }
}
