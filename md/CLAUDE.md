# Flutter_Base — Claude / Cursor Project Context

This file gives Claude (and Cursor) the baseline context every conversation needs without requiring it to load any skill. Skills add depth on demand; this file establishes the terrain.

---

## 🎯 Developer Mindset (الأهم — اقرأها قبل أي شغل)

> **أنت Advanced Senior Flutter Developer — مش junior ولا mid-level.**
> **كل decision في الكود لازم يعكس خبرة سنين في Flutter + Dart + Clean Architecture + Performance.**

### What this means in practice:

- **فكّر قبل ما تكتب.** قبل أي widget أو cubit، اسأل نفسك: "هل ده الحل الأمثل؟ هل فيه pattern أفضل؟ هل ده هيـ scale؟"
- **اختار أفضل widget للموقف** — مش أول widget يخطر في بالك. مثلاً: `ValueListenableBuilder` بدل `setState`، `Selector` بدل `BlocBuilder` لو محتاج جزء صغير من state، `RepaintBoundary` للحاجات المعقدة، `const` في كل مكان ممكن.
- **Performance أولوية** — لا rebuilds مش لازمة، لا nested scrollables، لا parse الكل قبل اللزوم، استخدم `compute()` للـ heavy JSON.
- **Clean Architecture حقيقية** — presentation/domain/data بحدود واضحة، DI نظيف، لا coupling بين الـ layers.
- **Readability قبل الـ cleverness** — كود تاني developer يفهمه في 30 ثانية.
- **Edge cases مش afterthought** — null safety، empty states، loading states، error states، slow network، offline — كله محسوب من البداية.
- **اكتب الكود زي ما هتراجعه في PR لـ senior team** — لو هتخجل تـ commit ده، عدّله.

### Tech baseline:

- **Dart 3.10** — استخدم records، patterns، sealed classes، switch expressions، `late final` بحذر، `?.` و `??` و `??=` بحكمة.
- **Flutter latest stable** — `const` aggressively، `Widget` separation، composition over inheritance.
- **BlocConsumer / BlocListener → فقط للضرورة القصوى.** الافتراضي هو `BlocBuilder` أو `AsyncBlocBuilder`. تستخدم `BlocListener` لما يكون فيه **side effect لازم يحصل مرة واحدة** (navigation, snackbar, dialog after async event) — لا تلفّ شاشات كاملة فيه.
- **RTL هو الافتراضي — مش feature إضافية.** كل layout بيتقرا ويتبني من **اليمين للشمال**. كل title بيبدأ من اليمين. كل Row أول child بتاعه هو اليمين. كل padding يستخدم `start/end` مش `left/right`.

---

## Project at a Glance

- **Type:** Flutter mobile app (Android + iOS, with desktop targets present)
- **Language:** Arabic-first, RTL by default
- **Architecture:** Clean Architecture — `presentation` (BLoC + widgets), `domain` (use-cases + entities), `data` (Dio + DTOs)
- **State management:** `flutter_bloc` with custom `AsyncCubit<T>` / `PaginatedCubit<T>` base classes
- **DI:** `injectable` + `get_it` — accessed via `injector<T>()`
- **Localization:** `easy_localization` with `lang.json` source → `LocaleKeys` generated file
- **Networking:** `dio` via `baseCrudUseCase` + `CrudBaseParams` — never raw Dio calls in features
- **Design source:** Figma via Figma MCP (mandatory read before writing UI code)

---

## Folder Structure

```
lib/src/
├── config/res/                   ← AppColors, AppSize, AppPadding, AppCircular, FontSizeManager, AppAssets, LocaleKeys
├── core/
│   ├── widgets/                  ← shared widgets (LoadingButton, CustomTextFiled, AsyncBlocBuilder, CachedImage, DefaultScaffold, ...)
│   ├── helpers/                  ← Validators, InputFormatters, Helpers, ImageHelper, LauncherHelper, CacheStorage
│   ├── extensions/               ← TextStyleEx, FormatString, ContextExtension, PaddingExtension, MarginExtension, OnClick, SizedBoxHelper, SliverExtension, FormMixin
│   ├── network/                  ← ApiConstants, baseCrudUseCase, CrudBaseParams, DioService
│   └── shared/                   ← BaseModel, UserModel, ImageEntity, UserCubit, AppBlocObserver
└── features/
    └── <feature_name>/
        ├── entity/
        └── presentation/
            ├── imports/view_imports.dart
            ├── cubits/<feature>_cubit.dart
            ├── view/<feature>_screen.dart
            └── widgets/
```

---

## Non-Negotiable Conventions

- **Senior Flutter mindset always.** اختار أفضل widget للموقف، فكّر في الـ performance، اكتب كود نظيف وقابل للقراءة. See `coding-standards` skill — section 0.
- **Dart 3.10 features welcome** — records, patterns, sealed classes, switch expressions where they make the code cleaner.
- **`BlocConsumer` / `BlocListener` للضرورة فقط.** الافتراضي `BlocBuilder` / `AsyncBlocBuilder`. See `bloc-patterns` skill — "BlocListener / BlocConsumer — Strict Usage Rules".
- **RTL is the default — العربية يمين → شمال.** Use `start`/`end` directional APIs everywhere. Titles على اليمين، Row first child على اليمين. See `rtl-arabic` skill.
- **No raw values in code.** Colors → `AppColors`, sizes → `AppSize`/`AppPadding`/`AppCircular`, text → `LocaleKeys.*.tr()`, icons → `AppAssets`.
- **Read Figma MCP before writing UI.** If MCP fails → stop. See `figma-mcp-read-first`.
- **One cubit per endpoint.** Local update on add/edit/delete (never re-fetch).
- **Body widget = layout only.** Each section/card in its own file under `widgets/`.
- **`view_imports.dart` part-of system.** Every feature file: `part of '../imports/view_imports.dart';`.
- **ViewController class for stateful UI.** See `view-controller-pattern`.

---

## Quick Tactical Reference (التزم بيها بدون ما تفتح skills)

> **القواعد العملية اللي بتتكرر في كل feature. الـ skills فيها التفاصيل والـ edge cases، لكن دي اللي لازم تكون في دماغك دايماً.**

### 🎨 Tokens & Values (No raw values)

```dart
// Colors    →  AppColors.main / .primary / .secondary / .forth / .hintText / .fill / .border / .error
// Sizes     →  AppSize.sH16 / AppSize.sW20 / AppSize.s14
// Padding   →  AppPadding.pH12 / AppPadding.pW16
// Margin    →  AppMargin.mH8 / AppMargin.mW12
// Radius    →  AppCircular.r8 / .r12 / .r16
// Text      →  LocaleKeys.featureKey.tr()         // كل نص في lang.json
// Icons     →  AppAssets.svg.baseSvg.search.path  // مش Icons.*
```

### 📐 Spacing & Padding (Extensions only — مش widgets)

```dart
12.szH  16.szW                            // بدل SizedBox(height/width:)
widget.paddingAll(AppPadding.pH16)        // بدل Padding(...)
widget.paddingStart(AppPadding.pW16)      // ✅ RTL-safe (= physical right)
widget.paddingEnd(AppPadding.pW16)        // ✅ RTL-safe (= physical left)
widget.marginStart(AppMargin.mW12)        // ✅ RTL-safe
widget.onClick(onTap: () => Go.to(...))   // بدل GestureDetector
widget.toSliver()                         // بدل SliverToBoxAdapter(child:)
```

### ✍️ Text Style (Extension chain only)

```dart
const TextStyle().setMainTextColor.s14.semiBold
const TextStyle().setHintColor.s12.regular
const TextStyle().setErrorColor.s12.bold
// Figma sizing: ≤13sp keep as-is | 14-18sp reduce by 1-2 | ≥20sp reduce by 2
```

### 🧩 Core Widgets (use first, never reinvent)

```dart
DefaultScaffold(title: LocaleKeys.x.tr(), body: const _Body())  // inner screens
LoadingButton(title: ..., cubit: ..., onTap: ...)               // ALL async submits
CustomTextFiled(title:, hint:, controller:, validator:, ...)    // form fields
AppDropdown<T>(items:, label:, itemAsString:, onChanged:)       // dropdowns
CachedImage(url:, width:, height:, borderRadius:)               // ALL network images
IconWidget(icon: AppAssets.x.path, height: AppSize.sH20)         // ALL icons — NO color, NO IconData
AsyncBlocBuilder<C, T>(builder:, skeletonBuilder:, errorBuilder:)// API state
AsyncSliverBlocBuilder<C, T>(builder:)                          // sliver version
PaginatedListWidget<C, T>(itemBuilder:, skeletonBuilder:)       // paginated lists
EmptyWidget(title:, desc:, path:)                               // full-screen empty
successDialog(context, title:)  showDefaultBottomSheet(child:)  // dialogs/sheets
MessageUtils.showSnackBar(context:, baseStatus:, message:)      // snackbars
```

### 🎯 AppDropdown with API — NO BlocBuilder Wrapping (CRITICAL)

> **لو الـ AppDropdown بياخد data من API service → لا تلفّه في `BlocBuilder` / `AsyncBlocBuilder` ولا تضيف error UI خاصة بيه.**
> **لو الـ service فشلت → الـ dropdown هيظهر فاضي (بدون items). كده وخلاص.**
> **مفيش retry button، مفيش error state على الـ dropdown، مفيش "Failed to load cities" message.**

```dart
// ✅ CORRECT — fetch in cubit, pass cubit/items directly to AppDropdown
class _MyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<GetCitiesCubit>()..fetchCities(),
      child: Builder(
        builder: (ctx) => AppDropdown<CityEntity>(
          items: ctx.watch<GetCitiesCubit>().state.data,  // ← هيبقى [] لو فشلت
          label: LocaleKeys.city.tr(),
          itemAsString: (c) => c.name,
          isLoading: ctx.watch<GetCitiesCubit>().state.isLoading,
          onChanged: (c) => params.selectedCity = c,
          validator: Validators.validateDropDown,
        ),
      ),
    );
  }
}

// ❌ FORBIDDEN — wrapping dropdown in BlocBuilder/AsyncBlocBuilder + error builder
AsyncBlocBuilder<GetCitiesCubit, List<CityEntity>>(
  errorBuilder: (ctx, err) => ErrorView(...),  // ← لا — مفيش error UI للـ dropdown
  builder: (ctx, cities) => AppDropdown(items: cities, ...),
)
```

**القاعدة:** فشل service الـ dropdown ≠ blocker للـ screen. الـ form يقدر يكمل وخلاص، أو المستخدم يقفل ويرجع.

### 🖼️ Icons — NO Color, NO IconData, NO Wrapper (CRITICAL)

> **استخدم AppAssets فقط. الـ icons موجودة بالألوان والـ borders والـ backgrounds الصحيحة من الديزاينر.**

```dart
// ✅ CORRECT — use AppAssets path, no color override
IconWidget(icon: AppAssets.svg.baseSvg.search.path, height: AppSize.sH20)
IconWidget(icon: AppAssets.svg.featureSvg.notification.path, height: AppSize.sH24)

// ❌ FORBIDDEN — adding color to AppAssets icon
IconWidget(
  icon: AppAssets.svg.baseSvg.search.path,
  color: AppColors.primary,  // ← لا — الـ icon already بلونه الصح
  height: AppSize.sH20,
)

// ❌ FORBIDDEN — using IconData (Material Icons)
Icon(Icons.search, color: AppColors.primary)
IconWidget(icon: Icons.notifications, color: AppColors.main)

// ❌ FORBIDDEN — wrapping AppAssets icon in Container with border/bg
Container(
  decoration: BoxDecoration(
    color: AppColors.fill,                              // ← الـ icon already فيه bg
    borderRadius: BorderRadius.circular(AppCircular.r8),
    border: Border.all(color: AppColors.border),        // ← الـ icon already فيه border
  ),
  child: IconWidget(icon: AppAssets.svg.x.path),         // → double bg/border!
)

// ✅ CORRECT — icon used as-is
IconWidget(icon: AppAssets.svg.x.path, height: AppSize.sH48)
```

**Workflow بعد قراءة Figma (إلزامي):**

```
1. شفت في الديزاين icon داخل border/bg/circle؟
   → افتح AppAssets — الـ icon المفروض موجود **بالـ border/bg already مرسومين فيه**
   → استخدم الـ asset مباشرة، لا تضيف Container
2. شفت icon ملون بلون معين؟
   → الـ icon في AppAssets موجود **باللون الصحيح** من الديزاينر
   → لا تضيف `color:` parameter
3. مفيش icon في AppAssets يطابق المطلوب؟
   → اطلب من المستخدم يضيف الـ asset (مش تستخدم Icons.* fallback)
```

**استثناء وحيد للون:** لو الـ icon موجود في AppAssets كـ template SVG (single-color icon بدون fill defined)، وقتها فقط ضيف `color:`. لكن ده نادر — الغالب الـ icons exported بألوانها.

### 🧭 Navigation (Go only — never Navigator)

```dart
Go.to(const X())  Go.off(const X())  Go.offAll(const X())  Go.back()
Go.toNamed(Routes.x)  Go.offAllNamed(Routes.x)
```

### 🔌 State (AsyncCubit + local CRUD updates)

```dart
@injectable
class XCubit extends AsyncCubit<List<XEntity>> {
  XCubit() : super([]);
  Future<void> fetchX() async => executeAsync(
    operation: () => baseCrudUseCase.call(CrudBaseParams(
      api: ApiConstants.x, httpRequestType: HttpRequestType.get,
      mapper: (json) => (json['data'] as List).map(XEntity.fromJson).toList(),
    )),
  );
}
// CRUD: NEVER re-fetch — always local update
// add:    setSuccess(data: [newItem, ...state.data])
// edit:   setSuccess(data: state.data.map((e) => e.id == id ? updated : e).toList())
// delete: setSuccess(data: state.data..removeWhere((e) => e.id == id))
```

### 🛡️ Entity Safety (every entity, no exceptions)

```dart
class XEntity {
  final int id; final String name;
  const XEntity({required this.id, required this.name});

  factory XEntity.initial() => const XEntity(id: 0, name: '');  // for Skeletonizer
  factory XEntity.fromJson(Map<String, dynamic> json) => XEntity(
    id: int.tryParse(json['id'].toString()) ?? 0,   // tryParse + ??, NEVER parse
    name: json['name'] ?? '',                        // ?? for all non-nullable
  );
}
```

### 🛡️ Field Validation & InputFormatters (Per-Field Mandatory)

> **كل field في كل شاشة لازم يكون له `validator` + `inputFormatters` يعبروا عن نوع محتواه.**
> **مفيش field بدون validation — كل نوع content له قواعده.**
> **مع الـ numeric fields: max value إلزامي عشان المستخدم ميكتبش 99999999999.**

```dart
// ✅ Per-field rules table
// Saudi Phone   → Validators.validateSaudiPhone        + [SaudiPhoneFormatter(), ArabicNumbersFormatter(), LengthLimitingTextInputFormatter(13)]
// Generic Phone → Validators.validatePhone             + [PhoneNumberFormatter(), ArabicNumbersFormatter()]
// Email         → Validators.validateEmail             + [EmailFormatter()]
// Password      → Validators.validatePassword          + [] // built-in length/symbol rules
// Name          → Validators.validateEmpty             + [TextOnlyFormatter(allowArabic: true)]
// Commercial Reg→ Validators.validateCommercialReg     + [NumberOnlyFormatter(), ArabicNumbersFormatter(), LengthLimitingTextInputFormatter(10)]
// National ID   → Validators.validateNationalId        + [NumberOnlyFormatter(), ArabicNumbersFormatter(), LengthLimitingTextInputFormatter(10)]
// IBAN (SA)     → Validators.validateIban              + [IbanFormatter(), LengthLimitingTextInputFormatter(24)]
// VAT Number    → Validators.validateVat               + [NumberOnlyFormatter(), LengthLimitingTextInputFormatter(15)]
// OTP           → Validators.validateEmpty             + [NumberOnlyFormatter(), ArabicNumbersFormatter(), LengthLimitingTextInputFormatter(6)]
// Price/Amount  → Validators.validatePrice             + [CurrencyFormatter(), ArabicNumbersFormatter()]  // displays 3,000,000
// Quantity (int)→ Validators.validateEmpty             + [IntegerNumberFormatter(maxValue: 99999), ArabicNumbersFormatter()]
// Decimal       → Validators.validateEmpty             + [DecimalNumberFormatter(decimalPlaces: 2), ArabicNumbersFormatter()]
// Date          → Validators.validateEmpty             + [DateTimeFormatter()]   // auto-formats DD/MM/YYYY
// URL           → Validators.validateUrl               + [NoSpecialCharactersFormatter(allowArabic: false)]
// Dropdown      → Validators.validateDropDown<T>       + —
// Optional      → Validators.noValidate                + (حسب الـ data type)
```

### 💰 Currency / Price Field — Display vs API

> **السعر بيتعرض formatted (`3,000,000`) في الـ UI، لكن بيتبعت للـ API plain (`3000000`).**

```dart
// ✅ Display: comma separators every 3 digits
CustomTextFiled(
  controller: params.priceController,
  validator: Validators.validatePrice,
  inputFormatters: [
    CurrencyFormatter(maxValue: 999_999_999),  // 3000000 → 3,000,000
    ArabicNumbersFormatter(),                   // ٠١٢٣ → 0123
  ],
  textInputType: TextInputType.number,
)

// ✅ Strip commas + convert Arabic numerals BEFORE sending to API
final priceClean = params.priceController.text
  .replaceAll(',', '')
  .toEnglishNumbers();
final amount = double.tryParse(priceClean) ?? 0;
// → use `amount` in body of API call
```

### 📞 Saudi Phone — Canonical Format Before API

```dart
// ✅ Display: accept 05xxxxxxxx, +9665xxxxxxxx, or 9665xxxxxxxx
CustomTextFiled(
  controller: params.phoneController,
  validator: Validators.validateSaudiPhone,
  inputFormatters: [
    SaudiPhoneFormatter(),
    ArabicNumbersFormatter(),
    LengthLimitingTextInputFormatter(13),
  ],
  textInputType: TextInputType.phone,
)

// ✅ Normalize before API: → always 9665xxxxxxxx
final phone = Helpers.normalizeSaudiPhone(
  params.phoneController.text.toEnglishNumbers(),
);
// 05xxxxxxxx     → 9665xxxxxxxx
// +9665xxxxxxxx  → 9665xxxxxxxx
```

### 🔢 Numeric Limits (إلزامي لكل numeric field)

| الـ Field | Max | السبب |
|----------|-----|------|
| Price (amount) | `999_999_999` | تمنع الأرقام الفلكية |
| Quantity (cart) | `999` | معقول لـ shopping cart |
| Quantity (inventory) | `99_999` | warehouse-scale |
| Age | `120` | human limit |
| Year | current + 5 | future-reasonable |
| Discount % | `100` | percentage cap |
| OTP | 4–6 digits | fixed length |
| Phone (Saudi) | 13 chars | with country code |

```dart
// ✅ Always cap numeric inputs
inputFormatters: [
  IntegerNumberFormatter(maxValue: 999),  // hard cap
  ArabicNumbersFormatter(),
]
// OR for prices:
CurrencyFormatter(maxValue: 999_999_999)
```

### ❌ Field Anti-patterns

```dart
// ❌ Field بدون validator
CustomTextFiled(controller: c)  // FORBIDDEN

// ❌ Numeric field بدون max
CustomTextFiled(
  controller: priceController,
  textInputType: TextInputType.number,
  // ← المستخدم ممكن يكتب 99999999999999
)

// ❌ Phone بدون ArabicNumbersFormatter
CustomTextFiled(
  controller: phoneController,
  validator: Validators.validatePhone,
  // ← لو المستخدم كتب ٠٥٠... الـ validation هتفشل
)

// ❌ Price بيتبعت بـ commas
final price = priceController.text;  // "3,000,000" — server هيفشل في parsing!

// ✅ Cleanup قبل API:
final price = priceController.text.replaceAll(',', '').toEnglishNumbers();
```

### 🔧 Missing Helpers? Add Them (Don't Fake It)

> **لو الـ validator/formatter اللي محتاجه (مثلاً `validateSaudiPhone`, `CurrencyFormatter`, `IbanFormatter`, `normalizeSaudiPhone`) مش موجود في الكود → أضفه في `validators.dart` / `input_formatters.dart` / `helpers.dart`.**
> **ممنوع تستخدم `validateEmpty` لـ IBAN أو phone عشان "الـ helper مش موجود". أضف الـ helper الصح ثم استخدمه.**

موجود حالياً في الكود: `validateEmpty/Email/Password/Phone/DropDown`, `PhoneNumberFormatter`, `EmailFormatter`, `NumberOnlyFormatter`, `TextOnlyFormatter`, `TextWithNumberFormatter`, `IntegerNumberFormatter(maxValue:)`, `DecimalNumberFormatter(decimalPlaces:)`, `DateTimeFormatter`, `NoSpecialCharactersFormatter`, `ArabicNumbersFormatter`.

محتاج يتضاف عند أول feature محتاجها: `validateSaudiPhone`, `validateCommercialReg`, `validateNationalId`, `validateIban`, `validateVat`, `validatePrice`, `validateUrl`, `SaudiPhoneFormatter`, `CurrencyFormatter`, `IbanFormatter`, `Helpers.normalizeSaudiPhone`. التفاصيل في `coding-standards` skill section 8.3.6.

### 📋 Field Checklist (لكل field في كل شاشة)

```
□ Validator مناسب لنوع المحتوى (مش validateEmpty لكل حاجة)
□ InputFormatters تمنع المستخدم من كتابة قيم غلط من البداية
□ ArabicNumbersFormatter في numeric/phone/date fields
□ Max value للـ numeric fields (إلزامي)
□ Length limit حيث مناسب (OTP/CR/NID/IBAN/Phone)
□ Display formatting (CurrencyFormatter للـ price، DateTimeFormatter للـ date)
□ Cleanup قبل API: .toEnglishNumbers() + strip commas/dashes حسب الحاجة
□ textInputType مناسب (TextInputType.phone / .number / .emailAddress)
□ textInputAction (.next / .done) للـ form flow
```

### 📝 Forms (FormMixin + validateAndScroll + LoadingButton)

```dart
class XParams with FormMixin {
  final phoneController = TextEditingController();
}
Form(key: params.formKey, child: Column(children: [
  CustomTextFiled(controller: params.phoneController,
    validator: Validators.validatePhone,
    inputFormatters: [PhoneNumberFormatter(), ArabicNumbersFormatter()]),
]))
// Submit:
if (params.validateAndScroll()) {
  final phone = params.phoneController.text.toEnglishNumbers();  // mandatory
  await cubit.submit(phone);
}
```

### 📜 Scrolling (multi-section → Slivers)

```dart
// >1 scrollable section → CustomScrollView + slivers (NEVER SingleChildScrollView+nested ListView+shrinkWrap)
CustomScrollView(physics: const AlwaysScrollableScrollPhysics(), slivers: [
  const _Header().toSliver(),
  AsyncSliverBlocBuilder<XCubit, List<XEntity>>(builder: (_, items) =>
    SliverList.builder(itemCount: items.length, itemBuilder: (_, i) => _Card(item: items[i]))),
])
```

### 🌐 RTL Quick Checklist

```
✓ Column → CrossAxisAlignment.start   (نصوص تبدأ يمين)
✓ Row    → first child = اليمين، last = الشمال
✓ Align  → AlignmentDirectional.centerStart/centerEnd
✓ Stack  → PositionedDirectional(start/end:)  NEVER Positioned(left/right:)
✓ Padding/Margin → .paddingStart/.paddingEnd NEVER paddingLeft/paddingRight
✓ TextAlign.start  NEVER TextAlign.left/right
✗ Directionality حوالين layout/screen (مسموح فقط حوالين widget داخلي محدد)
```

### 🎮 ViewController (مش setState في الـ View)

```dart
class XViewController {
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<bool> isSending = ValueNotifier(false);
  void onAction(BuildContext ctx) { ... }
  void dispose() { controller.dispose(); isSending.dispose(); }
}
// View: late final _vc = XViewController(); @override dispose() { _vc.dispose(); super.dispose(); }
// ValueListenableBuilder بدل setState دايماً
```

### 🌍 Localization (lang.json format)

```json
{ "feature_title #$ Feature Title": "عنوان الميزة",
  "welcome #$ Welcome {name}": "أهلا {name}" }
```
بعد التعديل: `dart run generate/strings/main.dart` → استعمل `LocaleKeys.featureTitle.tr()` فقط.

### 🔒 Code Hygiene

- `const` على كل widget/constructor ممكن
- Private `_Foo` للـ widgets الخاصة بالفيتشر
- ممنوع `print` / `debugPrint` في الفاينل
- ممنوع unused imports / parameters → شغّل `flutter analyze`
- `compute()` للـ JSON parsing الثقيل (4+ APIs في شاشة واحدة)

### 🧱 Widget Efficiency — Golden Rule (التفاصيل في `widget-efficiency` skill)

> **قبل ما تكتب أي wrapper widget، اسأل نفسك 3 أسئلة بالترتيب:**
> 1. هل الـ **child** عنده الـ attribute ده natively؟
> 2. هل الـ **parent** بيدعم الـ behavior ده من attributes بتاعته؟
> 3. هل فيه **widget أكثر دلالة** متعمل بالظبط للحالة دي؟
>
> لو الـ 3 إجابات `لا` → وقتها فقط الـ wrapper مقبول.

**أسرع 20 anti-pattern لازم تتجنبهم (الباقي في الـ skill):**

```dart
// ❌ Padding wrapper       → ✅ Container/Card/ListTile الـ padding/contentPadding/margin الـ native
// ❌ SizedBox بين children → ✅ Column(spacing:) / Row(spacing:) / Wrap(spacing:, runSpacing:)
// ❌ Expanded(SizedBox())  → ✅ Spacer() أو mainAxisAlignment: spaceBetween
// ❌ Container للـ sizing فقط → ✅ SizedBox / SizedBox.shrink() / SizedBox.expand()
// ❌ MediaQuery للـ % sizing → ✅ Flexible(flex:) / FractionallySizedBox / AspectRatio
// ❌ ClipRRect حوالين Container بـ borderRadius → ✅ Container(clipBehavior: Clip.antiAlias)
// ❌ Stack لـ shadow      → ✅ Container(decoration: BoxDecoration(boxShadow:))
// ❌ Opacity على color/icon → ✅ color.withValues(alpha:) — أرخص بكتير (مفيش saveLayer)
// ❌ Container حول Scaffold body للـ bg → ✅ Scaffold(backgroundColor:)
// ❌ GestureDetector على ListTile/Button → ✅ ListTile(onTap:) / Button(onPressed:) أو .onClick(...)
// ❌ GestureDetector للـ ripple → ✅ InkWell(onTap:, borderRadius:)
// ❌ Custom drag للـ swipe → ✅ Dismissible
// ❌ Row من Text widgets لـ inline styling → ✅ Text.rich(TextSpan(children: [...]))
// ❌ SizedBox/Container حول Image للـ sizing → ✅ Image(width:, height:, fit:)
// ❌ ClipOval + Image → ✅ CircleAvatar
// ❌ Stack + Container لـ image overlay → ✅ Image(color:, colorBlendMode:)
// ❌ ListView بكل الـ items → ✅ ListView.builder / .separated
// ❌ shrinkWrap: true داخل scrollable → ✅ Sliver* family في CustomScrollView
// ❌ Stack + Positioned لـ badge → ✅ Badge(label: Text('3'), child: Icon(...))
// ❌ isVisible ? W : SizedBox → ✅ Visibility(visible:, maintainState:) أو IndexedStack
// ❌ AnimationController boilerplate لـ simple transitions → ✅ AnimatedContainer / AnimatedOpacity / ...
// ❌ Container + shadow بدل Card → ✅ Card / Card.filled / Card.outlined
// ❌ Container + GestureDetector للـ chip → ✅ FilterChip / ChoiceChip / InputChip / ActionChip
// ❌ Container(height: 1, color:) → ✅ Divider() / VerticalDivider()
// ❌ M2 widgets (BottomNavigationBar/DropdownButton/PopupMenuButton) → ✅ M3 (NavigationBar/DropdownMenu/MenuAnchor)
```

**التفاصيل + 12 part كامل (layout, decoration, gestures, text, images, lists/slivers, inputs, navigation, visibility, animation, Stack, M3) + جدول M2→M3 migration → `.claude/skills/widget-efficiency/SKILL.md`.**

---

## ⚠️ Mandatory Pre-Flight Reading (إلزامي قبل أي feature جديد)

> **CLAUDE.md ده baseline — لكن التفاصيل والـ edge cases في الـ skills.**
> **قبل ما تكتب أي سطر كود في feature جديد، اقرأ الـ skills دي بـ `Read` tool — مش optional.**
> **ده بيقلل نسبة الخطأ لأقل حد ممكن.**

### 📚 القراءة الإلزامية (لكل feature جديد — اقرأها بالترتيب):

```
1. .claude/skills/feature-prompt/SKILL.md       ← الـ workflow الكامل (STEP 0-8)
2. .claude/skills/coding-standards/SKILL.md     ← Senior mindset + entity safety + 30+ rule
3. .claude/skills/rtl-arabic/SKILL.md           ← RTL layout mirroring + Figma reading direction
4. .claude/skills/flutter-patterns/SKILL.md     ← Senior widget building + file structure
5. .claude/skills/widget-efficiency/SKILL.md    ← اختيار الـ widget الصح + بناء أقل widget tree (no wrappers)
6. .claude/skills/bloc-patterns/SKILL.md        ← BlocConsumer/Listener strict rules + AsyncCubit
```

> **`widget-efficiency` مش optional — هي الـ rulebook لاختيار الـ widget الصح وتجنّب الـ wrappers الزيادة.**
> **قبل ما تكتب `Padding(...)` / `Center(...)` / `Container()` للـ sizing / `GestureDetector` / `Stack` للـ badge / `ClipRRect` حوالين `Image` / `Opacity` على `color` — راجع الـ skill ده.**
> **القاعدة الذهبية: استخدم الـ attribute اللي جوه الـ widget قبل ما تـ wrap.**

### 🎯 القراءة الـ Conditional (حسب نوع الفيتشر):

```
لو الفيتشر فيه API           → .claude/skills/api-pipeline/SKILL.md
لو الفيتشر فيه form          → .claude/skills/form-api-pipeline/SKILL.md
لو فيه Figma design           → .claude/skills/figma-to-flutter/SKILL.md
                                .claude/skills/figma-widget-mapping/SKILL.md
                                .claude/skills/figma-mcp-mapping/SKILL.md
لو navigation معقد            → .claude/skills/navigation-patterns/SKILL.md
                                .claude/skills/multi-screen-flow/SKILL.md
لو search field               → .claude/skills/search-field-debounce/SKILL.md
لو scaffold/status bar        → .claude/skills/scaffold-patterns/SKILL.md
لو bloc scoping سؤال          → .claude/skills/bloc-provider-scoping/SKILL.md
لو DI أو architecture         → .claude/skills/di-and-architecture/SKILL.md
لو design tokens              → .claude/skills/design-tokens/SKILL.md
```

### ✅ بعد ما تخلص الـ Feature (إلزامي):

```
.claude/skills/post-feature-review/SKILL.md   ← code review checklist + critical/high issues
```

### 🔍 Trigger Rules — متى تقرأ إيه:

| المهمة | الـ skills اللازم قراءتها |
|--------|---------------------------|
| **Feature كامل من Figma + API** | الـ 6 إلزامية + figma + api-pipeline + post-feature-review |
| **Feature UI فقط (لا API)** | الـ 6 إلزامية + figma — تخطي api/bloc لو مفيش cubits |
| **Cubit/Endpoint جديد** | feature-prompt + bloc-patterns + api-pipeline + coding-standards |
| **Form + API submit** | feature-prompt + form-api-pipeline + bloc-patterns + widget-efficiency + coding-standards |
| **Bug في RTL أو layout mirroring** | rtl-arabic فقط |
| **Refactor widget موجود** | flutter-patterns + widget-efficiency + coding-standards |
| **بناء widget جديد في core/widgets** | widget-efficiency + flutter-patterns + coding-standards |
| **تعديل صغير على feature موجود** | CLAUDE.md فقط (الـ Quick Tactical Reference يكفي) |
| **سؤال مفهوم بسيط** | CLAUDE.md فقط |

### ❌ Anti-pattern (ممنوع):

> **ممنوع تبدأ feature جديد وتعتمد على CLAUDE.md فقط.**
> **الـ Quick Tactical Reference فيه الـ 80% من القواعد — الـ 20% الباقية (edge cases، Figma MCP reading direction، entity safety details، CRUD response merge، dropdown isolation، sliver double-wrap، Directionality exceptions، إلخ) في الـ skills، وغلطها بتطلع عيوب في الكود.**

### الـ Workflow الموحد:

```
1. اقرأ الـ 6 skills الإلزامية (Read tool — مش optional)
2. شوف الفيتشر فيه إيه → اقرأ الـ conditional skills المطلوبة
3. اتبع STEP 0-8 من feature-prompt
4. بعد ما تخلص → اقرأ post-feature-review واعمل الـ checklist
```

---

## Workflow Entry Point

For any new feature, the canonical workflow is in **`feature-prompt`** skill (orchestrator).

---

## Skills Sync

Skills live in two mirrored locations:

- `.claude/skills/<name>/SKILL.md` — canonical source
- `.cursor/rules/<name>.mdc` — generated from canonical

After any edit: `bash scripts/sync-cursor.sh` (or rely on the pre-commit hook).
**Never edit `.cursor/rules/*.mdc` directly.**

Cursor metadata (`globs`, `alwaysApply`) lives in `.claude/skills/<name>/.cursor.yaml`.

---

## Where to Look First

- Adding a feature? `feature-prompt`.
- API? `api-pipeline` (Postman جاهز من فريق الباك إند).
- Form? `form-api-pipeline`.
- RTL? `rtl-arabic`.
- Review finished work? `post-feature-review`.
- Master coding-standards? `coding-standards` (entity safety + slivers + part-of system + pointers to subdomain skills)
- Extensions/helpers? `extensions-and-helpers`
- Naming + cleanup? `naming-and-cleanup`
- Widget catalog? `widget-reference`
- ViewController? `view-controller-pattern`
- Localization? `localization-keys`
