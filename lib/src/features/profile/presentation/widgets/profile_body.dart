part of '../imports/profile_imports.dart';

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.controller});

  final ProfileViewController controller;

  @override
  Widget build(BuildContext context) {

    return BlocListener<LogoutCubit, AsyncState<String>>(
      listenWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      listener: (context, state) async {
        if (state case AsyncSuccess<String>()) {
          MessageUtils.showSnackBar(
            baseStatus: BaseStatus.success,
            message: LocaleKeys.logoutSuccess,
          );
          Go.offAll(const LoginScreen());
          return;
        }

        if (state case AsyncFailure<String>(:final failure)) {
          if (failure is! CancelledFailure) {
            MessageUtils.showSnackBar(
              context: context,
              baseStatus: BaseStatus.error,
              message: failure.userMessage,
            );
          }
        }
      },
      child: Stack(
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
          AsyncBlocBuilder<ProfileCubit, LoginEntity>(
            onRetry: () => context.read<ProfileCubit>().getProfile(),
            builder: (context, profile) {
              return RefreshIndicator(
                onRefresh: () => context.read<ProfileCubit>().getProfile(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      _ProfileHeader(profile: profile, controller: controller),
                      50.szH,
                      _ProfileContent(profile: profile, controller: controller),
                    ],
                  ).paddingOnly(bottom: AppPadding.pH10),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
