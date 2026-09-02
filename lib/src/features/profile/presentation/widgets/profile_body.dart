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
            loadingBuilder: (_) {
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
                      children: [
                        const _ProfileHeaderSkeleton(),

                        50.szH,

                        Container(
                          padding: EdgeInsets.all(AppPadding.pH16),

                          margin: EdgeInsets.symmetric(
                            horizontal: AppPadding.pH16,
                          ),

                          decoration: BoxDecoration(
                            color: AppColors.white,

                            borderRadius: BorderRadius.circular(
                              AppCircular.r20,
                            ),
                          ),

                          child: Column(
                            children: [
                              ...List.generate(
                                5,
                                (_) => Padding(
                                  padding: EdgeInsets.only(
                                    bottom: AppPadding.pH12,
                                  ),

                                  child: const _ProfileInfoSkeleton(),
                                ),
                              ),

                              16.szH,

                              Row(
                                children: [
                                  Expanded(child: _ProfileBalanceSkeleton()),

                                  12.szW,

                                  Expanded(child: _ProfileBalanceSkeleton()),
                                ],
                              ),

                              20.szH,

                              ...List.generate(
                                3,
                                (_) => const _ProfileMenuSkeleton(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
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
