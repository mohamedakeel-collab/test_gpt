part of '../imports/notifications_imports.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.main,
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.notifications,
          showArrow: true,onTap: (){
          Go.back();
        },),
        backgroundColor: AppColors.scaffoldBackground,
        body: _NotificationsBody(),
      ),
    );
  }
}
