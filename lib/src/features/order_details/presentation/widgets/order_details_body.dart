part of '../imports/order_details_imports.dart';

class _OrderDetailsBody extends StatelessWidget {
  const _OrderDetailsBody({required this.controller});

  final OrderDetailsViewController controller;

  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<OrderDetailsCubit, LeaveRequestDetailsEntity>(
      onRetry: () =>
          context.read<OrderDetailsCubit>().getDetails(controller.requestId),

      loadingBuilder: (_) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),

          padding: EdgeInsetsDirectional.only(
            start: AppPadding.pH16,
            end: AppPadding.pH16,
            top: AppPadding.pH16,
            bottom: AppPadding.pH16,
          ),

          child: Column(
            children: [
              const _RequestEmployeeSkeleton(),

              12.szH,

              const _RequestBalanceSkeleton(),

              12.szH,

              const _RequestInfoSkeleton(),

              12.szH,

              const _RequestAttachmentSkeleton(),

              12.szH,

              const _RequestNotesSkeleton(),
            ],
          ),
        );
      },

      builder: (context, details) {
        return RefreshIndicator(
          onRefresh: () => context.read<OrderDetailsCubit>().getDetails(
            controller.requestId,
          ),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsetsDirectional.only(
              start: AppPadding.pH16,
              end: AppPadding.pH16,
              bottom: details.isPending ? AppSize.sH100 : AppPadding.pH16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.szH,
                RequestEmployeeCard(employee: details.employee),
                12.szH,
                RequestBalanceCard(employee: details.employee),
                12.szH,
                RequestInfoCard(details: details),
                12.szH,
                RequestAttachmentCard(file: details.file),
                12.szH,
                RequestNotesCard(comments: details.comments),
                24.szH,
              ],
            ),
          ),
        );
      },
    );
  }
}
