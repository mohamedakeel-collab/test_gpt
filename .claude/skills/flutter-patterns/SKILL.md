---
name: flutter-patterns
description: Widget patterns, file structure, key widgets reference, and screen/body patterns for Flutter_Base.
---

# Skill: Flutter_Base Widget Patterns

## Purpose
Quick reference for using Flutter_Base base widgets and patterns when building features.
For full coding standards, see `flutter-base-coding-standards.mdc`.
For full development workflow, see `flutter-feature-development.mdc`.

> **🧱 Companion skill: `widget-efficiency`** — اقرأها مع الـ skill ده لما تبني widgets جديدة.
> دي بتغطي **"use the widget's own attribute before wrapping"** — كل anti-pattern (Padding wrappers، SizedBox spacing، Stack للـ badge، ClipRRect حوالين Image، Opacity على colors، GestureDetector على Buttons، shrinkWrap في scrollables، M2 widgets، إلخ) + جدول M2→M3 migration كامل.
> **Rule of thumb:** قبل ما تـ wrap حاجة، اسأل: هل الـ child/parent عنده الـ attribute ده؟ هل فيه semantic widget مخصوص للحالة دي؟

---

## 🎯 Senior Widget Building — Best Practices

> **بناء الـ widgets لازم يعكس مستوى Senior Flutter Developer — مش "هيشتغل و خلاص".**

### القواعد الذهبية

1. **Composition > Monoliths** — كل widget = function واحدة واضحة. لو الـ build فيها 50+ سطر → اقسم.
2. **`const` كل ما أمكن** — كل widget/constructor ممكن يبقى `const` → خليه `const`. ده بيمنع rebuilds.
3. **Stateless > Stateful** — لو مش محتاج state، خلي الـ widget Stateless. الـ state يكون في ViewController أو cubit.
4. **`BlocBuilder` / `AsyncBlocBuilder` الافتراضي** — `BlocConsumer` / `BlocListener` للضرورة فقط. See `bloc-patterns`.
5. **Best widget for the job** — اختار الـ widget الصح:
   - عنصر واحد بيتغير في الـ state → `BlocSelector` / `ValueListenableBuilder`، مش `BlocBuilder` على الـ state كله
   - List items بنفس الـ height → `ListView.builder(itemExtent: ...)` بدل default
   - Subtree معقد بيـ animate → `RepaintBoundary`
   - حاجة بتعتمد على parent size → `LayoutBuilder`
   - Lazy load + scroll → `Sliver*` family، مش `SingleChildScrollView`
6. **Extract const subtrees** — أي subtree ثابت → widget منفصل + `const` constructor → مش بيـ rebuild أبداً.
7. **No magic numbers / hex / strings** — كله من `AppColors` / `AppSize` / `LocaleKeys` / `AppAssets`.
8. **Private widgets للـ internal** — لو الـ widget بيتستخدم في الفيتشر بس → `_MyWidget` (private).

### Dart 3.10 في الـ Widgets

```dart
// ✅ Pattern matching للـ state rendering
Widget build(BuildContext context) {
  return switch (state.status) {
    BaseStatus.loading => const _SkeletonView(),
    BaseStatus.error => ErrorView(error: state.errorMessage),
    BaseStatus.success when state.data.isEmpty => const EmptyWidget(...),
    BaseStatus.success => _ContentView(data: state.data),
    _ => const SizedBox.shrink(),
  };
}

// ✅ Records للـ tuples القصيرة
(double width, double height) _cardSize(BuildContext context) {
  final w = context.width * 0.45;
  return (w, w * 1.3);
}
final (cardW, cardH) = _cardSize(context);

// ✅ Sealed classes للـ navigation/dialog results
sealed class FilterResult {}
class FilterApplied extends FilterResult { final FilterEntity filter; FilterApplied(this.filter); }
class FilterCleared extends FilterResult {}
```

### Widget Selection Cheat Sheet

| المهمة | Senior Choice | Why |
|--------|---------------|-----|
| Listen to bloc state for UI | `BlocBuilder` / `AsyncBlocBuilder` | Pure rebuild, no side effects |
| One field of bloc state | `BlocSelector` | Only rebuilds when field changes |
| Side effect on state change | `BlocListener` (alone) | Don't mix UI + side effect |
| Both UI + side effect needed | Split: `BlocListener` + `BlocBuilder` | Clearer than `BlocConsumer` |
| Local UI state (toggle, counter) | `ValueNotifier` + `ValueListenableBuilder` in `ViewController` | No setState, no rebuild waste |
| Conditional widget tree | `if` / `?:` in `children: [...]` | Cleaner than `Visibility` for most cases |
| Hide but keep state | `Visibility(maintainState: true)` | Preserves controllers/scroll |
| Expensive paint | Wrap in `RepaintBoundary` | Isolates paint cost |
| Scroll with multiple sections | `CustomScrollView` + slivers | Single scroll, no jank |
| List with fixed item height | `ListView.builder(itemExtent: ...)` | Skips per-item measurement |
| Async one-shot future | `FutureBuilder` (rare) — usually go through cubit | Cubit gives loading/error/retry for free |

### Anti-patterns (Senior لازم يتجنبهم)

```dart
// ❌ Nested BlocBuilder for unrelated cubits
BlocBuilder<ACubit, ...>(
  builder: (_, a) => BlocBuilder<BCubit, ...>(
    builder: (_, b) => Text('${a.data} ${b.data}'),
  ),
)
// ✅ Use MultiBlocListener or compose at higher level

// ❌ setState في الـ View
class _MyState extends State<_MyWidget> {
  int _counter = 0;
  void _inc() => setState(() => _counter++);
}
// ✅ ViewController + ValueNotifier + ValueListenableBuilder

// ❌ Inline lambdas in const-able widgets
Column(children: [
  GestureDetector(onTap: () => doX(), child: ...),  // ← prevents const propagation
])
// ✅ Extract widget with named handler

// ❌ Building UI based on MediaQuery.size in every build
final w = MediaQuery.of(context).size.width;  // ← rebuilds on keyboard show
// ✅ Use LayoutBuilder for parent-dependent sizing
//    Or extract: context.width (project extension)
```

---

## File Structure — Separate Files Per Widget (MANDATORY)

```
lib/src/features/{feature_name}/
├── entity/
│   └── {feature}_entity.dart
├── presentation/
│   ├── imports/
│   │   └── view_imports.dart              ← all imports + part declarations
│   ├── cubits/
│   │   └── {feature}_cubit.dart           ← extends AsyncCubit<T>
│   ├── view/
│   │   └── {feature}_screen.dart          ← thin: scaffold + body
│   └── widgets/
│       ├── {feature}_body.dart            ← layout ONLY — assembles sections
│       ├── {feature}_header_widget.dart   ← separate file per section
│       ├── {feature}_filter_widget.dart
│       ├── {feature}_list_widget.dart
│       └── {feature}_card_widget.dart
```

**Body = layout only.** No `_buildXxx()` methods returning 10+ lines.

---

## view_imports.dart Part Ordering

```dart
// 1. Cubits
part '../cubits/feature_cubit.dart';
// 2. View (screen)
part '../view/feature_screen.dart';
// 3. Body
part '../widgets/feature_body.dart';
// 4. Section widgets (alphabetical)
part '../widgets/feature_filter_widget.dart';
part '../widgets/feature_header_widget.dart';
// 5. Card/item widgets last
part '../widgets/feature_card_widget.dart';
```

---

## Shared Widget Reuse — AUDIT BEFORE CREATING

Before creating ANY widget → search `app_shared/widgets/` and existing features.
Same design → reuse. Minor differences → add optional params. Used in 2+ features → move to `app_shared/`.

---

## Key Widget Quick Reference

| Need | Widget | Notes |
|---|---|---|
| Screen scaffold | `DefaultScaffold(title, body)` | Inner screens only. Auth → plain `Scaffold` |
| Async submit button | `LoadingButton(title, onTap)` | All form submits |
| Simple button | `DefaultButton(title, onTap)` | Non-async actions |
| Text field with label | `CustomTextFiled(title, hint, controller, validator)` | Primary form field (wraps DefaultTextField + label+asterisk) |
| Text field raw (no label) | `DefaultTextField(controller, hint)` | Base field — use directly for search bars or fields without labels |
| OTP/PIN | `CustomPinTextField(controller, onCompleted)` | 4-digit input |
| Dropdown | `AppDropdown<T>(items, label, onChanged, itemAsString, isLoading)` | NO BlocBuilder wrapper. Pass `items` + `isLoading` from `context.watch` directly. NO error UI. |
| API state wrapper | `AsyncBlocBuilder<C, T>(builder, skeletonBuilder)` | Loading/error/success auto |
| Sliver API wrapper | `AsyncSliverBlocBuilder<C, T>(builder)` | For CustomScrollView |
| Paginated list | `PaginatedListWidget<C, T>(itemBuilder)` | Infinite scroll |
| Network image | `CachedImage(url, width, height)` | Never use `Image.network` |
| Icon (SVG/PNG/etc.) | `IconWidget(icon: AppAssets.x.path, height: ...)` | **NO `color:`**, **NO `Icons.*`**, **NO Container wrapper with bg/border** — AppAssets icons already complete |
| Badge on icon | `BadgeIconWidget(child, badgeCount)` | Notification badge |
| Empty state | `EmptyWidget(title, desc, path)` | Full-screen empty only |
| Error state | `ErrorView(error, onRetry)` | With retry button |
| Success popup | `successDialog(context, title)` | Auto-closes 2s |
| Custom dialog | `showCustomDialog(context, child)` | Scale+fade animation |
| Bottom sheet | `showDefaultBottomSheet(child)` | Drag handle |
| Snackbar | `MessageUtils.showSnackBar(context, baseStatus, message)` | Themed |
| Full-screen loading | `CustomLoading.showFullScreenLoading()` | Overlay |
| Price with Riyal | `RiyalPriceText(price)` or `.withRiyalPrice()` | SAR symbol |
| HTML content | `CustomHtmlWidget(data)` | Styled HTML renderer |

---

## Screen Pattern

```dart
class MyFeatureScreen extends StatelessWidget {
  const MyFeatureScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<MyFeatureCubit>()..fetchData(),
      child: DefaultScaffold(
        title: LocaleKeys.myFeatureTitle.tr(),
        body: const _MyFeatureBody(),
      ),
    );
  }
}
```

---

## Body Pattern — RefreshIndicator + AsyncBlocBuilder

```dart
class _MyFeatureBody extends StatelessWidget {
  const _MyFeatureBody();
  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<MyFeatureCubit, List<MyFeatureEntity>>(
      builder: (context, data) {
        if (data.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => context.read<MyFeatureCubit>().fetchItems(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [SliverFillRemaining(hasScrollBody: false, child: EmptyWidget(...))],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () => context.read<MyFeatureCubit>().fetchItems(),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (_, i) => _MyFeatureCard(item: data[i]),
          ),
        );
      },
      skeletonBuilder: (_) => ListView.builder(
        itemCount: 8,
        itemBuilder: (_, __) => _MyFeatureCard(item: MyFeatureEntity.initial()),
      ),
    );
  }
}
```

---

## Multi-Section → CustomScrollView + Slivers

```dart
RefreshIndicator(
  onRefresh: () async { /* refresh all cubits */ },
  child: CustomScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    slivers: [
      const _FeatureHeader().toSliver(),
      AsyncSliverBlocBuilder<BannersCubit, List<BannerEntity>>(
        builder: (ctx, banners) {
          if (banners.isEmpty) return const SizedBox.shrink().toSliver();
          return BannerCarousel(banners: banners).toSliver();
        },
      ),
      // More sliver sections...
    ],
  ),
)
```

**Never:** `SingleChildScrollView` + nested `ListView(shrinkWrap: true)` for data.

---

## ViewController Class Pattern (MANDATORY)

> **⚠️ ممنوع نهائياً: أي Controller أو ValueNotifier داخل الـ View مباشرة.**
> **كل حاجة تتعلق بالـ UI state + handlers بتاعتها لازم تكون في ViewController class. الـ View تستدعي الـ class بس.**

### Why?
- الـ View تبقى نظيفة — layout فقط
- سهولة الاختبار والصيانة
- تجنب setState — استخدم `ValueNotifier` + `ValueListenableBuilder`

### ✅ CORRECT — ViewController class

```dart
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
```

### ✅ CORRECT — View uses ViewController object

```dart
class _ChatInputState extends State<_ChatInput> {
  late final ChatViewController _vc = ChatViewController();

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DefaultTextField(
            controller: _vc.messageController,
            title: LocaleKeys.typeMessage.tr(),
          ),
        ),
        8.szW,
        ValueListenableBuilder<bool>(
          valueListenable: _vc.isSending,
          builder: (_, sending, __) => _SendButton(
            onTap: () => _vc.onSend(context),
            isLoading: sending,
          ),
        ),
      ],
    );
  }
}
```

### ❌ FORBIDDEN — Controllers/logic directly in View

```dart
// ❌ WRONG — controllers, dispose, business logic scattered in view
class _ChatInputState extends State<_ChatInput> {
  final _controller = TextEditingController();
  bool _isSending = false;

  void _onSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _isSending = true);
    context.read<ChatCubit>().sendMessage(text);
    _controller.clear();
    setState(() => _isSending = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### ViewController Rules:
- **ممنوع** وضع Controller أو ValueNotifier داخل الـ View/State — لازم في ViewController فقط
- **كل** `TextEditingController`, `ValueNotifier`, `AnimationController`, `ScrollController`, `FocusNode` → داخل الـ ViewController
- **كل** function متعلقة بالـ UI logic (onSend, onSearch, selectTab, onFilter) → داخل الـ ViewController
- الـ View تستخدم **object واحد** من الـ ViewController وتنادي منه بس — `_vc.xxx`
- استخدم `ValueNotifier` + `ValueListenableBuilder` بدل `setState`
- الـ ViewController يعمل `dispose()` لكل الـ controllers/notifiers
- الـ View تنادي `_vc.dispose()` في `dispose()` بتاعها

---

## LoadingButton — Golden Path (Form Submits)

> **كل form submit لازم يستخدم `LoadingButton` مش `DefaultButton`.**
> **الـ LoadingButton بيعمل handle لحالة الـ loading تلقائياً — بيمنع double-tap وبيوري spinner.**

```dart
// ✅ CORRECT — LoadingButton with BlocListener for success/error
BlocListener<SubmitCubit, AsyncState<bool>>(
  listener: (context, state) {
    if (state.isSuccess) {
      MessageUtils.showSnackBar(message: LocaleKeys.success.tr(), baseStatus: BaseStatus.success);
      Go.back();
    }
  },
  child: LoadingButton(
    title: LocaleKeys.submit.tr(),
    onTap: () {
      if (!params.validateAndScroll()) return;
      context.read<SubmitCubit>().submit(params.toJson());
    },
    cubit: context.read<SubmitCubit>(),  // ← LoadingButton يعرف يعرض loading من الـ cubit
  ),
)
```

**LoadingButton بيعمل إيه تلقائياً:**
- بيسمع على `cubit.state.isLoading` → يعرض spinner بدل النص
- بيمنع tap تاني وهو loading
- بيرجع للحالة الطبيعية لما الـ cubit يخلص (success أو error)

**متى تستخدم DefaultButton بدل LoadingButton:**
- أزرار navigation (مش API call)
- أزرار cancel / back
- أزرار filter / sort (مش async)

---

## Icons — Use AppAssets As-Is (NO color, NO wrapper) — CRITICAL

> **الـ AppAssets icons exported من Figma بالـ colors والـ borders والـ backgrounds الصحيحة.**
> **استخدمهم زي ما هم بدون أي إضافات.**

```dart
// ✅ CORRECT — use AppAssets path directly, no color, no wrapper
IconWidget(icon: AppAssets.svg.baseSvg.search.path, height: AppSize.sH20)
IconWidget(icon: AppAssets.svg.featureSvg.notification.path, height: AppSize.sH48)

// ❌ FORBIDDEN — adding color override
IconWidget(icon: AppAssets.svg.x.path, color: AppColors.primary)

// ❌ FORBIDDEN — using IconData
Icon(Icons.search)
IconWidget(icon: Icons.notifications)

// ❌ FORBIDDEN — wrapping in Container with bg/border (icon already has its own)
Container(
  decoration: BoxDecoration(
    color: AppColors.fill,
    borderRadius: BorderRadius.circular(AppCircular.r8),
    border: Border.all(color: AppColors.border),
  ),
  child: IconWidget(icon: AppAssets.svg.x.path),  // ← double bg/border
)
```

**Workflow بعد قراءة Figma:**
1. شفت icon في border/bg/circle? → الـ AppAssets icon موجود already بكل ده — استخدمه مباشرة
2. شفت icon ملون? → الـ AppAssets icon ملون صح — لا تضيف `color:`
3. مفيش icon مطابق في AppAssets? → اطلب من المستخدم يضيف الـ asset (مش Icons.* fallback)

**استثناء نادر:** لو الـ icon فعلاً Container إضافي محتاج (مثلاً badge counter رمزي) → استخدم `Center` داخل الـ Container. لكن ده edge case، مش الـ default.

---

## Section Sub-Folders — For Complex Screens

> **لما الشاشة فيها widgets كتير، كل مجموعة sections مرتبطة ببعض حطها في folder يعبر عنها.**

```
lib/src/features/home/presentation/
├── widgets/
│   ├── home_body.dart                ← layout only
│   ├── header/                       ← header-related widgets
│   │   ├── home_header_widget.dart
│   │   ├── home_search_bar.dart
│   │   └── home_notification_icon.dart
│   ├── categories/                   ← category section widgets
│   │   ├── categories_section.dart
│   │   └── category_card.dart
│   ├── products/                     ← product section widgets
│   │   ├── products_section.dart
│   │   └── product_card.dart
│   └── banners/                      ← banner section widgets
│       └── banner_carousel.dart
```

**متى تستخدم sub-folders:**
- الشاشة فيها **4+ sections** مختلفة
- كل section فيها **2+ widgets** مرتبطة

**متى تبقى flat (بدون folders):**
- الشاشة بسيطة (body + card + filter فقط)
- كل section = widget واحد فقط

---

## Cubit, Entity & Form Patterns

> **See `bloc-patterns` skill for full AsyncCubit/CRUD/BlocListener patterns.**
> **See `flutter-base-coding-standards.mdc` section 8.5 for entity safety rules.**
> **See `flutter-base-coding-standards.mdc` section 8.1 for FormMixin pattern.**

Quick reminders:
- AsyncCubit: `@injectable` + `executeAsync()` + local CRUD updates (never re-fetch)
- Entity: `factory initial()` + `fromJson` with `??` + `tryParse` (never `parse`)
- Form: `with FormMixin` + `params.validateAndScroll()` + `LoadingButton`
