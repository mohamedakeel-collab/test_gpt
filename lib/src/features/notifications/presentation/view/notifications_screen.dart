part of '../imports/notifications_imports.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final NotificationsCubit _cubit;
  late final NotificationsViewController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = injector<NotificationsCubit>()..getNotifications();
    _controller = const NotificationsViewController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsCubit>.value(
      value: _cubit,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.main,
        ),
        child: Scaffold(
          appBar: CustomAppBar(
            title: LocaleKeys.notifications,
            showArrow: true,
            onTap: Go.back,
          ),
          backgroundColor: AppColors.scaffoldBackground,
          body: _NotificationsBody(controller: _controller),
        ),
      ),
    );
  }
}
