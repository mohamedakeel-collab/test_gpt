part of '../imports/profile_imports.dart';

class ProfileImageCard extends StatelessWidget {
  const ProfileImageCard({
    super.key,
    required this.image,
    this.size,
  });

  final String image;
  final double? size;


  @override
  Widget build(BuildContext context) {

    final imageSize = size ?? AppSize.sW90;

    return Container(
      width: imageSize,
      height: imageSize,

      padding: EdgeInsets.all(
        AppPadding.pH3,
      ),

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        border: Border.all(
          color: AppColors.primary,
          width: 3,
        ),
      ),


      child: ClipOval(

        child: Image.network(
          image,

          fit: BoxFit.cover,


          errorBuilder: (
              context,
              error,
              stackTrace,
              ) {
            return AppAssets.svg.baseSvg.person.svg(
              fit: BoxFit.cover,
            );
          },
        ),

      ),
    );
  }
}