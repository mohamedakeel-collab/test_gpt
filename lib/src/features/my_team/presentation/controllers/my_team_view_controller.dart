part of '../imports/my_team_imports.dart';

class MyTeamViewController {
  MyTeamViewController({required this.onStatusChanged});

  final ValueChanged<String?> onStatusChanged;
  final ValueNotifier<String> selectedStatus = ValueNotifier('pending');

  static const Map<String, String?> statusFilters = {
    'pending': 'pending',
    'approved': 'approved',
    'rejected': 'rejected',
  };

  String? get selectedStatusFilter => statusFilters[selectedStatus.value];

  void selectStatus(String status) {
    if (selectedStatus.value == status) return;
    selectedStatus.value = status;
    onStatusChanged(statusFilters[status]);
  }

  String leaveTypeLabel(String leaveType) => switch (leaveType) {
    'annual' => LocaleKeys.annualLeave,
    'sick' => LocaleKeys.sick,
    'permission' => LocaleKeys.permission,
    'remote' => LocaleKeys.remote,
    _ => leaveType.isEmpty ? LocaleKeys.failureUnknown : leaveType,
  };

  String statusLabel(String status) => switch (status) {
    'pending' => LocaleKeys.pending,
    'approved' => LocaleKeys.approved,
    'rejected' => LocaleKeys.rejected,
    _ => LocaleKeys.failureUnknown,
  };

  Color statusColor(String status) => switch (status) {
    'pending' => AppColors.warning,
    'approved' => AppColors.success,
    'rejected' => AppColors.error,
    _ => AppColors.labelText,
  };

  Color statusBackground(String status) => switch (status) {
    'pending' => AppColors.warningSurface,
    'approved' => AppColors.successSurface,
    'rejected' => AppColors.dangerSurface,
    _ => AppColors.fill,
  };

  String dateRange(LeaveRequestEntity request) {
    final start = request.startDate ?? '';
    final end = request.endDate ?? '';
    if (start.isEmpty) return end;
    if (end.isEmpty) return start;
    return '$start - $end';
  }

  void dispose() {
    selectedStatus.dispose();
  }
}
