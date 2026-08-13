part of '../imports/orders_imports.dart';

class _DeleteRequestDialog extends StatelessWidget {
  const _DeleteRequestDialog({this.onDelete, this.onCancel});

  final VoidCallback? onDelete;
  final VoidCallback? onCancel;

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
                color: const Color(0xffFFE5E5),

                shape: BoxShape.circle,
              ),

              child: Icon(
                Icons.warning_amber_rounded,

                color: AppColors.error,

                size: AppSize.sH32,
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
              title:  LocaleKeys.yesDelete,

              color: AppColors.error,

              textColor: AppColors.white,

              borderRadius: AppCircular.r20,

              onTap: () async {
                onDelete?.call();
              },
            ),

            12.szH,

            LoadingButton(
              title:  LocaleKeys.noCancel,

              color: Colors.transparent,

              textColor: AppColors.hintText,

              borderRadius: AppCircular.r20,

              borderSide: BorderSide(color: AppColors.border),

              onTap: () async {
                onCancel?.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}
