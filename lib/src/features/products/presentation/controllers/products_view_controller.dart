part of '../imports/products_imports.dart';

/// View-level state that doesn't belong in a cubit:
///   - search text controller (lifecycle tied to the widget)
///   - selected status filter
///   - scroll controller
///
/// Pattern
///   - Create in `initState`.
///   - Always call `dispose()` from the screen's `dispose`.
///   - Expose state via `ValueNotifier`s so widgets can listen via
///     `ValueListenableBuilder` instead of rebuilding the whole screen.
class ProductsViewController {
  ProductsViewController({required this.onSearch});

  /// Called whenever the search term changes (already debounced).
  final ValueChanged<String> onSearch;

  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ValueNotifier<ProductStatus?> statusFilter = ValueNotifier(null);

  void setStatusFilter(ProductStatus? status) {
    statusFilter.value = status;
  }

  void clearSearch() {
    searchController.clear();
    onSearch('');
  }

  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    statusFilter.dispose();
  }
}
