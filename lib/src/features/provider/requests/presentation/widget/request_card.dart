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

                  type: _statusType(request.status),
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  request.duration,

                  style: const TextStyle().setMainTextColor.s13.regular,
                ),


              ],
            ),
          ],
        ),
      ),
    );
  }

  RequestStatus _statusType(String status) {
    return switch (status) {
      'approved' => RequestStatus.approved,

      'approved_by_manager' => RequestStatus.approved,

      'rejected' => RequestStatus.rejected,

      _ => RequestStatus.pending,
    };
  }

  Color get _borderColor {
    return switch (_statusType(request.status)) {
      RequestStatus.pending => Colors.orange,

      RequestStatus.approved => AppColors.primary,

      RequestStatus.rejected => AppColors.error,
    };
  }
}
