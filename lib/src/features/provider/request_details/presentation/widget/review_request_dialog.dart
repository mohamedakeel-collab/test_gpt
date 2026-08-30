part of '../imports/request_details_imports.dart';

class _ConfirmReviewDialog extends StatelessWidget {
  const _ConfirmReviewDialog({required this.isApprove});

  final bool isApprove;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppCircular.r20),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppPadding.pH20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppSize.sW60,
              height: AppSize.sH60,
              decoration: BoxDecoration(
                color: isApprove
                    ? AppColors.successSurface
                    : AppColors.dangerSurface,
                shape: BoxShape.circle,
              ),
              child: IconWidget(
                icon: isApprove
                    ? AppAssets.svg.baseSvg.done.path
                    : AppAssets.svg.baseSvg.reject.path,
                color: isApprove ? AppColors.success : AppColors.error,
                height: AppSize.sH32,
              ),
            ),
            20.szH,
            Text(
              isApprove
                  ? LocaleKeys.confirmApproval
                  : LocaleKeys.confirmRejection,
              textAlign: TextAlign.center,
              style: const TextStyle().setMainTextColor.s16.bold,
            ),
            12.szH,
            Text(
              isApprove ? LocaleKeys.approveRequest : LocaleKeys.rejectRequest,
              textAlign: TextAlign.center,
              style: const TextStyle().setHintColor.s13.regular,
            ),
            24.szH,
            LoadingButton(
              title: isApprove
                  ? LocaleKeys.approveRequest
                  : LocaleKeys.rejectRequest,
              color: isApprove ? AppColors.success : AppColors.error,
              textColor: AppColors.white,
              borderRadius: AppCircular.r20,
              onTap: () async => Go.back(true),
            ),
            12.szH,
            LoadingButton(
              title: LocaleKeys.noCancel,
              color: AppColors.white,
              textColor: AppColors.hintText,
              borderRadius: AppCircular.r20,
              borderSide: BorderSide(color: AppColors.border),
              onTap: () async => Go.back(false),
            ),
          ],
        ),
      ),
    );
  }
}
