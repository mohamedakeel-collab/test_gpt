part of '../imports/request_details_imports.dart';

class _RequestDetailsBody extends StatelessWidget {
  const _RequestDetailsBody({required this.requestId});

  final int requestId;

  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<RequestDetailsCubit, LeaveRequestEntity>(
      onRetry: () => context.read<RequestDetailsCubit>().getRequestDetails(
        requestId,
      ),
      builder: (context, details) {
        return RefreshIndicator(
          onRefresh: () => context.read<RequestDetailsCubit>().getRequestDetails(
            requestId,
          ),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsetsDirectional.only(
              start: AppPadding.pH16,
              end: AppPadding.pH16,
              top: AppPadding.pH16,
              bottom: AppPadding.pH16 + AppSize.sH100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RequestEmployeeCard(employee: details.employee),
                12.szH,
                RequestBalanceCard(employee: details.employee),
                12.szH,
                RequestInfoCard(details: details),
                if (details.file?.isNotEmpty ?? false) ...[
                  12.szH,
                  RequestAttachmentCard(file: details.file),
                ],
                12.szH,
                RequestNotesCard(requestId: details.id),
              ],
            ),
          ),
        );
      },
    );
  }
}
