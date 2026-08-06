part of '../imports/requests_imports.dart';

enum RequestStatus { pending, approved, rejected }

class RequestCard extends StatelessWidget {
  const RequestCard({
    required this.data,
    this.onTap,
  });

  final RequestData data;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: EdgeInsets.all(AppPadding.pH16),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppCircular.r12),

        border: Border(right: BorderSide(color: _borderColor, width: 4)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Text(
                data.title,
                maxLines: 1,
                style: const TextStyle().setMainTextColor.s16.bold,
              ),
              12.szW,
              _RequestStatusChip(status: data.status, type: data.statusType),
            ],
          ),

          8.szH,

          Text(
            data.createdAt,
            maxLines: 1,
            style: const TextStyle().setHintColor.s12.regular,
          ),

          8.szH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                data.date,

                style: const TextStyle().setMainTextColor.s13.regular,
              ),

              if (data.statusType == RequestStatus.pending) ...[
                12.szH,

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.pW12,
                    vertical: AppPadding.pH6,
                  ),

                  decoration: BoxDecoration(
                    color: AppColors.splashBackground,
                    borderRadius: BorderRadius.circular(AppCircular.r5),
                  ),

                  child: Text(
                    'مراجعة',
                    style: const TextStyle().setPrimaryColor.s12.medium,
                  ),
                ),
              ],
              if (data.statusType == RequestStatus.approved) ...[
                12.szH,

                IconWidget(
                  icon: AppAssets.svg.baseSvg.done.path,
                  height: AppSize.sH30,
                ),
              ],
              if (data.statusType == RequestStatus.rejected) ...[
                12.szH,

                Text(
                  LocaleKeys.details,

                  style: const TextStyle().setLabelColor.s14.regular,
                ),
              ],
            ],
          ),
        ],
      ),
    ),);
  }

  Color get _borderColor {
    switch (data.statusType) {
      case RequestStatus.pending:
        return Colors.orange;

      case RequestStatus.approved:
        return AppColors.primary;

      case RequestStatus.rejected:
        return AppColors.error;
    }
  }
}

class RequestData {
  const RequestData({
    required this.title,
    required this.status,
    required this.statusType,
    required this.createdAt,
    required this.date,
  });

  final String title;
  final String status;
  final RequestStatus statusType;
  final String createdAt;
  final String date;
}
