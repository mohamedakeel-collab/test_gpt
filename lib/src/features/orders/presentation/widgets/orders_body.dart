part of '../imports/orders_imports.dart';

/// Body of [OrdersScreen]. Three concerns:
///   1. Render the header (title + filter icon).
///   2. Render the filter tabs.
///   3. Render the list / loading / error / empty states from the cubit.
class _OrdersBody extends StatefulWidget {
  const _OrdersBody({required this.controller});

  final OrdersViewController controller;

  @override
  State<_OrdersBody> createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<_OrdersBody> {
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
        14.szH,
        const _OrdersHeader().paddingSymmetric(horizontal: AppPadding.pH16),
        16.szH,
        _OrdersTabs(
          controller: widget.controller,
        ).paddingSymmetric(horizontal: AppPadding.pH16),
        16.szH,
        Expanded(
          child: AsyncBlocBuilder<OrdersCubit, List<LeaveRequestEntity>>(
            onRetry: _refresh,
            builder: (context, orders) {
              final isLoadingMore = context.read<OrdersCubit>().isLoadingMore;

              if (orders.isEmpty) {
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
                  itemCount: orders.length + (isLoadingMore ? 1 : 0),
                  separatorBuilder: (_, index) {
                    if (index >= orders.length - 1) {
                      return const SizedBox.shrink();
                    }
                    return 12.szH;
                  },
                  itemBuilder: (_, i) {
                    if (i == orders.length) {
                      return _buildFooterLoader();
                    }

                    return OrderCard(
                      order: orders[i],
                      onTap: () => Go.to(OrderDetailsScreen(id: orders[i].id)),
                      onDelete: () => _confirmDelete(context, orders[i].id),
                      onEdit: () => Go.to(
                        NewRequestScreen(
                          mode: RequestMode.edit,
                          request: orders[i],
                        ),
                      ),
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

  Future<void> _confirmDelete(BuildContext context, int requestId) async {
    if (requestId <= 0) return;
    final cubit = context.read<OrdersCubit>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const _DeleteRequestDialog(),
    );
    if (confirmed != true) return;

    await cubit.deleteRequest(
      requestId,
      leaveType: widget.controller.selectedLeaveType,
    );
  }
}
