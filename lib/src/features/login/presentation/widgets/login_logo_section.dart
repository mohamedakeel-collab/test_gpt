part of '../imports/login_imports.dart';

class _LoginLogoSec extends StatelessWidget {
  const _LoginLogoSec();

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 330.h,
      width: 1.sw,
      color: AppColors.splashBackground,
      child: Center(
        child: AppAssets.svg.baseSvg.logoLogin.image(
            height: 150.h,
            width: 150.w
        ),
      ),
    );
  }
}
