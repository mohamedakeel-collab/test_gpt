part of '../imports/notifications_imports.dart';

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon({ required this.controller});


  final NotificationsViewController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.sW45,
      height: AppSize.sH45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:  Color(0xFFF3F6DF),
      ),
      child: Center(
        child:Icon(
         Icons.check_circle_rounded,
          color:  AppColors.brandSurface,
        ),
      ),
    );
  }
}


