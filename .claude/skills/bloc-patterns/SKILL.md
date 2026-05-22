---
name: bloc-patterns
description: AsyncCubit templates, CRUD local updates, AsyncBlocBuilder, PaginatedCubit, and BlocListener patterns for Flutter_Base.
---

# Skill: BLoC/Cubit Patterns — Flutter_Base

## ⚠️ BlocConsumer / BlocListener — Strict Usage Rules (اقرأها أولاً)

> **القاعدة الذهبية: الافتراضي هو `BlocBuilder` / `AsyncBlocBuilder` فقط.**
> **`BlocListener` و `BlocConsumer` للضرورة القصوى — مش defaults.**
> **ده decision من Senior Flutter developer — مش style preference.**

### القاعدة العامة

| الموقف | استخدم | متى |
|--------|--------|-----|
| عرض state على UI (loading/success/error) | `AsyncBlocBuilder` / `BlocBuilder` | **الافتراضي — استخدمه دايماً** |
| Side effect مرة واحدة على state change (snackbar, dialog, navigation) | `BlocListener` | فقط لو فيه فعل خارجي عن الـ UI |
| محتاج تعرض UI **و** تعمل side effect على نفس الـ widget | `BlocListener` + `BlocBuilder` منفصلين (preferred) أو `BlocConsumer` كآخر حل | نادر — لو فعلاً مفيش طريقة تفصلهم |
| تعرض جزء صغير من state (مثلاً `data.count`) | `BlocSelector` | لو الـ rebuilds كتير وعايز تقللها |

### ❌ الـ Anti-patterns (ممنوع نهائياً)

```dart
// ❌ FORBIDDEN — لف الـ body كله في BlocConsumer "لمجرد الراحة"
BlocConsumer<MyCubit, AsyncState<MyData>>(
  listener: (ctx, state) {
    if (state.isError) MessageUtils.showSnackBar(...);
  },
  builder: (ctx, state) {
    if (state.isLoading) return const SkeletonView();
    if (state.isError) return const ErrorView();
    return _BodyContent(data: state.data);
  },
)
// المشكلة: الـ AsyncBlocBuilder بيعمل نفس الـ build automatically،
// والـ BlocConsumer بيخلط بين concerns (UI + side effects)

// ❌ FORBIDDEN — BlocListener حول الـ Scaffold كله "احتياطاً"
BlocListener<UserCubit, UserState>(
  listener: (ctx, state) {
    if (state.user.isBlocked) Go.offAll(const LoginScreen());
  },
  child: Scaffold(body: ...),
)
// ← لو ده محتاج، حطه في الـ root app — مش في كل screen

// ❌ FORBIDDEN — BlocListener بدون شرط على state
BlocListener<SubmitCubit, AsyncState<bool>>(
  listener: (ctx, state) {
    MessageUtils.showSnackBar(...);  // ← runs on EVERY state, including loading!
  },
  child: ...,
)
```

### ✅ الـ Patterns الصحيحة

```dart
// ✅ الافتراضي — AsyncBlocBuilder بيعمل كل حاجة
AsyncBlocBuilder<ProductsCubit, List<ProductEntity>>(
  builder: (ctx, products) => _ProductsList(products: products),
  skeletonBuilder: (_) => const ProductsSkeleton(),
)

// ✅ BlocListener — لـ side effect واضح (navigation/snackbar/dialog)
BlocListener<SubmitCubit, AsyncState<bool>>(
  listenWhen: (prev, curr) => prev.status != curr.status,  // ← optimize
  listener: (ctx, state) {
    if (state.isSuccess) {
      MessageUtils.showSnackBar(message: LocaleKeys.saved.tr(), baseStatus: BaseStatus.success);
      Go.back();
    }
  },
  child: LoadingButton(
    cubit: ctx.read<SubmitCubit>(),
    title: LocaleKeys.submit.tr(),
    onTap: () => ctx.read<SubmitCubit>().submit(params),
  ),
)

// ✅ BlocSelector — لو محتاج part من state بس
BlocSelector<CartCubit, AsyncState<CartEntity>, int>(
  selector: (state) => state.data.itemCount,
  builder: (_, count) => BadgeIconWidget(badgeCount: count, child: const _CartIcon()),
)

// ✅ Split listener + builder — أنضف من BlocConsumer
BlocListener<MyCubit, MyState>(
  listenWhen: (p, c) => p.errorMessage != c.errorMessage,
  listener: (ctx, s) => _showError(ctx, s.errorMessage),
  child: BlocBuilder<MyCubit, MyState>(
    buildWhen: (p, c) => p.data != c.data,
    builder: (_, s) => _Body(data: s.data),
  ),
)
```

### Checklist قبل ما تكتب `BlocListener` / `BlocConsumer`

```
□ هل فيه side effect حقيقي (نavigation، snackbar، dialog، launch URL، analytics)؟
  - لو لا → استخدم BlocBuilder/AsyncBlocBuilder بس.
□ هل ممكن أحط الـ side effect ده في الـ cubit مباشرة؟ (mostly no — keep cubits pure)
□ هل ضفت `listenWhen` عشان مايتنفذش على كل state change؟
□ هل ممكن أستخدم LoadingButton بدلاً منه؟ (LoadingButton بيـ handle loading internally)
□ لو هتستخدم BlocConsumer — هل فعلاً محتاج الـ UI rebuild + side effect على نفس الـ widget؟
  - الأنضف غالباً: BlocListener منفصل + BlocBuilder منفصل
```

---

## Architecture Overview

All cubits that do API calls extend `AsyncCubit<T>`. Never create raw `Cubit` for data-fetching.

---

## AsyncCubit — Base Pattern

```dart
abstract class AsyncCubit<T> extends Cubit<AsyncState<T>> {
  // Built-in: setLoading(), setSuccess(data), setError(msg), reset(), updateData()
  // Built-in: executeAsync(operation, successEmitter, showErrorToast)
  // Built-in: baseCrudUseCase (auto-injected)
}
```

## AsyncState<T> — Built-in States

```dart
state.status        // BaseStatus enum: initial, loading, loadingMore, success, error
state.data          // T
state.errorMessage  // String?
state.isInitial / state.isLoading / state.isSuccess / state.isError / state.isLoadingMore
```

---

## Standard Cubit Template

```dart
@injectable
class ProductsCubit extends AsyncCubit<List<ProductEntity>> {
  ProductsCubit() : super([]);

  Future<void> fetchProducts() async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(CrudBaseParams(
        api: ApiConstants.products,
        httpRequestType: HttpRequestType.get,
        mapper: (json) => (json['data']['data'] as List)
            .map((e) => ProductEntity.fromJson(e)).toList(),
      )),
    );
  }
}
```

---

## CRUD Local Update Rule (NON-NEGOTIABLE)

**NEVER re-fetch the list after add/edit/delete.** Update state locally.

```dart
// Add → insert at index 0
(newItem) => setSuccess(data: [newItem, ...state.data])

// Edit → map + replace matching item
(updated) => setSuccess(data: state.data.map((e) => e.id == id ? updated : e).toList())

// Delete → removeWhere
mapper: (_) => state.data..removeWhere((e) => e.id == id)
```

---

### CRUD Response Merge — Use API Response (CRITICAL)

> **بعد الـ add/edit: استخدم الـ entity من response الـ API (اللي فيه id و server-generated fields).**
> **متستخدمش الـ user input اللي كتبه المستخدم — السيرفر ممكن يضيف/يعدل fields.**

```dart
// ✅ CORRECT — use newItem FROM API response (has server-generated id, timestamps, etc.)
result.when(
  (newItem) => setSuccess(data: [newItem, ...state.data]),
  (failure) => setError(errorMessage: failure.message, showToast: true),
);

// ❌ WRONG — using the params the user submitted (missing id, created_at, etc.)
result.when(
  (_) => setSuccess(data: [ItemEntity(name: params.name, ...), ...state.data]),
  (failure) => ...,
);
```

### Paginated CRUD — Add/Delete in PaginatedCubit

> **الـ PaginatedCubit عنده list من عدة pages. لازم تتعامل مع الـ CRUD فيه بحذر.**

```dart
// Add to paginated list — insert at index 0
(newItem) {
  final currentItems = state.data;
  setSuccess(data: [newItem, ...currentItems]);
}

// Delete from paginated list — remove by id
(id) {
  final currentItems = state.data.where((e) => e.id != id).toList();
  setSuccess(data: currentItems);
}
```

---

## AsyncBlocBuilder Usage

```dart
AsyncBlocBuilder<ProductsCubit, List<ProductEntity>>(
  builder: (context, products) {
    if (products.isEmpty) return const EmptyWidget();
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (_, i) => ProductCard(product: products[i]),
    );
  },
  skeletonBuilder: (_) => const ProductsSkeletonList(),
  errorBuilder: (ctx, error) => ErrorView(error: error, onRetry: () => ctx.read<ProductsCubit>().fetchProducts()),
)
```

### Sliver Version (CustomScrollView)
```dart
AsyncSliverBlocBuilder<ItemsCubit, List<ItemEntity>>(
  builder: (ctx, items) => SliverList.builder(
    itemCount: items.length,
    itemBuilder: (_, i) => ItemCard(item: items[i]),
  ),
)
```

---

## Multiple Cubits — MultiBlocProvider

```dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => injector<BannersCubit>()..fetchBanners()),
    BlocProvider(create: (_) => injector<CategoriesCubit>()..fetchCategories()),
  ],
  child: DefaultScaffold(title: LocaleKeys.home.tr(), body: const HomeBody()),
)
```

**Multi-section empty:** `SizedBox.shrink()` (not `EmptyWidget`).
**Heavy screens (4+ APIs):** Consider `compute()` for JSON parsing.

---

## BlocListener — For Actions

```dart
BlocListener<SubmitCubit, AsyncState<bool>>(
  listener: (context, state) {
    if (state.isSuccess) {
      MessageUtils.showSnackBar(message: LocaleKeys.success.tr(), baseStatus: BaseStatus.success);
      Go.back();
    }
  },
  child: bodyWidget,
)
```

---

## Pagination — PaginatedCubit

### List Services = Always Paginated (MANDATORY)

> **أي endpoint بيرجع list وليه شاشة مستقلة → لازم يكون `PaginatedCubit`.**
> **`AsyncCubit<List<T>>` مسموح بس للـ dropdowns والـ sub-sections الصغيرة.**

```dart
// ❌ FORBIDDEN — standalone list screen without pagination
class ProductsCubit extends AsyncCubit<List<ProductEntity>> { ... }

// ✅ CORRECT — paginated
class ProductsCubit extends PaginatedCubit<ProductEntity> { ... }
```

**Exceptions (AsyncCubit<List<T>> is OK):**
- Dropdown data (cities, categories) — small fixed list
- Multi-section sub-lists (banners inside home) — short list
- Filter chips / tags — rarely exceeds 20 items

### PaginatedCubit Template

```dart
@injectable
class ProductsCubit extends PaginatedCubit<ProductEntity> {
  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(int page, {String? key}) async {
    return baseCrudUseCase.call(CrudBaseParams(
      api: ApiConstants.products,
      httpRequestType: HttpRequestType.get,
      queryParameters: ConstantManager.paginateJson(page),
      mapper: (json) => json,
    ));
  }

  @override
  List<ProductEntity> parseItems(json) =>
      (json['data'] as List).map((e) => ProductEntity.fromJson(e)).toList();

  @override
  PaginationMeta parsePagination(json) => PaginationMeta.fromJson(json['pagination']);
}
```

### UI Widget

```dart
PaginatedListWidget<ItemEntity>(
  cubit: context.read<ItemsCubit>(),
  itemBuilder: (item) => ItemCard(item: item),
  skeletonBuilder: () => const ItemCardSkeleton(),
)
```

---

## AppDropdown with API — NO BlocBuilder Wrapper (CRITICAL)

> **AppDropdown بياخد data من API → لا تلفّه في `AsyncBlocBuilder` ولا `BlocBuilder` ولا تضيف error UI خاصة بيه.**
> **لو الـ service فشلت → الـ dropdown بيظهر فاضي (items = []). كده وخلاص. مفيش retry button، مفيش error widget.**

### Why?

الـ dropdown service صغيرة وثانوية. لو فشلت:
- المستخدم يقفل الشاشة ويفتحها تاني لو محتاج
- باقي الـ form بيكمل عادي
- إضافة error UI على dropdown = noise بصري بدون فائدة

### ✅ CORRECT — context.watch + pass items/isLoading directly

```dart
class _MyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<GetCitiesCubit>()..fetchCities(),
      child: Builder(builder: (ctx) {
        final state = ctx.watch<GetCitiesCubit>().state;
        return AppDropdown<CityEntity>(
          items: state.data,                  // ← []  لو API فشلت
          label: LocaleKeys.city.tr(),
          itemAsString: (c) => c.name,
          isLoading: state.isLoading,         // ← AppDropdown shows internal shimmer
          onChanged: (c) => params.city = c,
          validator: Validators.validateDropDown,
        );
      }),
    );
  }
}
```

### ❌ FORBIDDEN — wrapping in BlocBuilder / AsyncBlocBuilder

```dart
// ❌ Don't add error UI to dropdowns
AsyncBlocBuilder<GetCitiesCubit, List<CityEntity>>(
  errorBuilder: (ctx, err) => ErrorView(error: err),  // ← لا
  skeletonBuilder: (_) => const _DropdownSkeleton(),
  builder: (ctx, cities) => AppDropdown(items: cities, ...),
)

// ❌ Even plain BlocBuilder is overkill — use context.watch + pass state.data
BlocBuilder<GetCitiesCubit, AsyncState<List<CityEntity>>>(
  builder: (ctx, state) => AppDropdown(items: state.data, ...),
)

// ❌ Wrapping ENTIRE screen with BlocBuilder for a single dropdown
AsyncBlocBuilder<GetCitiesCubit, List<CityEntity>>(
  builder: (ctx, cities) => Column(children: [
    _Header(), _Form(), AppDropdown(items: cities), _SubmitButton(),
  ]),
)  // ← if cities API fails, ENTIRE screen stops!
```

### Rules

- AppDropdown مع service: `BlocProvider` لتوفير الـ cubit + `context.watch` لاستهلاك state — مش `AsyncBlocBuilder`
- مفيش `errorBuilder` ولا `skeletonBuilder` على الـ dropdown
- `isLoading` parameter في AppDropdown يـ handle الـ loading shimmer داخلياً
- لو فشل API → items فاضية، يكمل المستخدم باقي الـ form أو يقفل ويرجع

---

## Figma State Mapping

```
Figma "Loading"      → state.isLoading  → skeletonBuilder
Figma "Empty"        → state.isSuccess + data.isEmpty → EmptyWidget
Figma "Error"        → state.isError    → errorBuilder / ErrorView
Figma "Default"      → state.isSuccess + data.notEmpty → builder
Figma "Loading More" → state.isLoadingMore → list + loader at bottom
```

## Entity Safety

Every entity MUST have `factory initial()`, `fromJson` with `??` defaults, `tryParse` (never `parse`).
See `flutter-base-coding-standards.mdc` section 8.5 for full rules.
