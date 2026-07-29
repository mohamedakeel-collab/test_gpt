part of '../imports/intro_imports.dart';

class _IntroGetStartedButton extends StatelessWidget {
  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onGetStarted;

  const _IntroGetStartedButton({
    required this.isLastPage,
    required this.onNext,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      title: isLastPage ? LocaleKeys.introGetStarted : LocaleKeys.introNext,
      onTap: isLastPage ? onGetStarted : onNext,
      color: AppColors.primary,
      textColor: AppColors.hintText,
    ).paddingSymmetric(horizontal: AppPadding.pW20);
  }
}
