part of '../imports/home_imports.dart';

class _HomeBody extends StatelessWidget {
  const _HomeBody({required this.controller});

  final HomeViewController controller;

  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<HomeCubit, HomeEntity>(
      onRetry: () => context.read<HomeCubit>().fetchHome(),
      builder: (context, home) {
        return RefreshIndicator(
          onRefresh: () => context.read<HomeCubit>().fetchHome(),
          child: SingleChildScrollView(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HomeHeader(home: home),
                  _BalanceCard(home: home),
                  _RequestsSection(requests: home.recentRequests),
                ],
              ).paddingOnly(bottom: AppPadding.pH10),
            ),
          ),
        );
      },
    );
  }
}
