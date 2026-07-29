part of '../imports/home_imports.dart';

class CustomLogoApp  extends StatelessWidget {
  const CustomLogoApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.sW50,
      height: AppSize.sH50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),
        image: DecorationImage(
          image: AssetImage(AppAssets.svg.baseSvg.tagLogo.path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
