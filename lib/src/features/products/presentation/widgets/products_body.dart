part of '../imports/products_imports.dart';

/// Body of [ProductsScreen]. Three concerns:
///   1. Render the search field (top, sticky).
///   2. Render the list / loading / error / empty states.
///   3. Apply the optional status filter (UI-side; the cubit holds the
///      unfiltered server data so toggling filters doesn't hit the API).
class _ProductsBody extends StatelessWidget {
  const _ProductsBody({required this.controller});

  final ProductsViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProductsSearchField(controller: controller),
        Expanded(
          child: AsyncBlocBuilder<ProductsCubit, List<ProductEntity>>(
            onRetry: () => context.read<ProductsCubit>().fetchProducts(
                  search: controller.searchController.text,
                ),
            builder: (context, products) {
              return ValueListenableBuilder<ProductStatus?>(
                valueListenable: controller.statusFilter,
                builder: (_, filter, _) {
                  final visible = filter == null
                      ? products
                      : products
                          .where((p) => p.status == filter)
                          .toList(growable: false);

                  if (visible.isEmpty) {
                    return const Center(child: Text('لا توجد منتجات'));
                  }

                  return RefreshIndicator(
                    onRefresh: () =>
                        context.read<ProductsCubit>().fetchProducts(
                              search: controller.searchController.text,
                            ),
                    child: ListView.separated(
                      controller: controller.scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      itemCount: visible.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (_, i) => _ProductCard(product: visible[i]),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
