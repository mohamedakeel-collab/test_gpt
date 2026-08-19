part of '../imports/home_imports.dart';

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.request});

  final RecentRequestEntity request;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r15),
      ),
      child: Row(
        children: [
          IconWidget(
            icon: _leaveTypeIcon(request.leaveType),
            width: AppSize.sW55,
            height: AppSize.sH55,
          ),
          16.szW,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _leaveTypeLabel(request.leaveType),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle().setMainTextColor.s16.medium,
                ),
                4.szH,
                Text(
                  _requestDate(request),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle().subHintColor.s14.regular,
                ),
              ],
            ),
          ),
          12.szW,
          _RequestStatusBadge(
            status: request.status,
            statusText: request.statusText,
          ),
        ],
      ),
    );
  }

  /// Prefers the request date range; falls back to the reason text when the
  /// backend sends no dates. Trims ISO timestamps (`2026-08-19T…Z`) down to
  /// the date part so the card stays readable.
  String _requestDate(RecentRequestEntity request) {
    final start = _displayDate(request.startDate);
    if (start.isEmpty) return request.reason;
    final end = _displayDate(request.endDate);
    return end.isEmpty ? start : '$start - $end';
  }
}

/// Maps the raw `leave_type` from the wire to a localized label.
String _leaveTypeLabel(String leaveType) => switch (leaveType) {
      'annual' => LocaleKeys.annualLeave,
      'sick' => LocaleKeys.sick,
      'permission' => LocaleKeys.permission,
      _ => leaveType.isEmpty ? LocaleKeys.failureUnknown : leaveType,
    };

/// Strips an ISO timestamp down to its `yyyy-MM-dd` prefix, if present.
String _displayDate(String? date) {
  if (date == null || date.isEmpty) return '';
  final tIndex = date.indexOf('T');
  return tIndex > 0 ? date.substring(0, tIndex) : date;
}

/// Maps the raw `leave_type` to an asset icon.
String _leaveTypeIcon(String leaveType) => switch (leaveType) {
      'permission' => AppAssets.svg.baseSvg.permission.path,
      _ => AppAssets.svg.baseSvg.holiday.path,
    };

class _RequestStatusBadge extends StatelessWidget {
  const _RequestStatusBadge({
    required this.status,
    required this.statusText,
  });

  final String status;
  final String statusText;

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = switch (status) {
      'approved' => (AppColors.primary, AppColors.success),
      'rejected' => (AppColors.dangerSurface, AppColors.error),
      'pending' => (AppColors.warningBackground, AppColors.warning),
      _ => (AppColors.fill, AppColors.labelText),
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW12,
        vertical: AppPadding.pH6,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppCircular.r20),
      ),
      child: Text(
        _statusLabel(status, statusText),
        style: const TextStyle().s12.semiBold.copyWith(color: foreground),
      ),
    );
  }
}

/// Prefers the localized label for known statuses; falls back to the
/// backend-provided `status_text` for anything unexpected.
String _statusLabel(String status, String statusText) => switch (status) {
      'approved' => LocaleKeys.approved,
      'rejected' => LocaleKeys.rejected,
      'pending' => LocaleKeys.pending,
      _ => statusText.isEmpty ? LocaleKeys.failureUnknown : statusText,
    };
