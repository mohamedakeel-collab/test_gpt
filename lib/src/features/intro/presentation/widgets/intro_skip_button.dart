part of '../imports/intro_imports.dart';

class _IntroSkipButton extends StatelessWidget {
  final VoidCallback onTap;

  const _IntroSkipButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        LocaleKeys.introSkip,
        style: const TextStyle().setWhiteColor.s14.medium,
      ).onClick(onTap: onTap),
    );
  }
}
