part of '../imports/requests_imports.dart';

class _RequestsBody extends StatefulWidget {
  const _RequestsBody({required this.controller});

  final MyTeamViewController controller;

  @override
  State<_RequestsBody> createState() => _RequestsBodyState();
}

class _RequestsBodyState extends State<_RequestsBody> {
  late final ScrollController _scrollController;

  late final RequestsViewController _requestController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);

    widget.controller.selectedStatus.addListener(_onStatusChanged);

    _requestController = RequestsViewController(
      onTabChanged: (leaveType) {
        context.read<MyTeamCubit>().getTeamRequests(
          perPage: 10,
          status: leaveType,
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    widget.controller.selectedStatus.removeListener(_onStatusChanged);

    _requestController.dispose();

    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 100) {
      context.read<MyTeamCubit>().loadMore();
    }
  }

  void _onStatusChanged() {
    if (!_scrollController.hasClients) {
      return;
    }

    _scrollController.jumpTo(0);
  }

  Future<void> _refresh() {
    return context.read<MyTeamCubit>().getTeamRequests(
      perPage: 10,

      status: widget.controller.selectedStatusFilter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.szH,

        _RequestsTabs(
          controller: _requestController,
        ).paddingSymmetric(horizontal: AppPadding.pH16),

        16.szH,

        Expanded(
          child: AsyncBlocBuilder<MyTeamCubit, List<LeaveRequestEntity>>(
            onRetry: _refresh,

            builder: (context, requests) {
              final cubit = context.read<MyTeamCubit>();

              final isLoadingMore = cubit.isLoadingMore;

              if (requests.isEmpty) {
                return RefreshIndicator(
                  onRefresh: _refresh,

                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),

                    children: [
                      SizedBox(height: AppSize.sH120),

                      EmptyWidget(
                        title: LocaleKeys.ordersEmpty,

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

                  separatorBuilder: (_, __) => 12.szH,

                  itemBuilder: (_, index) {
                    if (index == requests.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),

                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final request = requests[index].toEmployeeDetailsRequest();

                    return RequestCard(
                      request: request,

                      controller: EmployeeDetailsViewController(),

                      onTap: () {
                        Go.to(RequestDetailsScreen(id: requests[index].id));
                      },
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
