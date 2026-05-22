part of '../imports/products_imports.dart';

/// Public entry point — wire navigators to `const ProductsScreen()`.
///
/// Responsibilities of a *screen* file:
///   - Provide the cubit(s).
///   - Own the `ViewController` lifecycle (init / dispose).
///   - Compose AppBar + body. **Never** layout content directly here —
///     that's the body widget's job.
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late final ProductsCubit _cubit;
  late final ProductsViewController _vc;

  /// rxdart subject we feed each keystroke into; emits after 350 ms of
  /// silence so search calls are debounced on the *bloc* side.
  final BehaviorSubject<String> _searchSubject = BehaviorSubject.seeded('');
  StreamSubscription<String>? _searchSub;

  @override
  void initState() {
    super.initState();
    _cubit = injector<ProductsCubit>()..fetchProducts();

    _vc = ProductsViewController(
      onSearch: _searchSubject.add,
    );

    _searchSub = _searchSubject
        .debounceTime(const Duration(milliseconds: 350))
        .distinct()
        .listen((q) => _cubit.fetchProducts(search: q));
  }

  @override
  void dispose() {
    _searchSub?.cancel();
    _searchSubject.close();
    _vc.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCubit>.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المنتجات'),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list_rounded),
              onPressed: () => _openFilterSheet(),
              tooltip: 'تصفية',
            ),
          ],
        ),
        body: _ProductsBody(controller: _vc),
      ),
    );
  }

  Future<void> _openFilterSheet() async {
    final selected = await showModalBottomSheet<ProductStatus?>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ProductsFilterSheet(current: _vc.statusFilter.value),
    );
    if (selected != null) _vc.setStatusFilter(selected);
  }
}
