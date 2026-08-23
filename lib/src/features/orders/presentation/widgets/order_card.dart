part of '../imports/orders_imports.dart';

/// Single leave request row driven by the API's [LeaveRequestEntity].
/// Renders the leave type, date range, duration, reason and status badge.
class _OrderCard extends StatelessWidget {
  const _OrderCard({
    required this.order,
    this.onDelete,
    this.onEdit,
    this.onTap,
  });

  final LeaveRequestEntity order;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isPending = order.status == 'pending';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppPadding.pH16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppCircular.r12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconWidget(
                  icon: _leaveTypeIcon(order.leaveType),
                  height: AppSize.sH40,
                ),
                12.szW,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _leaveTypeLabel(order.leaveType),
                        maxLines: 2,

                        style: const TextStyle().setMainTextColor.s16.semiBold,
                      ),
                      Text(
                        _dateRange(order),
                        maxLines: 2,

                        style: const TextStyle().setHintColor.s12.regular,
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    _OrderStatusBadge(
                      status: order.status,
                      statusText: order.statusText,
                    ),
                    if (isPending) ...[
                      8.szH,

                      Row(
                        children: [
                          GestureDetector(
                            onTap: onEdit,

                            child: Icon(
                              Icons.mode_edit_sharp,

                              color: AppColors.hintText,

                              size: AppSize.sH22,
                            ),
                          ),

                          16.szW,

                          GestureDetector(
                            onTap: onDelete,

                            child: IconWidget(
                              icon: AppAssets.svg.baseSvg.deleteAll.path,

                              height: AppSize.sH28,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ],
            ),
            const Divider(color: AppColors.border),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.ordersDuration,
                        style: const TextStyle().setHintColor.s12.regular,
                      ),
                      Text(
                        order.duration?.isNotEmpty == true
                            ? order.duration!
                            : LocaleKeys.failureUnknown,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle().setMainTextColor.s12.medium,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.requestReason,
                        style: const TextStyle().setHintColor.s12.regular,
                      ),
                      Text(
                        order.reason,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle().setMainTextColor.s12.medium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Maps the raw `leave_type` from the wire to a localized label.
String _leaveTypeLabel(String leaveType) => switch (leaveType) {
  'annual' => LocaleKeys.annualLeave,
  'sick' => LocaleKeys.sick,
  'permission' => LocaleKeys.permission,
  'remote' => LocaleKeys.remote,
  _ => leaveType.isEmpty ? LocaleKeys.failureUnknown : leaveType,
};

/// Maps the raw `leave_type` to an asset icon.
String _leaveTypeIcon(String leaveType) => switch (leaveType) {
  'permission' => AppAssets.svg.baseSvg.permission.path,
  'remote' => AppAssets.svg.baseSvg.remote.path,
  _ => AppAssets.svg.baseSvg.holiday.path,
};

/// Builds the `start_date - end_date` range from the wire values.
String _dateRange(LeaveRequestEntity order) {
  final start = order.startDate ?? '';
  final end = order.endDate ?? '';
  if (start.isEmpty) return end;
  if (end.isEmpty) return start;
  return start;
}
