part of '../imports/remote_work_imports.dart';

class _RemoteHistoryCard extends StatelessWidget {
  const _RemoteHistoryCard({
    required this.date,
    required this.time,
    required this.duration,
  });

  final String date;
  final String time;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH12),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppCircular.r12),

        border: Border.all(color: AppColors.border),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Container(
            width: AppSize.sW45,

            height: AppSize.sH45,

            decoration: BoxDecoration(
              color: AppColors.fill,

              shape: BoxShape.circle,
            ),

            child: Icon(
              Icons.calendar_month_outlined,

              color: AppColors.brandSurface,
            ),
          ),

          12.szW,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  date,

                  style: const TextStyle().setMainTextColor.s14.medium,
                ),

                Text(time, style: const TextStyle().setHintColor.s12.regular),
              ],
            ),
          ),

          12.szW,

          Column(
            children: [
              Text(
                duration,

                style: const TextStyle().setMainTextColor.s16.bold,
              ),
              12.szH,
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.pW8,
                  vertical: AppPadding.pH2,
                ),

                decoration: BoxDecoration(
                  color: AppColors.backGroundStatus,

                  borderRadius: BorderRadius.circular(AppCircular.r20),
                ),

                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 20.sp,
                      color: AppColors.textStatus,
                    ),
                    6.szW,
                    Text(
                      LocaleKeys.completed,

                      style: const TextStyle().setTextStatusColor.s11.medium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
