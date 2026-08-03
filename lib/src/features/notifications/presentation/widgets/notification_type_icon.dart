part of '../imports/notifications_imports.dart';

enum NotificationType { rejected, approved, system }

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon({required this.type});

  final NotificationType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.sW45,
      height: AppSize.sH45,

      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: type == NotificationType.rejected
            ? Color(0xFFFFDAD6)
            : Color(0xFFF3F6DF),
      ),

      child: Icon(
        type == NotificationType.rejected
            ? Icons.cancel
            : type == NotificationType.system
            ? Icons.favorite
            : Icons.check_circle_rounded,
        color: type == NotificationType.rejected
            ? AppColors.error
            : AppColors.brandSurface,
      ),
    );
  }
}
