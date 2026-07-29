part of '../imports/intro_imports.dart';

class _IntroPageWidget extends StatelessWidget {
  final SvgGenImage   imagePath;
  final String titleKey;
  final String descKey;

  const _IntroPageWidget({
    required this.imagePath,
    required this.titleKey,
    required this.descKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: imagePath.svg(
              width: .75.sw,
              height: .75.sw,
              fit: BoxFit.contain,
            ),
          ),
        ),

        Text(
          titleKey,
          textAlign: TextAlign.center,
          style: const TextStyle().setWhiteColor.s22.bold,
        ).paddingSymmetric(horizontal: AppPadding.pW24),

        14.szH,

        Text(
          descKey,
          textAlign: TextAlign.center,
          style: const TextStyle().subLabelColor.s14.regular,
        ).paddingSymmetric(horizontal: AppPadding.pW32),

        20.szH,
      ],
    );
  }
}
