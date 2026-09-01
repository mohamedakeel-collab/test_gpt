part of '../imports/requests_imports.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    required this.request,
    required this.controller,
    this.onTap,
  });

  final EmployeeDetailsLeaveRequestEntity request;
  final VoidCallback? onTap;
  final EmployeeDetailsViewController controller;

  @override
  Widget build(BuildContext context) {
    final statusType = _statusType(request.status);


    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: EdgeInsets.all(AppPadding.pH16),

        decoration: BoxDecoration(
          color: AppColors.white,

          borderRadius: BorderRadius.circular(AppCircular.r12),

          border: Border(
            right: BorderSide(color: _borderColor(statusType), width: 4),
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    controller.requestTypeLabel(request.requestType),

                    maxLines: 1,

                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle().setMainTextColor.s16.bold,
                  ),
                ),

                12.szW,

                _RequestStatusChip(
                  status: request.statusText,

                  type: statusType,
                ),
              ],
            ),

            8.szH,

            Text(
              request.date,

              maxLines: 1,

              overflow: TextOverflow.ellipsis,

              style: const TextStyle().setHintColor.s12.regular,
            ),

            8.szH,

            Text(
              request.duration,

              style: const TextStyle().setMainTextColor.s13.regular,
            ),
          ],
        ),
      ),
    );
  }

  RequestStatus _statusType(String status) {
    return switch (status) {
      'approved' || 'approved_by_manager' => RequestStatus.approved,

      'rejected' => RequestStatus.rejected,

      'pending' => RequestStatus.pending,

      _ => RequestStatus.pending,
    };
  }

  Color _borderColor(RequestStatus status) {
    return switch (status) {
      RequestStatus.pending => AppColors.warning,

      RequestStatus.approved => AppColors.success,

      RequestStatus.rejected => AppColors.error,
    };
  }
}
