part of '../imports/order_details_imports.dart';

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
              borderSide: BorderSide(color: AppColors.error),
              onTap: () async {},
            ),
          ),
          12.szW,
          Expanded(
            child: LoadingButton(
              title: LocaleKeys.approveRequest,
              color: AppColors.primary,
              textColor: AppColors.splashBackground,
              borderRadius: AppCircular.r15,
              onTap: () async {},
            ),
          ),
        ],
      ),
    );
  }
}
