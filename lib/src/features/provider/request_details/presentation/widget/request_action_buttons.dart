part of '../imports/request_details_imports.dart';

class _RequestActionButtons extends StatelessWidget {
  const _RequestActionButtons();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH16),
      color: AppColors.white,

      child: Row(
        children: [
          Expanded(
            child: LoadingButton(
              title: LocaleKeys.rejectRequest,
              color: Colors.transparent,
              textColor: AppColors.error,
              borderRadius: AppCircular.r15,
              borderSide: const BorderSide(color: AppColors.error),
              onTap: () async {
                await _confirmReview(context, isApprove: false);
              },
            ),
          ),

          12.szW,

          Expanded(
            child: LoadingButton(
              title: LocaleKeys.approveRequest,
              color: AppColors.primary,
              textColor: AppColors.splashBackground,
              borderRadius: AppCircular.r15,
              onTap: () async {
                await _confirmReview(context, isApprove: true);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmReview(
    BuildContext context, {
    required bool isApprove,
  }) async {
    final request = context.read<RequestDetailsCubit>().lastData;
    if (request == null) {
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => _ConfirmReviewDialog(isApprove: isApprove),
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    final cubit = context.read<RequestDetailsCubit>();

    final status = isApprove
        ? F.appFlavor == Flavor.user
              ? 'approved_by_manager'
              : 'approved'
        : 'rejected';

    await cubit.reviewRequest(request.id, status);

    if (!context.mounted) {
      return;
    }

    switch (cubit.state) {
      case AsyncSuccess<LeaveRequestEntity>():
        MessageUtils.showSnackBar(
          context: context,
          baseStatus: BaseStatus.success,
          message: isApprove
              ? LocaleKeys.requestApprovedSuccessfully
              : LocaleKeys.requestRejectedSuccessfully,
        );

        Go.back( true);
      case AsyncFailure<LeaveRequestEntity>(:final failure):
        if (failure is! CancelledFailure) {
          MessageUtils.showSnackBar(
            context: context,
            baseStatus: BaseStatus.error,
            message: failure.userMessage,
          );
        }

      default:
        break;
    }
  }
}
