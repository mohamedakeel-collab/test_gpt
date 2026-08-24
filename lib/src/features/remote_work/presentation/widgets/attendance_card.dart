part of '../imports/remote_work_imports.dart';

class _AttendanceCard extends StatelessWidget {
  const _AttendanceCard({required this.record, required this.controller});

  final AttendanceEntity record;
  final RemoteWorkViewController controller;

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
        children: [
          Container(
            width: AppSize.sW45,
            height: AppSize.sH45,
            decoration: BoxDecoration(
              color: AppColors.fill,
              shape: BoxShape.circle,
            ),
            child: IconWidget(
              icon: Icons.calendar_month_outlined,
              color: AppColors.brandSurface,
              height: AppSize.sH24,
            ),
          ),
          12.szW,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.dayName,
                  style: const TextStyle().setMainTextColor.s14.medium,
                ),
                4.szH,
                Text(
                  record.checkInDate,
                  style: const TextStyle().setHintColor.s12.regular,
                ),
                4.szH,
                Text(
                  controller.timeRange(record),
                  style: const TextStyle().setHintColor.s12.regular,
                ),
              ],
            ),
          ),
          12.szW,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                controller.durationLabel(record),
                style: const TextStyle().setMainTextColor.s16.bold,
              ),
              12.szH,
              _AttendanceStatusBadge(
                status: record.status,
                controller: controller,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AttendanceStatusBadge extends StatelessWidget {
  const _AttendanceStatusBadge({
    required this.status,
    required this.controller,
  });

  final String status;
  final RemoteWorkViewController controller;

  @override
  Widget build(BuildContext context) {
    final color = controller.statusColor(status);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW8,
        vertical: AppPadding.pH2,
      ),
      decoration: BoxDecoration(
        color: controller.statusSurface(status),
        borderRadius: BorderRadius.circular(AppCircular.r20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconWidget(icon: Icons.circle, height: AppSize.sH8, color: color),
          6.szW,
          Text(
            controller.statusLabel(status),
            style: const TextStyle().s11.medium.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
