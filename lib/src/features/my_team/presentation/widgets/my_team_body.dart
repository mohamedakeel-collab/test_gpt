part of '../imports/my_team_imports.dart';

class _MyTeamBody extends StatelessWidget {
  const _MyTeamBody({required this.controller});

  final MyTeamViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.szH,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.pH16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.teamRequests,
                style: const TextStyle().setMainTextColor.s18.semiBold,
              ),
              IconWidget(
                icon: AppAssets.svg.baseSvg.team.path,
                height: AppSize.sH22,
              ),
            ],
          ),
        ),
        12.szH,
        _TeamFilterTabs(
          controller: controller,
        ).paddingSymmetric(horizontal: AppPadding.pH16),
        12.szH,
        Expanded(
          child: AsyncBlocBuilder<MyTeamCubit, List<LeaveRequestEntity>>(
            onRetry: () => context.read<MyTeamCubit>().getTeamRequests(
              perPage: 15,
              status: controller.selectedStatusFilter,
            ),
            builder: (context, requests) {
              if (requests.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () => context.read<MyTeamCubit>().getTeamRequests(
                    perPage: 15,
                    status: controller.selectedStatusFilter,
                  ),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.pH16),
                    children: [
                      SizedBox(height: AppSize.sH120),
                      EmptyWidget(
                        title: LocaleKeys.noTeamRequests,
                        desc: LocaleKeys.errorexceptionNotcontaindesc,
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => context.read<MyTeamCubit>().getTeamRequests(
                  perPage: 15,
                  status: controller.selectedStatusFilter,
                ),
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.pH16,
                    vertical: AppPadding.pH8,
                  ),
                  itemCount: requests.length,
                  separatorBuilder: (_, _) => 12.szH,
                  itemBuilder: (_, index) => TeamRequestCard(
                    onTap: () => Go.to(RequestDetailsScreen()),
                    request: requests[index],
                    controller: controller,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
