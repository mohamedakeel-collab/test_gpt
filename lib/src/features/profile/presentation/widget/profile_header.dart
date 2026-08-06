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
            ProfileImageCard(
              image:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZvzcHwf_E84xtTdBJclC4gsogNLWekM0qXQ&s',
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
