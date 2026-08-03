part of '../imports/profile_imports.dart';

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        70.szH,

        Stack(
          children: [
            Container(
              width: AppSize.sW90,
              height: AppSize.sH90,
              padding: EdgeInsets.all(AppPadding.pH3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 3),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZvzcHwf_E84xtTdBJclC4gsogNLWekM0qXQ&s',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return AppAssets.svg.baseSvg.person.svg();
                  },
                ),
              ),
            ),

            Positioned(
              bottom: -15,
              left: -5,
              child: IconWidget(
                icon: AppAssets.svg.baseSvg.edite.path,
                height: AppSize.sH40,
              ),
            ),
          ],
        ),

        12.szH,

        Text(
          'أحمد عبد الرحمن',
          style: const TextStyle().setWhiteColor.s18.bold,
        ),

        4.szH,

        Text(
          'مدير أول الموارد البشرية',
          style: const TextStyle().setPrimaryColor.s12.medium,
        ),
      ],
    );
  }
}
