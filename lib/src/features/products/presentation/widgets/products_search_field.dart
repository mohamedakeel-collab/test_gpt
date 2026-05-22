part of '../imports/products_imports.dart';

/// Bound to the [ProductsViewController]'s `searchController`.
///
/// Pumping each keystroke through `onSearch` (a `BehaviorSubject.add`
/// upstream) keeps debounce logic in one place — the screen's `initState`.
class _ProductsSearchField extends StatelessWidget {
  const _ProductsSearchField({required this.controller});

  final ProductsViewController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: TextField(
        controller: controller.searchController,
        textInputAction: TextInputAction.search,
        onChanged: controller.onSearch,
        decoration: InputDecoration(
          hintText: 'ابحث عن منتج',
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller.searchController,
            builder: (_, value, _) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: controller.clearSearch,
              );
            },
          ),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
