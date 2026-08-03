part of '../imports/orders_imports.dart';

class _OrderCard extends StatelessWidget {
  const _OrderCard({
    required this.type,
    required this.date,
    required this.status,
    required this.reason,
    required this.approver,
    required this.icon,
    this.rejectionReason,
  });

  final String type;
  final String date;
  final String status;
  final String reason;
  final String approver;
  final String icon;
  final String? rejectionReason;

  @override
  Widget build(BuildContext context) {
    final isRejected = status == LocaleKeys.rejected;

    return Container(
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
            children: [
              IconWidget(icon: icon, height: AppSize.sH40),

              12.szW,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      type,
                      style: const TextStyle().setMainTextColor.s16.semiBold,
                    ),

                    Text(
                      date,
                      style: const TextStyle().setHintColor.s12.regular,
                    ),
                  ],
                ),
              ),

              Spacer(),
              _StatusChip(status: status),
            ],
          ),

          Divider(color: AppColors.border),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      LocaleKeys.approved,
                      style: const TextStyle().setHintColor.s12.regular,
                    ),

                    Text(
                      approver,
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
                      reason,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle().setMainTextColor.s12.medium,
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (isRejected && rejectionReason != null) ...[
            16.szH,

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppPadding.pH12),

              decoration: BoxDecoration(
                color: Color(0xffFFE1E1),
                borderRadius: BorderRadius.circular(AppCircular.r12),
              ),

              child: Text(
                rejectionReason!,
                textAlign: TextAlign.center,

                style: const TextStyle().setErrorColor.s13.medium,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final isApproved = status == LocaleKeys.approved;
    final isRejected = status == LocaleKeys.rejected;

    final backgroundColor = isApproved
        ? AppColors.primary
        : isRejected
        ? Color(0xffFFE1E1)
        : AppColors.warningBackground;

    final textColor = isApproved
        ? AppColors.success
        : isRejected
        ? AppColors.error
        : AppColors.warning;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW12,
        vertical: AppPadding.pH6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppCircular.r20),
      ),
      child: Text(
        status,
        style: const TextStyle().s12.semiBold.copyWith(color: textColor),
      ),
    );
  }
}

class _OrdersFab extends StatelessWidget {
  const _OrdersFab();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.sW50,
      height: AppSize.sH50,

      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary,
      ),

      child: const Icon(Icons.add),
    );
  }
}
