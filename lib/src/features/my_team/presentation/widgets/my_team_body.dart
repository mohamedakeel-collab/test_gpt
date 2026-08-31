part of '../imports/my_team_imports.dart';

class _MyTeamBody extends StatefulWidget {
  const _MyTeamBody({required this.controller});

  final MyTeamViewController controller;

  @override
  State<_MyTeamBody> createState() => _MyTeamBodyState();
}

class _MyTeamBodyState extends State<_MyTeamBody> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    widget.controller.selectedStatus.addListener(_onStatusChanged);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    widget.controller.selectedStatus.removeListener(_onStatusChanged);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent) {
      context.read<MyTeamCubit>().loadMore();
    }
  }

  void _onStatusChanged() {
    if (!_scrollController.hasClients) return;
    _scrollController.jumpTo(0);
  }

  Future<void> _refresh() {
    return context.read<MyTeamCubit>().getTeamRequests(
      perPage: 15,
      status: widget.controller.selectedStatusFilter,
    );
  }

  Future<void> _openRequestForEdit(LeaveRequestEntity request) async {
    final result = await Go.to(
      NewRequestScreen(request: request, mode: RequestMode.editProvider),
    );

    if (result == true && mounted) {
      await _refresh();
    }
  }

  Future<void> _openRequestDetails(LeaveRequestEntity request) async {
    final result = await Go.to(RequestDetailsScreen(id: request.id));

    if (result == true && mounted) {
      await _refresh();
    }
  }

  Widget _buildFooterLoader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(child: CircularProgressIndicator()),
    );
  }

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
          controller: widget.controller,
        ).paddingSymmetric(horizontal: AppPadding.pH16),
        12.szH,
        Expanded(
          child: AsyncBlocBuilder<MyTeamCubit, List<LeaveRequestEntity>>(
            onRetry: _refresh,
            builder: (context, requests) {
              final isLoadingMore = context.read<MyTeamCubit>().isLoadingMore;

              if (requests.isEmpty) {
                return RefreshIndicator(
                  onRefresh: _refresh,
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
                onRefresh: _refresh,
                child: ListView.separated(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.pH16,
                    vertical: AppPadding.pH8,
                  ),
                  itemCount: requests.length + (isLoadingMore ? 1 : 0),
                  separatorBuilder: (_, index) {
                    if (index >= requests.length - 1) {
                      return const SizedBox.shrink();
                    }
                    return 12.szH;
                  },
                  itemBuilder: (_, index) {
                    if (index == requests.length) {
                      return _buildFooterLoader();
                    }

                    return TeamRequestCard(
                      onEdit: () => _openRequestForEdit(requests[index]),
                      onTap: () => _openRequestDetails(requests[index]),
                      request: requests[index],
                      controller: widget.controller,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
