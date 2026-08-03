part of '../imports/profile_imports.dart';

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: AppSize.sH320,
          decoration: BoxDecoration(
            color: AppColors.splashBackground,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(AppCircular.r30),
              bottomRight: Radius.circular(AppCircular.r30),
            ),
          ),
        ),

        SingleChildScrollView(
          child: Column(
            children: [const _ProfileHeader(), 50.szH, const _ProfileContent()],
          ).paddingOnly(bottom: AppPadding.pH10),
        ),
      ],
    );
  }
}
