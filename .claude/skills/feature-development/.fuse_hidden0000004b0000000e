---
name: feature-development
description: Flutter feature development workflow — Figma MCP + Postman MCP + full phase checklist.
---

# Flutter Feature Development — Full Workflow

## ⚠️ MCP Critical Rules

### Figma MCP:
- Raw numbers (16, 20) → convert to `AppSize`/`AppPadding`/`AppCircular`
- **Colors → read `color_manager.dart` FIRST, reuse existing AppColors by purpose** (e.g. dark text → `AppColors.primary`, grey text → `AppColors.hintText`, light bg → `AppColors.fill`). Only add truly new colors with **generic names** — NEVER screen-prefixed (`loginPrimary` ❌)
- **Font sizes → reduce by 1–2sp** (Figma 16 → `.s14`, Figma 14 → `.s13`, Figma 22 → `.s20`)
- **Screen-level body padding > 12px → reduce by 2–4px** (Figma 16 → 12 or 14, Figma 20 → 16). ≤ 12px → keep as-is.
- **RTL Section Verification** — Figma MCP sometimes returns sections mirrored. ALWAYS cross-check with the visual screenshot. Verify: Arabic text starts from RIGHT, horizontal lists/filters start from RIGHT, card images match Figma visual position. Trust screenshot over raw MCP data.
- **Icon background check** — some AppAssets icons already include their background. Check before wrapping in Container. If icon has built-in bg → use directly. If transparent → add Container bg.
- App is RTL — read positions from Figma AS-IS, never mirror
- No `Directionality` widget on layouts (exception: wrapping a single Text widget to fix mirrored text inside complex components like Slider/DropdownButton)
- No `Icons.*` from Material — use `AppAssets` only

### Postman MCP:
- Every Entity needs `factory initial()` — mandatory
- Every `fromJson` field needs `?? defaultValue` or nullable
- One cubit per endpoint — never merge
- Check response fully for pagination before starting

### RTL — Mandatory Check on EVERY Screen:
- `CrossAxisAlignment.start` → physical RIGHT (use for Arabic text alignment) ✅
- `CrossAxisAlignment.end` → physical LEFT ✅
- `AlignmentDirectional.centerStart` → physical RIGHT ✅
- `PositionedDirectional(start:)` → physical RIGHT ✅
- `PositionedDirectional(end:)` → physical LEFT ✅
- Row: first child → physical RIGHT, last child → physical LEFT
- Never: `Positioned(left/right:)`, `Align(Alignment.centerLeft/Right)`, `EdgeInsets.only(left/right:)`, `TextAlign.left`

---

## PHASE 1 — Audit Before Build

### Check config/ before writing any value:
- `color_manager.dart` → AppColors
- `app_sizes.dart` → AppSize, AppPadding, AppMargin, AppCircular, FontSizeManager
- `assets.gen.dart` → AppAssets
- `locale_keys.g.dart` → LocaleKeys

### Check core/ before building any widget:

> **See `flutter-base-coding-standards.mdc` sections 8.4 and 11 for full widget/helper/extension inventory.**

**Quick Reference — Must-Use Widgets:**
- Buttons: `LoadingButton` (async submit), `DefaultButton` (simple)
- Fields: `CustomTextFiled` (with label), `DefaultTextField` (raw), `AppDropdown<T>`
- State: `AsyncBlocBuilder` / `AsyncSliverBlocBuilder` / `PaginatedListWidget`
- Images: `CachedImage` (network), `UploadImageWidget`
- Scaffold: `DefaultScaffold` (inner screens) — see `scaffold-statusbar.mdc`
- Dialogs: `successDialog`, `showCustomDialog`, `showDefaultBottomSheet`
- Icons: `IconWidget` (handles SVG/PNG/Lottie/network)
- Messages: `MessageUtils.showSnackBar`

**Must-Use Helpers:** `Validators.*`, `InputFormatters.*`, `FormMixin`, `Go.*`, `ApiConstants.*`

**Golden Rule:** If it exists in `core/` or `config/` → use it. Never reinvent.

---

## PHASE 2 — Figma Analysis

### Read ALL screens for the feature:
1. Main screen (default state)
2. Empty state
3. Loading/skeleton state
4. Error state
5. All modals & bottom sheets
6. Success/failure states
7. Pagination load-more state (if applicable)

### For every Figma value:
```
Color hex → match AppColors → add if not found
Number px → match AppSize/AppPadding/AppMargin → add if not found
Font size → match FontSizeManager → add if not found
Icon → match AppAssets → add if not found
```

---

## PHASE 3 — API / Entity Rules

> **See `flutter-base-coding-standards.mdc` section 8.5 for full entity template, fromJson type table, and tryParse rules.**

### ⚠️ Entity Safety Summary (NON-NEGOTIABLE):
1. **`factory initial()`** — MANDATORY for every entity (Skeletonizer + null-safety)
2. **`fromJson` with `??` defaults** — String→`''`, int→`0`, double→`0.0`, bool→`false`, List→`[]`, Object→`.initial()`, nullable→no `??`
3. **`tryParse` ONLY** — NEVER use `int.parse()` or `double.parse()` (crashes on bad data)
4. **One cubit per endpoint** — never merge multiple services in one cubit
5. **Check response** for pagination before starting

---

## PHASE 4 — Feature Folder Structure

> **كل section / component في الشاشة لازم يكون في ملف منفصل** — مش method في نفس الـ body file.
> الـ body widget يجمع الـ sections فقط. كل section في ملف خاص.

```
lib/src/features/feature_name/
├── entity/
│   └── feature_name_entity.dart
└── presentation/
    ├── imports/
    │   └── view_imports.dart              ← all imports + part declarations
    ├── cubits/
    │   └── feature_name_cubit.dart        ← part of view_imports.dart
    ├── view/
    │   └── feature_name_screen.dart       ← part of view_imports.dart
    └── widgets/
        ├── feature_name_body.dart         ← layout only — يجمع الـ sections
        ├── feature_name_header_widget.dart ← ملف منفصل لكل section
        ├── feature_name_list_widget.dart   ← ملف منفصل
        └── feature_name_card_widget.dart   ← ملف منفصل
```

**❌ FORBIDDEN — كتابة كل الـ widgets في ملف الـ body كـ methods:**
```dart
// ❌ Everything in one file as _build methods
class _FeatureBody extends StatelessWidget {
  Widget _buildHeader() => Container(...);  // NO!
  Widget _buildFilters() => Row(...);       // NO!
  Widget _buildList() => ListView(...);     // NO!
}
```

**✅ CORRECT — كل section في ملف منفصل:**
```dart
// feature_name_body.dart — layout only
class _FeatureBody extends StatelessWidget {
  const _FeatureBody();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const _FeatureHeader().toSliver(),
      const _FeatureFilterBar().toSliver(),
      const _FeatureList(),
    ]);
  }
}
```

---

## PHASE 5 — Cubit Pattern

```dart
// part of '../imports/view_imports.dart'
@injectable
class MyFeatureCubit extends AsyncCubit<List<MyFeatureEntity>> {
  MyFeatureCubit() : super([]);

  Future<void> fetchItems() async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.myEndpoint,
          httpRequestType: HttpRequestType.get,
          mapper: (json) => (json['data']['data'] as List)
              .map((e) => MyFeatureEntity.fromJson(e))
              .toList(),
        ),
      ),
    );
  }

  // Local update on delete — NO re-fetch
  Future<void> deleteItem(int id) async {
    final result = await baseCrudUseCase.call(CrudBaseParams(
      api: '${ApiConstants.myEndpoint}/$id',
      httpRequestType: HttpRequestType.delete,
      mapper: (_) => state.data..removeWhere((e) => e.id == id),
    ));
    result.when(
      (data) => setSuccess(data: data),
      (failure) => setError(errorMessage: failure.message, showToast: true),
    );
  }
}
```

**Pagination:**
```dart
class MyCubit extends PaginatedCubit<ItemEntity> { }
// View: PaginatedListWidget(cubit: ..., itemBuilder: ...)
```

### ⚠️ CRUD Local Update Rule (NON-NEGOTIABLE)

> **NEVER re-fetch the entire list after add/edit/delete.** Always update the local state immediately.
> The API response from the action (add/edit/delete) contains enough info to update the UI without re-calling the GET service.

**Add (Insert at index 0):**
```dart
Future<void> addItem(AddItemParams params) async {
  final result = await baseCrudUseCase.call(CrudBaseParams(
    api: ApiConstants.items,
    httpRequestType: HttpRequestType.post,
    body: params.toJson(),
    mapper: (json) => ItemEntity.fromJson(json['data']),
  ));
  result.when(
    (newItem) => setSuccess(data: [newItem, ...state.data]),  // insert at index 0
    (failure) => setError(errorMessage: failure.message, showToast: true),
  );
}
```

**Edit (copyWith on matching item):**
```dart
Future<void> editItem(int id, EditItemParams params) async {
  final result = await baseCrudUseCase.call(CrudBaseParams(
    api: '${ApiConstants.items}/$id',
    httpRequestType: HttpRequestType.put,
    body: params.toJson(),
    mapper: (json) => ItemEntity.fromJson(json['data']),
  ));
  result.when(
    (updatedItem) {
      final updatedList = state.data.map((e) => e.id == id ? updatedItem : e).toList();
      setSuccess(data: updatedList);
    },
    (failure) => setError(errorMessage: failure.message, showToast: true),
  );
}
```

**Delete (removeWhere):**
```dart
Future<void> deleteItem(int id) async {
  final result = await baseCrudUseCase.call(CrudBaseParams(
    api: '${ApiConstants.items}/$id',
    httpRequestType: HttpRequestType.delete,
    mapper: (_) => state.data..removeWhere((e) => e.id == id),
  ));
  result.when(
    (data) => setSuccess(data: data),
    (failure) => setError(errorMessage: failure.message, showToast: true),
  );
}
```

```dart
// ❌ FORBIDDEN — re-fetching the entire list after action
onDeleteSuccess: () => fetchItems()      // wasteful, causes flash
onAddSuccess: () => fetchItems()         // bad UX, user loses scroll position
```

---

### RefreshIndicator — MANDATORY on All Data Screens

> Every screen that displays data from API MUST have a `RefreshIndicator` to allow pull-to-refresh.

```dart
// ✅ CORRECT — list screen with RefreshIndicator
RefreshIndicator(
  onRefresh: () => context.read<MyCubit>().fetchItems(),
  child: ListView.builder(
    physics: const AlwaysScrollableScrollPhysics(),
    itemCount: items.length,
    itemBuilder: (_, i) => ItemCard(item: items[i]),
  ),
)

// ✅ For screens with CustomScrollView
RefreshIndicator(
  onRefresh: () async {
    await context.read<BannersCubit>().fetchBanners();
    await context.read<CategoriesCubit>().fetchCategories();
  },
  child: CustomScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    slivers: [...],
  ),
)

// ❌ FORBIDDEN — no refresh capability
ListView.builder(itemCount: items.length, itemBuilder: ...)
```

---

### Empty Sections → Hide When No Data (Multi-Section Screens)

> When a screen has multiple sections, each with its own API service, **hide sections that return empty data** so the screen looks clean.

```dart
// ✅ CORRECT — section hidden when empty
AsyncBlocBuilder<BannersCubit, List<BannerEntity>>(
  builder: (context, banners) {
    if (banners.isEmpty) return const SizedBox.shrink();  // hidden!
    return BannerCarousel(banners: banners);
  },
  skeletonBuilder: (_) => const BannerSkeleton(),
)

// ❌ WRONG — showing empty section or EmptyWidget inside a multi-section screen
AsyncBlocBuilder<BannersCubit, List<BannerEntity>>(
  builder: (context, banners) {
    if (banners.isEmpty) return EmptyWidget(title: 'No banners');  // ugly in multi-section
    return BannerCarousel(banners: banners);
  },
)
```

**Rule:** `EmptyWidget` is for **full-screen empty states** (single-service screens). For sections within a multi-service screen, use `SizedBox.shrink()` to hide.

---

### Isolate for Heavy Screens (Performance Optimization)

> When a screen has **many concurrent API calls** (e.g. Home screen with 4+ services), consider using `compute()` / `Isolate` for heavy JSON parsing to prevent UI jank.

```dart
// ✅ For screens with many services (home, dashboard, etc.)
// Use compute() for heavy parsing in the mapper
mapper: (json) => compute(_parseItems, json),

// Standalone parsing function (must be top-level or static)
static List<ItemEntity> _parseItems(Map<String, dynamic> json) {
  return (json['data']['data'] as List)
      .map((e) => ItemEntity.fromJson(e))
      .toList();
}
```

**When to use Isolate:**
- Screen has 4+ concurrent API calls
- Each response has large lists (20+ items with nested objects)
- User reports jank/freeze during loading

---

## PHASE 6 — Localization

```
1. Extract all text from Figma
2. Add to assets/translations/lang.json (snake_case keys)
3. Run: dart run generate/strings/main.dart
4. Use LocaleKeys.xxx.tr() in all widgets
```

```dart
// ✅
Text(LocaleKeys.featureTitle.tr())

// ❌
Text('عنوان الصفحة')
```

---

## PHASE 7 — Pre-Delivery Checklist

```
Design & Tokens:
□ No raw Color(), Icons.*, SizedBox(N), TextStyle() — use AppColors, AppAssets, AppSize, TextStyleEx
□ Font sizes reduced 1–2sp from Figma | Screen body padding > 12px reduced 2–4px
□ All text uses LocaleKeys.xxx.tr() | Design matches Figma 100%

Entity & API:
□ Every entity has factory initial() + fromJson with ?? defaults + tryParse (never parse)
□ One cubit per endpoint | Part-of system in view_imports.dart
□ Local update on add/edit/delete (never re-fetch) | ApiConstants for all URLs

RTL (see rtl-arabic skill for full rules):
□ No Positioned(left/right), Align(centerLeft/Right), EdgeInsets.only(left/right), TextAlign.left
□ CrossAxisAlignment.start for text alignment | Row: RIGHT element = FIRST child
□ No Directionality on layouts (single Text exception only) | Visual test: titles on RIGHT

Core Widgets (see flutter-base-coding-standards.mdc section 11):
□ LoadingButton, CustomTextFiled, AppDropdown, AsyncBlocBuilder, CachedImage, Go.xxx
□ DefaultScaffold (inner) | Scaffold+SafeArea (auth) | Status bar synced

Forms:
□ FormMixin + validateAndScroll() | Validators.* + InputFormatters.* | .toEnglishNumbers()

Scroll & Performance:
□ Multi-section → CustomScrollView + Slivers (no shrinkWrap) | RefreshIndicator on data screens
□ Empty sections → SizedBox.shrink() | Heavy screens (4+ APIs) → compute()

Widget Splitting (MANDATORY):
□ Body = layout only — no _buildXxx() methods returning 10+ lines
□ Every section/card in SEPARATE file | Each added as part in view_imports.dart

Shared Widget Reuse (CRITICAL):
□ Searched app_shared/ + existing features before creating new widget
□ No duplicate cards across features | Optional params for minor variations
```
