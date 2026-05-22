---
name: coding-standards
description: Master coding standards reference — colors, sizes, text styles, core widgets, extensions, helpers, forms, navigation, naming, entity safety, slivers, and platform config.
---

# Flutter_Base — Coding Standards

## 1. Single Import Per Feature File

```dart
// ✅ CORRECT
import '../imports/view_imports.dart';

// ❌ WRONG: scattered imports
import 'package:flutter/material.dart';
import '../../../../config/res/app_sizes.dart';
```

`view_imports.dart` uses **`part of` system** — each file in the feature starts with:
```dart
part of '../imports/view_imports.dart';
```

---

## 2. Colors → AppColors ONLY (Reuse Before Creating)

### ⚠️ Color Reuse Rule

> Read `color_manager.dart` FIRST. Match Figma colors against existing AppColors **by purpose**, not just exact hex.
> Core colors are shared across ALL screens. Only add truly new colors with **generic names** (never screen-prefixed).

```dart
// ✅ CORRECT — use existing AppColors
color: AppColors.forth,
backgroundColor: AppColors.scaffoldBackground,
style: const TextStyle().setColor(AppColors.primary) // for labels/body text

// ❌ FORBIDDEN — raw colors
Color(0xFF583D82)
Colors.purple

// ❌ FORBIDDEN — screen-prefixed color names for NEW colors
// AppColors.cartBackground // use AppColors.fill if close enough
// Note: AppColors.loginPrimary is a legacy name already used in DefaultScaffold/status bar — do NOT rename it, but do NOT create new screen-prefixed colors
```

| Hex | AppColors | Purpose |
|-----|-----------|---------|
| #1C1C1C | `AppColors.main` | Titles, headings |
| #474747 | `AppColors.primary` | Body text, labels |
| #292929 | `AppColors.secondary` | Dark secondary text |
| #583D82 | `AppColors.forth` / `AppColors.buttonColor` | Purple accent, buttons |
| #666666 | `AppColors.hintText` | Hints, subtitles, placeholders |
| #F9FAFB | `AppColors.fill` | Field/card light background |
| #FFFFFF | `AppColors.white` / `AppColors.scaffoldBackground` | White backgrounds |
| #C5C6C9 | `AppColors.border` | Borders, dividers |
| #E34D4D | `AppColors.error` | Error red |
| #DFDFDF | `AppColors.grey1` | Light grey |
| #C7C7C7 | `AppColors.grey2` | Medium grey |

**Close-match rule:** If Figma has a similar-purpose color (e.g. #6B7280 for grey text), use `AppColors.hintText` instead of creating a new one.

---

## 3. Sizes → AppSize / AppPadding / AppMargin / AppCircular

```dart
// ✅
SizedBox(height: AppSize.sH16)
padding: EdgeInsets.all(AppPadding.pH16)
BorderRadius.circular(AppCircular.r8)

// ❌ FORBIDDEN
SizedBox(height: 16)
BorderRadius.circular(8)
```

---

## 4. Text Style → Extension Chain ONLY

### ⚠️ Font Size Adjustment (Figma → Code)

> When converting from Figma, **reduce font size by 1–2sp** for visual consistency.
> - Figma ≤ 12sp → reduce by 1sp (e.g. Figma 12 → `.s11`)
> - Figma 13–18sp → reduce by 1–2sp (e.g. Figma 16 → `.s14` or `.s15`)
> - Figma ≥ 20sp → reduce by 2sp (e.g. Figma 22 → `.s20`)

```dart
// ✅ REQUIRED
Text('title', style: const TextStyle().setMainTextColor.s14.medium)
Text('hint', style: const TextStyle().setHintColor.s12.regular)
Text('error', style: const TextStyle().setErrorColor.s12.bold)

// ✅ Figma 16sp title → code .s14
Text('title', style: const TextStyle().setMainTextColor.s14.bold)

// ✅ Figma 14sp body → code .s13 or .s12
Text('body', style: const TextStyle().setMainTextColor.s13.regular)

// ❌ FORBIDDEN — raw TextStyle
TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1C1C1C))

// ❌ FORBIDDEN — using Figma font size directly without adjustment
// Figma says 16sp → DON'T use .s16, use .s14 or .s15 instead
```

### ⚠️ Font Weight Adjustment (Figma → Code)

> الخطوط من Figma أحياناً بتطلع أتقل في Flutter. جرب وزن أخف أولاً.

```dart
// Figma Bold (700) → try SemiBold (600) first, if too light then 700
// Figma SemiBold (600) → try Medium (500) first
// Figma Medium (500) → keep 500
// Figma Regular (400) → keep 400

// ✅ CORRECT — adjusted from Figma Bold 24sp
Text(title, style: const TextStyle().s22.semiBold)

// ❌ WRONG — raw Figma values (will look too big/heavy)
Text(title, style: const TextStyle().s24.bold)
```

---

## 5. Spacing → .szH / .szW Extensions

```dart
// ✅
12.szH    // SizedBox(height: 12.h)
16.szH
8.szW

// ❌
SizedBox(height: 12)
```

---

## 6. Padding/Margin → Widget Extensions

```dart
// ✅
myWidget.paddingAll(AppPadding.pH16)
myWidget.paddingSymmetric(horizontal: AppPadding.pW20)
myWidget.paddingStart(AppPadding.pW16)   // RTL-safe
myWidget.marginAll(AppMargin.mH8)
myWidget.onClick(onTap: () {})

// ❌
Padding(padding: EdgeInsets.all(16), child: myWidget)
GestureDetector(onTap: fn, child: myWidget)
```

---

## 7. Navigation → Go Class

```dart
// ✅
Go.to(const MyScreen())
Go.back()
Go.toNamed(Routes.myScreen)

// ❌
Navigator.push(context, MaterialPageRoute(builder: (_) => Screen()))
```

---

## 8. Localization → LocaleKeys ONLY

```dart
// ✅
Text(LocaleKeys.screenTitle.tr())
DefaultScaffold(title: LocaleKeys.screenTitle.tr())

// ❌
Text('العنوان')
Text('Title')
```

---

## 8.1. Forms → FormMixin + validateAndScroll() ALWAYS

```dart
// ✅ Params class uses FormMixin
class MyParams with FormMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
}

// ✅ Form uses params.formKey
Form(key: params.formKey, child: Column(children: [...]))

// ✅ Submit uses validateAndScroll() (auto-scrolls to first error)
if (params.validateAndScroll()) { await cubit.submit(params); }

// ❌ FORBIDDEN — manual form validation
final formKey = GlobalKey<FormState>();
if (formKey.currentState?.validate() ?? false) { ... }
```

---

## 8.2. Number Keyboard → toEnglishNumbers() ALWAYS

> Arabic keyboard inputs ٠١٢٣ instead of 0123. MUST convert before API calls.

```dart
// ✅ Convert Arabic numerals before sending
final phone = params.phoneController.text.toEnglishNumbers();
final amount = params.amountController.text.toEnglishNumbers();

// ✅ Add ArabicNumbersFormatter to number/phone fields
inputFormatters: [ArabicNumbersFormatter(), PhoneNumberFormatter()]

// ❌ FORBIDDEN — sending text directly from number fields
final phone = params.phoneController.text; // may contain ٠١٢٣٤
```

---

## 8.3. Fields → Validators + InputFormatters ALWAYS

> Every field MUST have a `validator` from `Validators` and appropriate `inputFormatters`.

| Field type | Validator | InputFormatters |
|---|---|---|
| Name/text | `Validators.validateEmpty` | `TextOnlyFormatter()` |
| Email | `Validators.validateEmail` | `EmailFormatter()` |
| Phone | `Validators.validatePhone` | `PhoneNumberFormatter()`, `ArabicNumbersFormatter()` |
| Password | `Validators.validatePassword` | — |
| Number | `Validators.validateEmpty` | `IntegerNumberFormatter()` or `DecimalNumberFormatter()`, `ArabicNumbersFormatter()` |
| Dropdown | `Validators.validateDropDown` | — |
| Optional | `Validators.noValidate` | (appropriate formatter) |

---

## 8.4. Helpers & Shared → AUDIT BEFORE CREATING

> **Read `core/helpers/` and `core/shared/` FIRST before writing any utility logic.**

**Available Helpers (`core/helpers/`):**
- `Validators` — form validation (empty, email, phone, password, dropdown, XSS)
- `InputFormatters` — Phone, Email, NumberOnly, TextOnly, DateTime, Integer, Decimal, NoSpecialChars
- `ArabicNumbersFormatter` — auto-converts ٠-٩ → 0-9 in text fields
- `Helpers` — `showByLang()`, `getFcmToken()`, `changeStatusbarColor()`, `shareApp()`, `getDeviceType()`
- `ImageHelper` — pick/crop images, camera, gallery, file picker
- `LauncherHelper` — launch URL, WhatsApp, social media, phone, email
- `CacheStorage` / `SecureStorage` — local storage wrappers
- `CustomLoading` — full-screen loading overlay

**Available Shared (`core/shared/`):**
- `BaseModel<T>` — generic API response wrapper
- `UserModel` — user entity
- `ImageEntity` — image model (network + local)
- `UserCubit` — current user state
- Service Locator — `injector<T>()`

**Available Extensions (`core/extensions/`):**
- `TextStyleEx` — text style chain (color, size, weight)
- `FormatString` — `.toEnglishNumbers()`, `.capitalize()`, `.toCurrency()`, `.copyToClipboard()`
- `DateTimeFormatHelper` — `.toFullDate()`, `.toTime()`, `.toDayMonthYear()`, etc.
- `ContextExtension` — `context.width`, `context.hideKeyboard()`, `context.isArabic`
- `PaddingExtension` / `MarginExtension` — RTL-safe widget padding/margin
- `OnClick` — `.onClick(onTap: fn)`
- `SizedBoxHelper` — `.szH`, `.szW`
- `SliverExtension` — `.toSliver()`
- `SeparatorExtension` — `.joinWith(separator)` on List<Widget>
- `IndexedMap` — `.indexedMap((index, item) => ...)` on List
- `FormMixin` — `formKey`, `validate()`, `validateAndScroll()`

---

## 8.5. Entity Safety → initial() + fromJson defaults + tryParse ALWAYS

### Every entity MUST have:
1. `factory initial()` — with safe default values (for Skeletonizer + null-safety)
2. `fromJson` with `??` defaults — for ALL non-nullable fields (API data can change anytime)
3. `tryParse` with fallback — NEVER use `parse` (crashes on bad data)

```dart
// ✅ CORRECT — safe entity
class ItemEntity {
  final int id;
  final String name;
  final double price;
  final String? image;

  const ItemEntity({required this.id, required this.name, required this.price, this.image});

  factory ItemEntity.initial() => const ItemEntity(id: 0, name: '', price: 0.0);

  factory ItemEntity.fromJson(Map<String, dynamic> json) => ItemEntity(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    price: double.tryParse(json['price'].toString()) ?? 0.0,
    image: json['image'],  // nullable — no ??
  );
}

// ❌ FORBIDDEN — unsafe entity
class ItemEntity {
  factory ItemEntity.fromJson(Map<String, dynamic> json) => ItemEntity(
    id: int.parse(json['id']),       // CRASH on null/wrong type
    name: json['name'],               // CRASH on null
    price: json['price'] as double,   // CRASH on null/wrong type
  );
  // Missing factory initial() ← FORBIDDEN
}
```

### tryParse rule:
```dart
// ✅ ALWAYS use tryParse + fallback
int.tryParse(value.toString()) ?? 0
double.tryParse(value.toString()) ?? 0.0

// ❌ NEVER use parse (throws on bad data)
int.parse(value)
double.parse(value)
```

---

## 8.6. Multiple Scrollables → CustomScrollView + Slivers (MANDATORY)

> When a screen body has **more than one scrollable section** (e.g. banner + list, header + grid + list, filters + products), **ALWAYS** use `CustomScrollView` with slivers instead of nesting scroll widgets inside `SingleChildScrollView`.

### Why?
- `SingleChildScrollView` + nested `ListView` = **double scroll conflict** → jank, layout errors, bad performance
- `shrinkWrap: true` on nested lists forces Flutter to **lay out ALL items at once** → defeats lazy loading, kills performance on large lists
- `CustomScrollView` with slivers = **single unified scroll** → smooth, lazy-loaded, no conflicts

### Decision Rule:

| Screen structure | Approach |
|---|---|
| Single list/grid only | `ListView.builder` or `GridView.builder` directly |
| Static content + 1 list at bottom | `CustomScrollView` + `SliverToBoxAdapter` (static) + `SliverList` |
| Multiple sections (header + filters + list + footer) | `CustomScrollView` + slivers for everything |
| Multiple API sections (banners + categories + products) | `CustomScrollView` + `AsyncSliverBlocBuilder` per section |

### ✅ CORRECT — CustomScrollView with slivers:

```dart
CustomScrollView(
  physics: const AlwaysScrollableScrollPhysics(),
  slivers: [
    // Static header → wrap in SliverToBoxAdapter (or use .toSliver())
    _buildHeader().toSliver(),

    // Filter chips → wrap in SliverToBoxAdapter
    _buildFilters().toSliver(),

    // API list → use SliverList.builder (lazy loaded!)
    SliverList.builder(
      itemCount: items.length,
      itemBuilder: (_, i) => ItemCard(item: items[i]),
    ),

    // Bottom spacing
    SliverToBoxAdapter(child: 20.szH),
  ],
)
```

### ✅ CORRECT — Multi-API screen with AsyncSliverBlocBuilder:

```dart
CustomScrollView(
  physics: const AlwaysScrollableScrollPhysics(),
  slivers: [
    // Banners section
    AsyncSliverBlocBuilder<BannersCubit, List<BannerEntity>>(
      builder: (ctx, banners) {
        if (banners.isEmpty) return const SizedBox.shrink().toSliver();
        return BannerCarousel(banners: banners).toSliver();
      },
    ),

    // Categories section
    AsyncSliverBlocBuilder<CategoriesCubit, List<CategoryEntity>>(
      builder: (ctx, cats) {
        if (cats.isEmpty) return const SizedBox.shrink().toSliver();
        return CategoriesRow(categories: cats).toSliver();
      },
    ),

    // Products grid
    AsyncSliverBlocBuilder<ProductsCubit, List<ProductEntity>>(
      builder: (ctx, products) {
        if (products.isEmpty) return const SizedBox.shrink().toSliver();
        return SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: products.length,
          itemBuilder: (_, i) => ProductCard(product: products[i]),
        );
      },
    ),
  ],
)
```

### ❌ FORBIDDEN — nested scrollables:

```dart
// ❌ SingleChildScrollView + nested ListView = BAD performance
SingleChildScrollView(
  child: Column(
    children: [
      _buildHeader(),
      _buildFilters(),
      ListView.builder(           // ← nested scroll inside scroll!
        shrinkWrap: true,          // ← forces layout of ALL items
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (_, i) => ItemCard(item: items[i]),
      ),
    ],
  ),
)

// ❌ Multiple shrinkWrap lists = VERY BAD
SingleChildScrollView(
  child: Column(
    children: [
      ListView.builder(shrinkWrap: true, physics: NeverScrollableScrollPhysics(), ...),
      ListView.builder(shrinkWrap: true, physics: NeverScrollableScrollPhysics(), ...),
      GridView.builder(shrinkWrap: true, physics: NeverScrollableScrollPhysics(), ...),
    ],
  ),
)
```

### Sliver Quick Reference:

| Normal widget | Sliver equivalent |
|---|---|
| Any widget | `widget.toSliver()` or `SliverToBoxAdapter(child: widget)` |
| `ListView.builder` | `SliverList.builder(itemCount, itemBuilder)` |
| `ListView.separated` | `SliverList.separated(itemCount, itemBuilder, separatorBuilder)` |
| `GridView.builder` | `SliverGrid.builder(gridDelegate, itemCount, itemBuilder)` |
| `Padding` around slivers | `SliverPadding(padding, sliver: ...)` |
| Fill remaining space | `SliverFillRemaining(child: ...)` |
| `AsyncBlocBuilder` | `AsyncSliverBlocBuilder` |

### When SingleChildScrollView IS acceptable:
- Screen has **only static content** (forms, text, images — no lists/grids)
- Auth screens (login, register) where content is fixed and short
- Detail screens with **no lists** — just static fields

---

## 9. Screen Structure

> **See `scaffold-statusbar.mdc` rule for which scaffold to use per screen type.**

```dart
// ✅ Inner screens (most screens): StatelessWidget + BlocProvider + DefaultScaffold
class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<MyCubit>()..fetchData(),
      child: DefaultScaffold(
        title: LocaleKeys.myTitle.tr(),
        body: const _MyBody(),
      ),
    );
  }
}

// ✅ Auth screens: plain Scaffold + SafeArea (no appbar)
// Status bar: Helpers.changeStatusbarColor(statusBarColor: AppColors.scaffoldBackground, statusBarIconBrightness: Brightness.dark)

// ❌ FORBIDDEN — building custom header inside body widget for inner screens
// Use DefaultScaffold instead — it handles colored header, back arrow, title, status bar
```

---

## 10. RTL Rules — CRITICAL

**App is RTL by default — use directional APIs everywhere.**

> **See `rtl-arabic` skill for full RTL rules, conversion tables, and examples.**

### The Core Equation:
```
Flutter "start" = physical RIGHT = Arabic text side = Figma RIGHT side
Flutter "end"   = physical LEFT  = Figma LEFT side
Row first child = physical RIGHT | Row last child = physical LEFT
```

### Quick Forbidden List:
```dart
// ❌ ALL FORBIDDEN — use directional alternatives
Positioned(left/right: x)       // use PositionedDirectional(end/start: x)
Align(Alignment.centerLeft/Right) // use AlignmentDirectional.centerEnd/Start
EdgeInsets.only(left/right: x)   // use EdgeInsetsDirectional.only(end/start: x)
TextAlign.left/right             // use TextAlign.start/end
```

> **Note:** `Directionality(textDirection: TextDirection.rtl)` مسموح على مستوى widget واحد فقط لحل مشكلة نص معكوس داخل component — ممنوع على مستوى الشاشة.

---

## 11. Core Widgets — USE BEFORE BUILDING NEW

> **Golden Rule:** Search `core/widgets/` before writing any widget. If it exists → use it.

### 11.1 — Buttons (`core/widgets/buttons/`)

| Widget | Usage |
|--------|-------|
| `LoadingButton(title, onTap)` | Async button with built-in loading state — use for ALL form submits |
| `DefaultButton(title, onTap)` | Simple non-async button |
| `ButtonClose()` | Standard close/dismiss button |
| `CustomAnimatedButton(...)` | Animated press-effect button |

```dart
// ✅ CORRECT — async form submit
LoadingButton(
  title: LocaleKeys.submit.tr(),
  color: AppColors.primary,
  borderRadius: AppCircular.r12,
  onTap: () async => context.read<MyCubit>().submit(params),
)
```

---

### 11.2 — Text Fields (`core/widgets/fields/text_fields/`)

| Widget | Usage |
|--------|-------|
| `CustomTextFiled(hint, title, controller, validator, textInputType, textInputAction)` | **Primary field** — includes label + asterisk + validation styling. Use for all form fields. |
| `DefaultTextField(...)` | Base field — used inside CustomTextFiled. Use directly only if no label needed. |
| `CustomPinTextField(controller, onCompleted)` | OTP / PIN 4-digit field with pinput |

```dart
// ✅ CORRECT — form field with label
CustomTextFiled(
  title: LocaleKeys.phoneLabel.tr(),
  hint: LocaleKeys.phoneHint.tr(),
  controller: params.phoneController,
  textInputType: TextInputType.phone,
  textInputAction: TextInputAction.next,
  validator: Validators.validatePhone,
  inputFormatters: [PhoneNumberFormatter()],
)

// ❌ WRONG — don't build a custom labeled field from scratch
```

---

### 11.3 — Dropdowns (`core/widgets/fields/drop_downs/`)

| Widget | Usage |
|--------|-------|
| `AppDropdown<T>(items, onChanged, itemAsString, label, hint)` | Full-featured dropdown with search, multi-select, loading/error states |

```dart
// ✅ CORRECT
AppDropdown<CityEntity>(
  items: cities,
  label: LocaleKeys.city.tr(),
  hint: LocaleKeys.selectCity.tr(),
  value: selectedCity,
  itemAsString: (c) => c.name,
  onChanged: (c) => setState(() => selectedCity = c),
  validator: Validators.validateDropDown,
  isLoading: cubit.isLoading,
)
```

Key params: `isMultiSelect`, `showSearchBox`, `isLoading`, `isFailer`, `readonly`, `maxHeight`

---

### 11.4 — Dialogs & Bottom Sheets (`core/widgets/dialogs/` + `core/widgets/pickers/`)

| Function | Usage |
|----------|-------|
| `successDialog(context, title: ..., desc: ...)` | Standard success popup with Lottie animation + auto-close |
| `showCustomDialog(context, child: ...)` | Generic styled dialog with scale+fade animation |
| `showDefaultBottomSheet(child: ...)` | Standard bottom sheet with drag handle |
| `CustomDatePicker` | Date picker widget |

```dart
// ✅ CORRECT — success after API call
successDialog(context, title: LocaleKeys.savedSuccessfully.tr());

// ✅ CORRECT — custom dialog
showCustomDialog(
  context,
  child: MyDialogContent(),
  barrierDismissible: true,
);

// ✅ CORRECT — bottom sheet
showDefaultBottomSheet(child: MySheetContent());
```

---

### 11.5 — State Handling (`core/widgets/handling_views/` + `core/widgets/tools/`)

| Widget | Usage |
|--------|-------|
| `AsyncBlocBuilder<Cubit, DataType>(builder: ..., skeletonBuilder: ...)` | Wraps loading/error/success states automatically |
| `AsyncSliverBlocBuilder<Cubit, DataType>(...)` | Sliver version for CustomScrollView |
| `PaginatedListWidget<Cubit, ItemType>(itemBuilder: ..., config: ...)` | Paginated list with infinite scroll |
| `EmptyWidget(title: ..., desc: ..., path: ...)` | Empty state with image/lottie |
| `ErrorView(error: ...)` | Error state with Lottie animation |

```dart
// ✅ CORRECT — API-driven list
AsyncBlocBuilder<GetItemsCubit, List<ItemEntity>>(
  skeletonBuilder: (ctx) => ItemSkeleton(),
  builder: (ctx, items) => items.isEmpty
      ? EmptyWidget(title: LocaleKeys.noItems.tr(), desc: '')
      : ListView.builder(itemBuilder: ...),
)

// ✅ CORRECT — paginated list
PaginatedListWidget<GetItemsCubit, ItemEntity>(
  itemBuilder: (ctx, item, idx) => ItemCard(item: item),
  emptyWidget: EmptyWidget(title: LocaleKeys.noItems.tr(), desc: ''),
)
```

---

### 11.6 — Image Widgets (`core/widgets/image_widgets/`)

| Widget | Usage |
|--------|-------|
| `CachedImage(url, width, height)` | Cached network image with placeholder + tap-to-view |
| `CustomAvatar(url, radius)` | Circular avatar from network |
| `UploadImageWidget(onUpload)` | Image upload with native picker, single or multi |
| `ImageView(mediaPath, mediaType, mediaSource)` | Full-screen image/video viewer |

```dart
// ✅ Network image
CachedImage(url: item.image, width: AppSize.sW60, height: AppSize.sH60,
  borderRadius: BorderRadius.circular(AppCircular.r8))

// ✅ Circular avatar
CachedImage(url: user.photo, width: AppSize.sW44, height: AppSize.sH44,
  boxShape: BoxShape.circle)

// ✅ Upload
UploadImageWidget(
  uploadImageType: UploadImageType.single,
  onUpload: (files) => params.imageFile = files.first,
)
```

---

### 11.7 — Other Widgets

| Widget | Usage |
|--------|-------|
| `IconWidget(icon, color, height, width)` | Versatile — handles SVG/PNG/Lottie/network/IconData automatically |
| `BadgeIconWidget(child, badgeCount)` | Badge overlay on any widget |
| `CustomHtmlWidget(data)` | Renders HTML content with project styles |
| `RiyalPriceText(price)` | Saudi Riyal symbol with correct font |
| `CustomLoading.showLoadingView()` | Centered SpinKit loading indicator |
| `CustomLoading.showFullScreenLoading()` | Full-screen overlay loader |
| `MessageUtils.showSnackBar(context, baseStatus, message)` | Themed snackbar |

```dart
// ✅ Icon (SVG from assets)
IconWidget(icon: AppAssets.svg.baseSvg.search.path, color: AppColors.primary, height: AppSize.sH20)

// ✅ Badge
BadgeIconWidget(child: IconWidget(...), badgeCount: unreadCount)

// ✅ Price
RiyalPriceText(price: '250.00', priceTextStyle: const TextStyle().setMainTextColor.s14.bold)
// OR
Text('250.00', style: ...).withRiyalPrice(color: AppColors.primary)

// ✅ Snackbar
MessageUtils.showSnackBar(context: context, baseStatus: BaseStatus.success, message: LocaleKeys.saved.tr())
```

---

### 11.8 — Scaffold + Status Bar

> **See `scaffold-statusbar.mdc` for full scaffold selection guide and status bar rules.**

- Inner screens → `DefaultScaffold` (handles header + status bar automatically)
- Auth screens → plain `Scaffold` + `SafeArea` (no appbar)
- Home → custom `Scaffold` + `CustomNavigationBar`
- **NEVER** build custom header containers in body widgets

---

## 12. Extensions — USE ALWAYS

### 12.1 — TextStyleEx (`core/extensions/text_style_extensions.dart`)

```dart
// Font weight
const TextStyle().bold       // FontWeight.bold
const TextStyle().semiBold   // w600
const TextStyle().medium     // w500
const TextStyle().regular    // w400
const TextStyle().light      // w300

// Font size (uses screenutil .sp)
const TextStyle().s12   // 12.sp
const TextStyle().s14   // 14.sp
const TextStyle().s16   // 16.sp

// Colors (from AppColors)
const TextStyle().setMainTextColor    // AppColors.main
const TextStyle().setSecondryColor    // AppColors.secondary
const TextStyle().setHintColor        // AppColors.hintText
const TextStyle().setErrorColor       // AppColors.error
const TextStyle().setWhiteColor       // AppColors.white
const TextStyle().setPrimaryColor     // AppColors.primary
const TextStyle().setColor(AppColors.xxx)  // custom color

// Chain example
const TextStyle().setMainTextColor.s14.semiBold
```

### 12.2 — Padding/Margin Extensions

```dart
// Padding (RTL-safe versions preferred)
widget.paddingAll(AppPadding.pH16)
widget.paddingSymmetric(horizontal: AppPadding.pW20, vertical: AppPadding.pH8)
widget.paddingStart(AppPadding.pW16)   // ✅ RTL-safe (physical right)
widget.paddingEnd(AppPadding.pW16)     // ✅ RTL-safe (physical left)
widget.paddingOnly(top: AppPadding.pH8, bottom: AppPadding.pH8)
widget.paddingOnlyDirectional(start: AppPadding.pW16)

// Margin
widget.marginAll(AppMargin.mH8)
widget.marginSymmetric(horizontal: AppMargin.mW16)
widget.marginTop(AppMargin.mH12)
widget.marginBottom(AppMargin.mH12)
widget.marginStart(AppMargin.mW16)   // ✅ RTL-safe
widget.marginEnd(AppMargin.mW16)     // ✅ RTL-safe
```

### 12.3 — SizedBox Helpers

```dart
12.szH   // SizedBox(height: 12.h)
16.szW   // SizedBox(width: 16.w)
// Use AppSize constants: AppSize.sH12.szH
```

### 12.4 — Click Extension

```dart
myWidget.onClick(onTap: () => Go.to(const NextScreen()))
```

### 12.5 — Context Extension

```dart
context.width    // MediaQuery width
context.height   // MediaQuery height
context.locale   // current Locale
```

---

## 13. Helpers — USE BEFORE WRITING CUSTOM LOGIC

### 13.1 — Validators (`core/helpers/validators.dart`)

```dart
// ✅ Use in form fields
validator: Validators.validateEmpty
validator: Validators.validateEmail
validator: Validators.validatePhone    // digits only, 8-15 chars
validator: Validators.validatePassword // uppercase + lowercase + digit + special
validator: (v) => Validators.validatePasswordConfirm(v, pass)
validator: Validators.validateDropDown<T>
validator: Validators.noValidate      // no validation, XSS check only
```

### 13.2 — InputFormatters (`core/helpers/input_formatters.dart`)

```dart
inputFormatters: [PhoneNumberFormatter()]        // digits + +, -, (, )
inputFormatters: [EmailFormatter()]              // email chars only
inputFormatters: [NumberOnlyFormatter()]         // digits only
inputFormatters: [TextOnlyFormatter()]           // letters + arabic + spaces
inputFormatters: [TextWithNumberFormatter()]     // letters + numbers + arabic
inputFormatters: [IntegerNumberFormatter()]      // integers, optional max value
inputFormatters: [DecimalNumberFormatter()]      // decimals, optional decimal places
inputFormatters: [DateTimeFormatter()]           // auto-format DD/MM/YYYY
inputFormatters: [NoSpecialCharactersFormatter()] // no special chars
```

### 13.3 — Helpers (`core/helpers/helpers.dart`)

```dart
Helpers.showByLang(ar: 'عربي', en: 'English')  // returns string based on locale
Helpers.getFcmToken()                            // FCM push token
Helpers.changeStatusbarColor(statusBarColor: ...) // status bar tint
Helpers.shareApp(url)                           // share via share_plus
Helpers.getDeviceType()                         // 'ios' or 'android'
```

### 13.4 — CacheService (`core/helpers/cache_service.dart`)

Local storage via shared preferences — use for tokens, user prefs, etc.

---

## 14. Navigation → Go Class (ONLY)

```dart
Go.to(const MyScreen())                  // push
Go.off(const MyScreen())                 // pushReplacement
Go.offAll(const MyScreen())              // pushAndRemoveUntil (clear stack)
Go.back()                               // pop
Go.backToInitial()                      // pop to first route
Go.toNamed(NamedRoutes.myScreen)        // named push
Go.offNamed(NamedRoutes.myScreen)       // named replacement
Go.offAllNamed(NamedRoutes.myScreen)    // named clear stack
Go.context                              // global context (for dialogs etc.)

// ❌ FORBIDDEN
Navigator.push(context, MaterialPageRoute(...))
```

---

## 15. Network — API Pattern

```dart
// ✅ All API calls via baseCrudUseCase inside AsyncCubit
await executeAsync(
  operation: () async => baseCrudUseCase.call(
    CrudBaseParams(
      api: ApiConstants.myEndpoint,      // from api_endpoints.dart — no raw strings
      httpRequestType: HttpRequestType.get,
      mapper: (json) => MyEntity.fromJson(json['data']),
      body: params.toJson(),             // for POST/PUT
      queryParameters: {'page': page},  // for GET with query
    ),
  ),
);

// ❌ FORBIDDEN
Dio().get('https://api.example.com/endpoint')
```

All endpoints → `ApiConstants` in `core/network/api_endpoints.dart`. Add new endpoints there.

---

## 16. Screen-Level Padding/Margin Adjustment (Figma → Code)

> Figma MCP often returns large padding/margin for the screen body. These look oversized on device.
> - Figma body padding ≤ 12px → **keep as-is**
> - Figma body padding > 12px → **reduce by 2–4px** (e.g. Figma 16 → 12 or 14, Figma 20 → 16)
> - This applies ONLY to screen-level body padding — NOT card-internal or component padding.

---

## 17. Icon Background Check (AppAssets)

> Some SVG/PNG icons in AppAssets already include their background shape (circle/rect with fill).
> **Always check the asset** before wrapping in a Container with a background color.
> - Icon has background → use `IconWidget` directly, no Container wrapper
> - Icon is transparent → wrap in Container with the desired background

```dart
// ✅ Icon already has background baked in
IconWidget(icon: AppAssets.svg.featureSvg.myIcon.path, height: AppSize.sH40)

// ✅ Icon is transparent — add background
Container(
  decoration: BoxDecoration(color: AppColors.fill, borderRadius: BorderRadius.circular(AppCircular.r10)),
  child: IconWidget(icon: AppAssets.svg.baseSvg.search.path, color: AppColors.primary, height: AppSize.sH20),
)

// ❌ WRONG — double background
Container(color: AppColors.fill, child: IconWidget(icon: iconWithBuiltInBg))
```

---

## 18. Network Images → CachedImage ALWAYS

> ALL network/remote images (cards, lists, details, avatars) MUST use `CachedImage` from `core/widgets/image_widgets/cached_image.dart`.
> Never use `Image.network()` directly.

```dart
// ✅ Card image
CachedImage(url: item.image, width: AppSize.sW60, height: AppSize.sH60,
  borderRadius: BorderRadius.circular(AppCircular.r8))

// ✅ Circular avatar
CachedImage(url: user.photo, width: AppSize.sW44, height: AppSize.sH44,
  boxShape: BoxShape.circle)

// ❌ FORBIDDEN
Image.network(item.image, width: 60, height: 60)
```

---

## 19. Access Modifiers — ALWAYS Apply

> Use proper Dart access modifiers when creating classes, methods, and fields.

```dart
// ✅ Private widget (used only inside same file / part-of file)
class _MyFeatureBody extends StatelessWidget { ... }

// ✅ Private method (not exposed outside class)
void _handleTap() { ... }

// ✅ Private field
final String _internalValue;

// ✅ Public API — only what needs to be accessed from outside
class MyFeatureCubit extends AsyncCubit<List<ItemEntity>> {
  Future<void> fetchItems() async { ... }  // public — called from view
  void _processData(List data) { ... }     // private — internal logic
}

// ❌ WRONG — everything public by default
class MyWidget {
  String helperValue = '';          // should be _helperValue if internal
  void processInternal() { ... }   // should be _processInternal if not needed outside
}
```

**Rules:**
- Widget classes used only within their feature file → prefix with `_` (private)
- Helper methods not called from outside → prefix with `_`
- Fields not exposed to other classes → prefix with `_`
- Only expose what is needed for the public API

---

## 20. Naming Conventions — MANDATORY

> Every variable, function, class, and file name MUST be descriptive and self-documenting.

| Element | Convention | Example |
|---|---|---|
| File names | `snake_case` | `category_factories_body.dart` |
| Class names | `PascalCase` | `CategoryFactoriesBody` |
| Variables / fields | `camelCase` | `selectedCategory`, `isLoading` |
| Constants | `camelCase` or `SCREAMING_SNAKE` | `maxRetryCount`, `API_TIMEOUT` |
| Functions / methods | `camelCase`, verb-first | `fetchCategories()`, `deleteItem()`, `handleSubmit()` |
| Cubits | `VerbNounCubit` | `GetCategoriesCubit`, `DeleteItemCubit` |
| Entities | `NounEntity` | `CategoryEntity`, `ProductEntity` |
| Params | `NounParams` | `AddProductParams`, `LoginParams` |
| Screens | `NounScreen` | `CategoryFactoriesScreen` |
| Body widgets | `NounBody` | `CategoryFactoriesBody` |

```dart
// ✅ GOOD — descriptive names
final List<CategoryEntity> availableCategories;
Future<void> fetchCategoryFactories() async { ... }
class GetCategoryFactoriesCubit extends AsyncCubit<...> { ... }

// ❌ BAD — vague/abbreviated
final List<CategoryEntity> data;    // "data" tells nothing
Future<void> fetch() async { ... }  // fetch what?
class MyCubit extends AsyncCubit<...> { ... } // "My" is meaningless
```

---

## 21. Shared Widget Reuse — AUDIT BEFORE CREATING (CRITICAL)

> **قبل إنشاء أي widget جديد — لازم تراجع الشاشات والـ features اللي اتعملت قبل كده.**
> لو فيه card أو component بنفس التصميم أو تصميم قريب → **استدعيه بدل ما تكرره.**

**Rule:** Before building ANY card/component widget:
1. **Search `app_shared/widgets/`** — is it already shared?
2. **Search existing features** — does a similar widget exist (especially from recent screens)?
3. If same design 100% → **use it directly**
4. If minor differences → **add optional params** to the existing widget (don't create a copy)
5. If used in 2+ features → **move to `app_shared/widgets/`**
6. **Never duplicate** card widgets across features

```
lib/src/features/logic/app_shared/
├── widgets/
│   ├── product_card_widget.dart    ← reused across home, search, category screens
│   ├── factory_card_widget.dart    ← reused across categories and search
│   └── order_summary_widget.dart   ← reused across orders and checkout
```

```dart
// ✅ Reuse shared card
import '../../../app_shared/widgets/product_card_widget.dart';
ProductCardWidget(product: item)

// ✅ Same card with minor variations → optional params
ProductCardWidget(product: item, showPrice: false, showRating: true)

// ❌ WRONG — duplicate the same card in every feature
// features/home/widgets/home_product_card.dart  ← copy 1
// features/search/widgets/search_product_card.dart  ← copy 2 (same widget!)
// features/favorites/widgets/fav_product_card.dart  ← copy 3 (same widget!)
```

---

## 22. ViewController Class Pattern (MANDATORY)

> **Controllers, ValueNotifiers, AnimationControllers, params — كل حاجة تتعلق بالـ UI state لازم تكون في class منفصل (ViewController)، مش مباشرة في الـ View.**

```dart
// ✅ CORRECT — Separate ViewController class
class ChatViewController {
  final TextEditingController messageController = TextEditingController();
  final ValueNotifier<bool> isSending = ValueNotifier(false);

  void onSend(BuildContext context) {
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    context.read<ChatCubit>().sendMessage(text);
    messageController.clear();
  }

  void dispose() {
    messageController.dispose();
    isSending.dispose();
  }
}

// ✅ View uses one ViewController object
class _ChatInputState extends State<_ChatInput> {
  late final ChatViewController _vc = ChatViewController();

  @override
  void dispose() { _vc.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: DefaultTextField(controller: _vc.messageController, title: LocaleKeys.typeMessage.tr())),
      8.szW,
      ValueListenableBuilder<bool>(
        valueListenable: _vc.isSending,
        builder: (_, sending, __) => _SendButton(onTap: () => _vc.onSend(context), isLoading: sending),
      ),
    ]);
  }
}

// ❌ FORBIDDEN — controllers/logic scattered in view
class _ChatInputState extends State<_ChatInput> {
  final _controller = TextEditingController(); // ← should be in VC
  bool _isSending = false;                      // ← should be ValueNotifier in VC
  void _onSend() { setState(() => ...); }       // ← should be in VC
}
```

**Rules:**
- كل `TextEditingController`, `ValueNotifier`, `ScrollController`, `FocusNode` → داخل ViewController
- كل UI logic function → داخل ViewController
- استخدم `ValueNotifier` + `ValueListenableBuilder` بدل `setState`
- الـ View تنادي `_vc.dispose()` في `dispose()`

---

## 23. Icon Inside Container → Center Widget (MANDATORY)

> **أي أيقونة داخل Container بـ background لازم تتلف في `Center` widget.**

```dart
// ✅ CORRECT
Container(
  width: AppSize.sH48, height: AppSize.sH48,
  decoration: BoxDecoration(color: AppColors.grey1, borderRadius: BorderRadius.circular(AppCircular.r8)),
  child: Center(
    child: IconWidget(icon: AppAssets.svg.appSvg.sent.path, width: AppSize.sW24, height: AppSize.sH24, color: AppColors.main),
  ),
)

// ❌ WRONG — Icon stretches to Container size
Container(
  width: AppSize.sH48, height: AppSize.sH48,
  child: IconWidget(...),  // ← no Center = stretches!
)
```

---

## 24. Section Sub-Folders — Complex Screens

> **لما الشاشة فيها 4+ sections مختلفة، كل مجموعة مرتبطة حطها في sub-folder.**

```
widgets/
├── feature_body.dart          ← layout only (stays at root)
├── header/                    ← header group
│   ├── header_widget.dart
│   └── search_bar.dart
├── products/                  ← products group
│   ├── products_section.dart
│   └── product_card.dart
```

- 4+ sections مع 2+ widgets لكل section → sub-folders
- شاشة بسيطة (body + card + filter) → flat structure

---

## 25. Platform Configuration — Android & iOS (MANDATORY)

> **أي feature تحتاج camera, gallery, microphone, location, maps → لازم تضيف permissions للـ Android و iOS.**

| Feature | Android (AndroidManifest.xml) | iOS (Info.plist) |
|---------|------|------|
| Camera | `CAMERA` permission | `NSCameraUsageDescription` |
| Gallery | `READ_EXTERNAL_STORAGE`, `READ_MEDIA_IMAGES` | `NSPhotoLibraryUsageDescription` |
| Microphone | `RECORD_AUDIO` | `NSMicrophoneUsageDescription` |
| Location/Maps | `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION` | `NSLocationWhenInUseUsageDescription` |
| Google Maps | `com.google.android.geo.API_KEY` meta-data | `GMSServices.provideAPIKey()` in AppDelegate |

**Prefer method channels over `permission_handler` package** — أقل dependencies وتحكم أكبر.

---

## 26. Package Preference — Use Existing Packages

> **لو فيه حاجة ممكن تتعمل بـ package مستقر → استخدمه. لا تبني من الصفر.**

| Feature | Use Package | Don't Build |
|---------|-------------|-------------|
| Rating stars | `flutter_rating_bar` | ❌ Custom star widget |
| Charts | `fl_chart` | ❌ Custom canvas |
| QR code | `qr_flutter` / `mobile_scanner` | ❌ Custom renderer |
| Maps | `google_maps_flutter` | ❌ Custom map |
| Signature | `signature` | ❌ Custom gesture drawing |
| WebView | `webview_flutter` | ❌ Custom browser |

قبل ما تبني أي حاجة: ابحث pub.dev → تأكد إنه مستقر → أضفه للـ pubspec → `flutter pub get`.

---

## 27. RTL — Text Inside Components Mirroring Fix

> **نص داخل components أحياناً بيتعكس. لو النص بيظهر معكوس داخل widget معقد → استخدم `textDirection`.**

```dart
// ✅ Fix reversed text inside complex components
Text(
  LocaleKeys.itemName.tr(),
  textDirection: TextDirection.rtl,
  style: const TextStyle().setMainTextColor.s14.regular,
)

// ✅ Alternative — wrap in Directionality
Directionality(
  textDirection: TextDirection.rtl,
  child: Text(LocaleKeys.description.tr()),
)
```

**متى تستخدم:** داخل dialog, bottom sheet, custom card, أو third-party widget لو النص ظهر معكوس.
**متى لا تستخدم:** النص طبيعي → لا تضيف textDirection.

---

## 28. Installed Packages — Do NOT Re-Add

dio, firebase_core, firebase_messaging, cached_network_image, flutter_bloc,
get_it, flutter_screenutil, skeletonizer, flutter_animate, lottie, flutter_svg,
carousel_slider, dropdown_search, pinput, easy_localization, image_picker,
flutter_html, video_player, rxdart, share_plus, url_launcher, injectable
