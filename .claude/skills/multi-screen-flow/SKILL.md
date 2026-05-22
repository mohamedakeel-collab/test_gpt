---
name: multi-screen-flow
description: Multi-screen feature flow patterns — list/detail/edit/create with proper data passing, refresh, and screen linking in Flutter_Base.
---

# Skill: Multi-Screen Feature Flow

## When to Use

- عند بناء feature كاملة فيها أكتر من شاشة مترابطة
- عند ربط list → detail → edit → create
- عند الحاجة لتحديث شاشة بعد action في شاشة تانية

---

## Flow Overview

```
┌──────────────────────────────────────────────────────────┐
│                    TYPICAL FEATURE FLOW                    │
│                                                          │
│  List Screen ──→ Detail Screen ──→ Edit Screen           │
│       │              │                  │                 │
│       │              │                  │                 │
│       ├──→ Create Screen               │                 │
│       │         │                       │                 │
│       │    Go.back(newEntity)      Go.back(updatedEntity)│
│       │         │                       │                 │
│       ◄─────────┘                       │                 │
│       ◄─────────────────────────────────┘                │
│                                                          │
│  Detail Screen ──→ Delete                                │
│       │                │                                  │
│       │           Go.back(true)                          │
│       ◄────────────────┘                                 │
│       │                                                   │
│  Go.back(true) → List removes item                       │
└──────────────────────────────────────────────────────────┘
```

---

## Complete Example: Products Feature (4 Screens)

### File Structure

```
lib/src/features/products/
├── entity/
│   ├── product_entity.dart
│   └── product_params.dart         ← Form params for create/edit
├── presentation/
│   ├── imports/
│   │   └── view_imports.dart
│   ├── cubits/
│   │   ├── products_cubit.dart     ← List (AsyncCubit or PaginatedCubit)
│   │   ├── product_detail_cubit.dart
│   │   ├── create_product_cubit.dart
│   │   ├── edit_product_cubit.dart
│   │   └── delete_product_cubit.dart
│   ├── view/
│   │   ├── products_screen.dart         ← List screen
│   │   ├── product_detail_screen.dart   ← Detail screen
│   │   ├── create_product_screen.dart   ← Create screen
│   │   └── edit_product_screen.dart     ← Edit screen
│   └── widgets/
│       ├── products_body.dart
│       ├── product_card_widget.dart
│       ├── product_detail_body.dart
│       ├── product_form_widget.dart    ← Shared form for create + edit
│       └── ...
```

---

### Screen 1: Products List

```dart
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<ProductsCubit>()..fetchProducts(),
      child: DefaultScaffold(
        title: LocaleKeys.products.tr(),
        body: const _ProductsBody(),
      ),
    );
  }
}

class _ProductsBody extends StatelessWidget {
  const _ProductsBody();

  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<ProductsCubit, List<ProductEntity>>(
      builder: (context, products) {
        if (products.isEmpty) return const EmptyWidget();
        return RefreshIndicator(
          onRefresh: () => context.read<ProductsCubit>().fetchProducts(),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (_, i) => _ProductCard(
              product: products[i],
              onTap: () => _goToDetail(context, products[i]),
            ),
          ),
        );
      },
      skeletonBuilder: (_) => ListView.builder(
        itemCount: 8,
        itemBuilder: (_, __) => _ProductCard(product: ProductEntity.initial()),
      ),
    );
  }

  Future<void> _goToDetail(BuildContext context, ProductEntity product) async {
    final wasDeleted = await Go.to<bool>(ProductDetailScreen(product: product));
    if (wasDeleted == true) {
      if (!context.mounted) return;
      context.read<ProductsCubit>().removeProduct(product.id);
    }
  }
}
```

**FloatingActionButton for Create:**

```dart
floatingActionButton: FloatingActionButton(
  onPressed: () => _goToCreate(context),
  child: const Icon(Icons.add),
),

Future<void> _goToCreate(BuildContext context) async {
  final newProduct = await Go.to<ProductEntity>(const CreateProductScreen());
  if (newProduct != null && context.mounted) {
    context.read<ProductsCubit>().addProduct(newProduct);
  }
}
```

---

### Screen 2: Product Detail

```dart
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => injector<ProductDetailCubit>()..fetchProduct(product.id)),
        BlocProvider(create: (_) => injector<DeleteProductCubit>()),
      ],
      child: DefaultScaffold(
        title: product.name,
        body: _ProductDetailBody(product: product),
      ),
    );
  }
}

class _ProductDetailBody extends StatelessWidget {
  const _ProductDetailBody({required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteProductCubit, AsyncState<BaseModel?>>(
      listener: (context, state) {
        if (state.isSuccess) {
          Go.back(true);
        }
      },
      child: AsyncBlocBuilder<ProductDetailCubit, ProductEntity>(
        builder: (context, detail) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProductImageSection(image: detail.image),
                _ProductInfoSection(product: detail),
                _EditButton(onTap: () => _goToEdit(context, detail)),
                _DeleteButton(onTap: () => _confirmDelete(context, detail.id)),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _goToEdit(BuildContext context, ProductEntity product) async {
    final updated = await Go.to<ProductEntity>(EditProductScreen(product: product));
    if (updated != null && context.mounted) {
      context.read<ProductDetailCubit>().setSuccess(data: updated);
    }
  }

  void _confirmDelete(BuildContext context, String id) {
    showCustomDialog(
      context: context,
      child: ConfirmDialog(
        title: LocaleKeys.deleteProduct.tr(),
        onConfirm: () {
          Go.back();
          context.read<DeleteProductCubit>().deleteProduct(id);
        },
      ),
    );
  }
}
```

---

### Screen 3: Create Product

```dart
class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<CreateProductCubit>(),
      child: DefaultScaffold(
        title: LocaleKeys.createProduct.tr(),
        body: const _CreateProductBody(),
      ),
    );
  }
}

class _CreateProductBodyState extends State<_CreateProductBody> with FormMixin {
  late final CreateProductViewController _vc = CreateProductViewController();

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateProductCubit, AsyncState<ProductEntity>>(
      listener: (context, state) {
        if (state.isSuccess && state.data != null) {
          Go.back(state.data);
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            _ProductFormWidget(vc: _vc, formKey: formKey),
            16.szH,
            LoadingButton(
              title: LocaleKeys.create.tr(),
              cubit: context.read<CreateProductCubit>(),
              onTap: () {
                if (!params.validateAndScroll()) return;
                context.read<CreateProductCubit>().createProduct(_vc.toParams());
              },
            ),
          ],
        ).paddingAll(AppPadding.p16),
      ),
    );
  }
}
```

---

### Screen 4: Edit Product

```dart
class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<EditProductCubit>(),
      child: DefaultScaffold(
        title: LocaleKeys.editProduct.tr(),
        body: _EditProductBody(product: product),
      ),
    );
  }
}

class _EditProductBodyState extends State<_EditProductBody> with FormMixin {
  late final EditProductViewController _vc;

  @override
  void initState() {
    super.initState();
    _vc = EditProductViewController.fromEntity(widget.product);
  }

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProductCubit, AsyncState<ProductEntity>>(
      listener: (context, state) {
        if (state.isSuccess && state.data != null) {
          Go.back(state.data);
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            _ProductFormWidget(vc: _vc, formKey: formKey),
            16.szH,
            LoadingButton(
              title: LocaleKeys.save.tr(),
              cubit: context.read<EditProductCubit>(),
              onTap: () {
                if (!params.validateAndScroll()) return;
                context.read<EditProductCubit>().editProduct(
                  widget.product.id,
                  _vc.toParams(),
                );
              },
            ),
          ],
        ).paddingAll(AppPadding.p16),
      ),
    );
  }
}
```

---

## Data Flow Summary

| Action | Source Screen | Return Value | Target Screen Action |
|--------|-------------|-------------|---------------------|
| Create | CreateScreen | `ProductEntity` (from API response) | List: `addProduct(entity)` — insert at index 0 |
| Edit | EditScreen | `ProductEntity` (from API response) | Detail: `setSuccess(data: entity)` |
| Delete | DetailScreen | `bool` (true) | List: `removeProduct(id)` |
| Edit from List | EditScreen | `ProductEntity` | List: `updateProduct(entity)` |

---

## List Cubit Methods

```dart
@injectable
class ProductsCubit extends AsyncCubit<List<ProductEntity>> {
  ProductsCubit() : super([]);

  Future<void> fetchProducts() async { /* ... executeAsync ... */ }

  // Local CRUD operations — NEVER re-fetch
  void addProduct(ProductEntity product) {
    setSuccess(data: [product, ...state.data]);
  }

  void updateProduct(ProductEntity updated) {
    setSuccess(data: state.data.map((e) => e.id == updated.id ? updated : e).toList());
  }

  void removeProduct(String id) {
    setSuccess(data: state.data.where((e) => e.id != id).toList());
  }
}
```

---

## Shared Form Widget Pattern

> **الـ Create و Edit بيشتركوا في نفس الـ Form. اعمل widget واحد يستقبل الـ ViewController.**

```dart
class _ProductFormWidget extends StatelessWidget {
  const _ProductFormWidget({required this.vc, required this.formKey});
  final ProductViewController vc;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFiled(
            title: LocaleKeys.productName.tr(),
            controller: vc.nameController,
            validator: (v) => v?.isEmpty == true ? LocaleKeys.required.tr() : null,
          ),
          12.szH,
          CustomTextFiled(
            title: LocaleKeys.price.tr(),
            controller: vc.priceController,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
```

---

## Screen Linking Checklist

- [ ] Each screen is a separate file in `view/`
- [ ] Each screen creates its OWN BlocProvider (no shared cubits between pushed screens)
- [ ] Arguments passed via constructor
- [ ] `Go.to<ReturnType>()` used when expecting result
- [ ] `Go.back(result)` returns correct type
- [ ] `context.mounted` checked after every `await Go.to()`
- [ ] List cubit has local add/update/remove methods
- [ ] Shared form widget extracted for create + edit
- [ ] Delete confirmation uses dialog before API call
- [ ] All text uses `LocaleKeys` (zero hardcoded strings)
