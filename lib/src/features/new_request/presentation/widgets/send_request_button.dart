part of '../imports/new_request_imports.dart';

class _SendRequestButton extends StatelessWidget {
  const _SendRequestButton();

  @override
  Widget build(BuildContext context) {
    return LoadingButton(
      title: LocaleKeys.sendRequest,
      color: AppColors.primary,
      textColor: AppColors.splashBackground,
      borderRadius: AppCircular.r30,
      onTap: () async {},
    ).paddingAll(AppPadding.pH16);
  }
}
