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
                    onEdit: () async {
                      final result = await Go.to(
                        NewRequestScreen(
                          request: requests[index],
                          mode: RequestMode.editProvider,
                        ),
                      );

                      if (result == true && context.mounted) {
                        context.read<MyTeamCubit>().getTeamRequests(
                          perPage: 15,
                          status: controller.selectedStatusFilter,
                        );
                      }
                    },

                    onTap: () =>
                        Go.to(RequestDetailsScreen(id: requests[index].id)),
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

  Future<void> _confirmReview(
    BuildContext context,
    LeaveRequestEntity request, {
    required bool isApprove,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => _ConfirmReviewDialog(isApprove: isApprove),
    );
    if (confirmed != true || !context.mounted) return;

    final cubit = context.read<MyTeamCubit>();
    final status = isApprove
        ? F.appFlavor == Flavor.user
              ? 'approved_by_manager'
              : 'approved'
        : 'rejected';

    await cubit.reviewRequest(request.id, status);

    if (!context.mounted) return;

    switch (cubit.state) {
      case AsyncSuccess<List<LeaveRequestEntity>>():
        MessageUtils.showSnackBar(
          context: context,
          baseStatus: BaseStatus.success,
          message: isApprove
              ? LocaleKeys.requestApprovedSuccessfully
              : LocaleKeys.requestRejectedSuccessfully,
        );
      case AsyncFailure<List<LeaveRequestEntity>>(:final failure):
        if (failure is! CancelledFailure) {
          MessageUtils.showSnackBar(
            context: context,
            baseStatus: BaseStatus.error,
            message: failure.userMessage,
          );
        }
      default:
        break;
    }
  }
}
