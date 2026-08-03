part of '../imports/notifications_imports.dart';

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
  });

  final String title;
  final String message;
  final String time;
  final NotificationType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH16),

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NotificationIcon(type: type),

          12.szW,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _NotificationChip(type: type),

                    8.szW,

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        time,
                        style: const TextStyle().setHintColor.s11.regular,
                      ),
                    ),
                  ],
                ),

                8.szH,

                Text(
                  message,
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

class _NotificationChip extends StatelessWidget {
  const _NotificationChip({required this.type});

  final NotificationType type;

  @override
  Widget build(BuildContext context) {
    final color = type == NotificationType.rejected
        ? Color(0xFFFFDAD6)
        : AppColors.primary.withOpacity(.15);

    final textColor = type == NotificationType.rejected
        ? AppColors.error
        : AppColors.success;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW10,
        vertical: AppPadding.pH4,
      ),

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppCircular.r20),
      ),

      child: Text(
        type == NotificationType.rejected ? 'إجازة مرضية' : 'تمت الموافقة',

        style: const TextStyle().s12.medium.copyWith(color: textColor),
      ),
    );
  }
}
