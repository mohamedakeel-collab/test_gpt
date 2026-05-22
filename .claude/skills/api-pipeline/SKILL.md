---
name: api-pipeline
description: Complete API integration pipeline from Postman → ApiConstants → Entity → CrudBaseParams → Cubit → UI. Step-by-step for GET/list endpoints.
---

# Skill: API Pipeline — Postman to Working Screen

## When to Use

- عند ربط أي endpoint جديد (GET list, GET detail, DELETE)
- عند قراءة Postman collection وتحويلها لكود
- عند إنشاء cubit جديد بيجيب data من API

---

## The Pipeline (7 Steps)

```
Postman Collection
    ↓
Step 1: Read endpoint + response structure
    ↓
Step 2: Add to ApiConstants
    ↓
Step 3: Create Entity with fromJson + initial()
    ↓
Step 4: Create Cubit with executeAsync + CrudBaseParams
    ↓
Step 5: Register with @injectable + build_runner
    ↓
Step 6: Connect to UI with BlocProvider + AsyncBlocBuilder
    ↓
Step 7: Verify & test
```

---

## Step 1: Read Postman Collection

From Postman, extract:

| Field | Example | Where it goes |
|-------|---------|---------------|
| URL path | `/api/v1/products` | `ApiConstants.products` |
| HTTP method | `GET` | `HttpRequestType.get` |
| Query params | `?page=1&per_page=10` | `queryParameters:` in CrudBaseParams |
| Body (POST/PUT) | `{"name": "...", "price": 100}` | Params class `toJson()` |
| Response structure | `{"data": {"data": [...], "pagination": {...}}}` | Entity `fromJson` + mapper |
| Auth header | `Bearer {{token}}` | Handled automatically by DioService |

### Response Structure — Know Your JSON Path

```json
// Type A: Single object (detail, profile, create/update response)
// Response: {"status":"success","code":200,"message":"...","data":{...}}
→ mapper: (json) => Entity.fromJson(json['data'])

// Type B: Nested data with pagination (list endpoints) — uses 'pagination' key
// Response: {"status":"success","code":200,"message":"...","data":{"data":[...],"pagination":{...}}}
→ mapper: (json) => (json['data']['data'] as List).map(...)

// Type C: User data (login, check-code) — token inside data.user
// Response: {"status":"success","code":200,"data":{"user":{...,"token":"N|xxx"}}}
→ mapper: (json) => UserEntity.fromJson(json['data']['user'])

// Type D: Message only (delete, toggle, status change)
// Response: {"status":"success","code":200,"message":"تم الحذف بنجاح."}
→ mapper: (json) => BaseModel.fromJson(json)
```

### ⚠️ Critical Backend Patterns to Match

| Pattern | Real Backend | ❌ NOT This |
|---------|-------------|------------|
| Pagination key | `data.pagination` | `data.meta` |
| Validation errors | `data.items.{field}: [errors]` | `errors.{field}: [errors]` |
| Status field | `200` for ALL success | No 201/204 |
| Body format | `urlencoded` / `formdata` / `raw JSON` (complex nested only) | — |
| Boolean values | integer `1`/`0` | `true`/`false` |
| Token location | `data.user.token` | `data.token` |
| Status/enum fields | `{value, text_ar, text_en, tag_color}` | plain string |

---

## Step 2: Add to ApiConstants

```dart
// File: lib/src/core/network/api_endpoints.dart

class ApiConstants {
  // ... existing endpoints ...

  // Products
  static const String products = '/api/v1/products';
  static String productDetail(String id) => '/api/v1/products/$id';
  static String deleteProduct(String id) => '/api/v1/products/$id';
}
```

**Rules:**
- Static `const String` for fixed endpoints
- Static method with parameter for dynamic endpoints (with ID)
- Group by feature with comment header
- NEVER hardcode URLs in cubits — always `ApiConstants.xxx`

---

## Step 3: Create Entity

```dart
// File: lib/src/features/products/entity/product_entity.dart

class ProductEntity {
  final String id;
  final String name;
  final String image;
  final double price;
  final DateTime createdAt;
  final ProductStatus status;
  final List<VariantEntity> variants;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.createdAt,
    required this.status,
    required this.variants,
  });

  // MANDATORY: For Skeletonizer loading state
  factory ProductEntity.initial() => ProductEntity(
    id: SkeltonizerManager.short,
    name: SkeltonizerManager.medium,
    image: '',
    price: 0.0,
    createdAt: DateTime(2000),
    status: ProductStatus.active,
    variants: [],
  );

  // MANDATORY: Crash-proof fromJson
  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
    id: json['id']?.toString() ?? '',
    name: json['name']?.toString() ?? '',
    image: json['image']?.toString() ?? '',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime(2000),
    status: ProductStatus.values.firstWhere(
      (e) => e.name == json['status'],
      orElse: () => ProductStatus.active,
    ),
    variants: (json['variants'] as List?)
        ?.map((e) => e != null ? VariantEntity.fromJson(e) : VariantEntity.initial())
        .toList() ?? [],
  );

  Map<String, dynamic> get toMap => {
    'id': id,
    'name': name,
    'image': image,
    'price': price,
  };
}
```

### Entity fromJson Safety Rules:

| Type | Pattern | NEVER |
|------|---------|-------|
| String | `json['x']?.toString() ?? ''` | `json['x'] as String` |
| int | `(json['x'] as num?)?.toInt() ?? 0` | `json['x'] as int` |
| double | `(json['x'] as num?)?.toDouble() ?? 0.0` | `json['x'] as double` |
| bool | `json['x'] == true` | `json['x'] as bool` |
| DateTime | `DateTime.tryParse(json['x'] ?? '') ?? DateTime(2000)` | `DateTime.parse(json['x'])` |
| Enum | `.firstWhere((e) => e.name == json['x'], orElse: () => X.initial)` | `.byName(json['x'])` |
| List<Entity> | `(json['x'] as List?)?.map((e) => Entity.fromJson(e)).toList() ?? []` | `json['x'].map(...)` |
| Nested Object | `json['x'] != null ? Entity.fromJson(json['x']) : Entity.initial()` | `Entity.fromJson(json['x'])` |

---

## Step 4: Create Cubit

### GET List:

```dart
// File: lib/src/features/products/presentation/cubits/products_cubit.dart

part of '../imports/view_imports.dart';

@injectable
class ProductsCubit extends AsyncCubit<List<ProductEntity>> {
  ProductsCubit() : super([]);

  Future<void> fetchProducts() async {
    await executeAsync(
      operation: () => baseCrudUseCase.call(CrudBaseParams(
        api: ApiConstants.products,
        httpRequestType: HttpRequestType.get,
        mapper: (json) => (json['data']['data'] as List)
            .map((e) => ProductEntity.fromJson(e))
            .toList(),
      )),
    );
  }
}
```

### GET Detail:

```dart
@injectable
class ProductDetailCubit extends AsyncCubit<ProductEntity> {
  ProductDetailCubit() : super(ProductEntity.initial());

  Future<void> fetchProduct(String id) async {
    await executeAsync(
      operation: () => baseCrudUseCase.call(CrudBaseParams(
        api: ApiConstants.productDetail(id),
        httpRequestType: HttpRequestType.get,
        mapper: (json) => ProductEntity.fromJson(json['data']),
      )),
    );
  }
}
```

### DELETE:

```dart
@injectable
class DeleteProductCubit extends AsyncCubit<BaseModel?> {
  DeleteProductCubit() : super(null);

  Future<void> deleteProduct(String id) async {
    await executeAsync(
      operation: () => baseCrudUseCase.call(CrudBaseParams(
        api: ApiConstants.deleteProduct(id),
        httpRequestType: HttpRequestType.delete,
        mapper: (json) => BaseModel.fromJson(json),
      )),
    );
  }
}
```

### GET with Query Parameters:

```dart
Future<void> fetchProducts({String? categoryId, String? search}) async {
  await executeAsync(
    operation: () => baseCrudUseCase.call(CrudBaseParams(
      api: ApiConstants.products,
      httpRequestType: HttpRequestType.get,
      queryParameters: {
        if (categoryId != null) 'category_id': categoryId,
        if (search != null && search.isNotEmpty) 'search': search,
      },
      mapper: (json) => (json['data']['data'] as List)
          .map((e) => ProductEntity.fromJson(e))
          .toList(),
    )),
  );
}
```

### Paginated List (MANDATORY for list endpoints with standalone screens):

> **⚠️ Pagination key is `pagination` — match real backend.**

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
  List<ProductEntity> parseItems(json) => (json['data'] as List)
      .map((e) => ProductEntity.fromJson(e))
      .toList();

  @override
  PaginationMeta parsePagination(json) =>
      PaginationMeta.fromJson(json['pagination']);
}
```

---

## Step 5: Register DI

```bash
# After adding @injectable to any new cubit:
dart run build_runner build --delete-conflicting-outputs
```

**Verify:** Check that `injector.config.dart` has your new cubit registered.

---

## Step 6: Connect to UI

```dart
// Screen
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

// Body
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
            itemBuilder: (_, i) => _ProductCard(product: products[i]),
          ),
        );
      },
      skeletonBuilder: (_) => ListView.builder(
        itemCount: 8,
        itemBuilder: (_, __) => _ProductCard(product: ProductEntity.initial()),
      ),
    );
  }
}
```

---

## Step 7: Verify

- [ ] Endpoint is in `ApiConstants` (not hardcoded)
- [ ] Entity has `initial()` + crash-proof `fromJson`
- [ ] Cubit is `@injectable` + uses `executeAsync`
- [ ] `mapper:` path matches actual API response JSON structure
- [ ] `build_runner` ran successfully
- [ ] UI shows loading skeleton → data (or empty/error)
- [ ] Pull-to-refresh works
- [ ] Error state shows `ErrorView` with retry button

---

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| `mapper: (json) => json['data']` without casting | Always cast: `(json['data'] as List).map(...)` |
| Mapper path wrong (data nested differently) | Check Postman response structure carefully |
| Forgot `..fetchProducts()` in BlocProvider | Cubit starts empty → no API call happens |
| Used `HttpRequestType.post` for GET endpoint | Match the Postman HTTP method exactly |
| Entity `fromJson` crashes on null field | Use `??` defaults for every field |
| Forgot `build_runner` after adding `@injectable` | `injector<X>()` throws "not registered" error |
