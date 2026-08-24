part of '../imports/profile_imports.dart';

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.profile, required this.controller});

  final LoginEntity profile;
  final ProfileViewController controller;

  @override
  Widget build(BuildContext context) {
    final employee = profile.employee;
    return Column(
      children: [
        70.szH,
        Stack(
          children: [
            ProfileImageCard(image: controller.imageUrl(profile.image)),
            PositionedDirectional(
              bottom: -15,
              start: -5,
              child: IconWidget(
                icon: AppAssets.svg.baseSvg.edite.path,
                height: AppSize.sH40,
              ),
            ),
          ],
        ),
        12.szH,
        Text(
          employee?.fullName ?? profile.email,
          style: const TextStyle().setWhiteColor.s18.bold,
        ),
        4.szH,
        Text(
          employee?.position ?? profile.role,
          style: const TextStyle().setPrimaryColor.s12.medium,
        ),
      ],
    );
  }
}
