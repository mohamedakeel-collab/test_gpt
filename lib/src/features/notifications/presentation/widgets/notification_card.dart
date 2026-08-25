part of '../imports/notifications_imports.dart';

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.notification,
    required this.controller,
  });

  final NotificationEntity notification;
  final NotificationsViewController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NotificationIcon(controller: controller),
          12.szW,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _NotificationChip(
                      label: notification.title,
                      color: AppColors.notificationBackground,
                      textColor: AppColors.brandSurface,
                      borderColor: AppColors.notificationBorder,
                    ),
                    8.szW,
                    Text(
                      controller.createdAtLabel(notification.createdAt),
                      style: const TextStyle().setHintColor.s11.regular,
                    ),
                  ],
                ),
                4.szH,
                Text(
                  notification.message,
                  textAlign: TextAlign.right,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle().setMainTextColor.s14.medium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
