part of '../imports/request_details_imports.dart';

class RequestInfoCard extends StatelessWidget {
  const RequestInfoCard({super.key, required this.details});

  final LeaveRequestEntity details;

  @override
  Widget build(BuildContext context) {
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
            children: [
              Expanded(
                child: _InfoRow(
                  title: LocaleKeys.requestType,
                  value: details.leaveType,
                  icon: Icons.calendar_month_outlined,
                ),
              ),
              Expanded(
                child: _InfoRow(
                  title: LocaleKeys.duration,
                  value: details.duration ?? '',
                  icon: Icons.access_time,
                ),
              ),
            ],
          ),
          16.szH,
          _RequestDateRange(details: details),
          16.szH,
          _InfoLine(title: LocaleKeys.requestReason, value: details.reason),
          if (details.submittedAt?.isNotEmpty ?? false) ...[
            12.szH,
            _InfoLine(
              title: LocaleKeys.submittedAt,
              value: details.submittedAt!,
            ),
          ],
        ],
      ),
    );
  }
}

class _RequestDateRange extends StatelessWidget {
  const _RequestDateRange({required this.details});

  final LeaveRequestEntity details;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppPadding.pH12),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(AppCircular.r10),
        border: BorderDirectional(
          start: BorderSide(color: AppColors.border, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoLine(title: LocaleKeys.startDate, value: details.startDate ?? ''),
          8.szH,
          _InfoLine(title: LocaleKeys.fromTime, value: details.startTime ?? ''),
          8.szH,
          _InfoLine(title: LocaleKeys.endDate, value: details.endDate ?? ''),
          8.szH,
          _InfoLine(title: LocaleKeys.toTime, value: details.endTime ?? ''),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle().setHintColor.s12.regular),
        8.szW,
        Expanded(
          child: Text(
            value,
            style: const TextStyle().setMainTextColor.s13.medium,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle().setHintColor.s12.regular),
        8.szH,
        Row(
          children: [
            Icon(icon, size: AppSize.sH18, color: AppColors.brandSurface),
            6.szW,
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle().setMainTextColor.s14.medium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
