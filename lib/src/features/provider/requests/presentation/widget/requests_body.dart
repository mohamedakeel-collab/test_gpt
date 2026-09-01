part of '../imports/requests_imports.dart';

class _RequestsBody extends StatefulWidget {
  const _RequestsBody({required this.controller});

  final RequestsViewController controller;

  @override
  State<_RequestsBody> createState() => _RequestsBodyState();
}

class _RequestsBodyState extends State<_RequestsBody> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    widget.controller.selectedTab.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    widget.controller.selectedTab.removeListener(_onTabChanged);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent) {
      context.read<OrdersCubit>().loadMore();
    }
  }

  void _onTabChanged() {
    if (!_scrollController.hasClients) return;
    _scrollController.jumpTo(0);
  }

  Future<void> _refresh() {
    return context.read<OrdersCubit>().getOrders(
      leaveType: widget.controller.selectedLeaveType,
      perPage: 15,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.szH,
        _RequestsTabs(
          controller: widget.controller,
        ).paddingSymmetric(horizontal: AppPadding.pH16),
        16.szH,
        Expanded(
          child: AsyncBlocBuilder<OrdersCubit, List<LeaveRequestEntity>>(
            onRetry: _refresh,
            builder: (context, requests) {
              final isLoadingMore = context.read<OrdersCubit>().isLoadingMore;

              if (requests.isEmpty) {
                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: AppPadding.pH16,
                    ),
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
                  padding: EdgeInsetsDirectional.symmetric(
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
