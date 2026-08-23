part of '../imports/orders_imports.dart';

/// Confirm dialog for deleting a request. Returns `true` on confirm,
/// `false`/`null` otherwise — let the caller decide what to do.
class _DeleteRequestDialog extends StatelessWidget {
  const _DeleteRequestDialog();

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
                color: AppColors.dangerSurface,
                shape: BoxShape.circle,
              ),
              child: IconWidget(
                icon: AppAssets.svg.baseSvg.deleteAll.path,
                color: AppColors.error,
                height: AppSize.sH32,
              ),
            ),
            20.szH,
            Text(
              LocaleKeys.deleteRequestTitle,
              textAlign: TextAlign.center,
              style: const TextStyle().setMainTextColor.s16.bold,
            ),
            12.szH,
            Text(
              LocaleKeys.deleteRequestMessage,
              textAlign: TextAlign.center,
              style: const TextStyle().setHintColor.s13.regular,
            ),
            24.szH,
            LoadingButton(
              title: LocaleKeys.yesDelete,
              color: AppColors.error,
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