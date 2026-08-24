part of '../imports/orders_imports.dart';

/// Body of [OrdersScreen]. Three concerns:
///   1. Render the header (title + filter icon).
///   2. Render the filter tabs.
///   3. Render the list / loading / error / empty states from the cubit.
class _OrdersBody extends StatelessWidget {
  const _OrdersBody({required this.controller});

  final OrdersViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        14.szH,
        const _OrdersHeader().paddingSymmetric(horizontal: AppPadding.pH16),
        16.szH,
        _OrdersTabs(
          controller: controller,
        ).paddingSymmetric(horizontal: AppPadding.pH16),
        16.szH,
        Expanded(
          child: AsyncBlocBuilder<OrdersCubit, List<LeaveRequestEntity>>(
            onRetry: () => context.read<OrdersCubit>().getOrders(
              leaveType: controller.selectedLeaveType,
            ),
            builder: (context, orders) {
              if (orders.isEmpty) {
                return EmptyWidget(
                  title: LocaleKeys.ordersEmpty,
                  desc: LocaleKeys.errorexceptionNotcontaindesc,
                );
              }

              return RefreshIndicator(
                onRefresh: () => context.read<OrdersCubit>().getOrders(
                  leaveType: controller.selectedLeaveType,
                ),
                child: ListView.separated(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: AppPadding.pH16,
                    vertical: AppPadding.pH8,
                  ),
                  itemCount: orders.length,
                  separatorBuilder: (_, _) => 12.szH,
                  itemBuilder: (_, i) => _OrderCard(
                    order: orders[i],
                    onTap: () => Go.to(OrderDetailsScreen(id: orders[i].id)),
                    onDelete: () => _confirmDelete(context, orders[i].id),
                    onEdit: () => Go.to(
                      NewRequestScreen(
                        mode: RequestMode.edit,
                        request: orders[i],
                      ),
                    ),
                  ),
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
      leaveType: controller.selectedLeaveType,
    );
  }
}
