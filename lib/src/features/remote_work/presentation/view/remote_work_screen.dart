part of '../imports/remote_work_imports.dart';

class RemoteWorkScreen extends StatefulWidget {
  const RemoteWorkScreen({super.key});

  @override
  State<RemoteWorkScreen> createState() => _RemoteWorkScreenState();
}

class _RemoteWorkScreenState extends State<RemoteWorkScreen> {
  late final AttendanceCubit _cubit;
  late final RemoteWorkViewController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = injector<AttendanceCubit>()..getAttendance();
    _controller = const RemoteWorkViewController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AttendanceCubit>.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: CustomAppBar(
          title: LocaleKeys.remoteWork,
          showArrow: true,
          onTap: () {
            Go.back();
          },
        ),
        body: _RemoteWorkBody(controller: _controller),
      ),
    );
  }
}
