---
name: error-handling-and-resilience
description: Unified error handling, resilience, and UX rules for API-driven features.
---

## Error Handling & Resilience

### 1. Sources of Errors

- Network: no internet, timeout, DNS، SSL.
- Backend: 4xx, 5xx, validation errors.
- Parsing: unexpected response shape.
- Logic: illegal states, invalid params.

كل نوع لازم يكون له:
- رسالة للمستخدم (إن كانت مهمة).
- سلوك منطقي (retry, fallback, stay on screen).

---

### 2. Where to Handle Errors

- **الطبقة الأساسية** (baseCrudUseCase / AsyncCubit) تتعامل مع:
  - mapping لـ `Failure` (network, server, unknown).
  - `setError(errorMessage: ..., showToast: true/false)`.
- **Cubit** يحدد:
  - هل نعرض toast؟
  - هل نغير state لـ error ونبني UI مناسب؟
- **View**:
  - تعرض error UI (`ErrorView`, `EmptyWidget`, snack bar).
  - توفر زر "إعادة المحاولة".

قاعدة:
- **لا تعمل try/catch في الـ UI** إلا في حالات نادرة جداً (local-only logic).

---

### 3. AsyncBlocBuilder / ErrorView Usage

```dart
AsyncBlocBuilder<GetItemsCubit, List<ItemEntity>>(
  builder: (context, items) {
    if (items.isEmpty) {
      return EmptyWidget(
        title: LocaleKeys.noItems.tr(),
        desc: '',
      );
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, i) => ItemCard(item: items[i]),
    );
  },
  skeletonBuilder: (context) => const ItemsSkeletonList(),
  errorBuilder: (context, error) => ErrorView(
    error: error,
    onRetry: () => context.read<GetItemsCubit>().fetchItems(),
  ),
)
```

قواعد:
- شاشات single-service:
  - تستخدم `EmptyWidget` و/أو `ErrorView` على مستوى الشاشة.
- شاشات multi-section:
  - section فاضي → `SizedBox.shrink()`.
  - section به error → يمكن إخفاؤه أو عرض error صغير داخل القسم، بدون تخريب باقي الشاشة.

---

### 4. Toasts vs In-Place Errors

- **Toast / SnackBar**:
  - عمليات actions (حذف، حفظ، تحديث).
  - نجاح/فشل عمليات غير مرتبطة بشاشة مستقلة.
- **In-place error (ErrorView / label تحت field)**:
  - عند فشل تحميل شاشة كاملة.
  - عند validation على مستوى field واحد.

استخدم:
```dart
MessageUtils.showSnackBar(
  context: context,
  baseStatus: BaseStatus.error,
  message: errorMessage,
);
```
بدلاً من `ScaffoldMessenger.of(context).showSnackBar(...)`.

---

### 5. Retry Patterns

- لكل شاشة API رئيسية:
  - وفر زر "إعادة المحاولة" في الـ error state.
  - زر يعيد نفس call الأساسي (`fetchItems()`، `fetchDetails()`، إلخ).

```dart
ErrorView(
  error: state.errorMessage ?? LocaleKeys.defaultError.tr(),
  onRetry: () => context.read<MyCubit>().fetchData(),
)
```

---

### 6. Defensive Coding في fromJson

- مغطى بالتفصيل في `flutter-feature-development.mdc`:
  - `??` default لكل field.
  - `tryParse` بدل `parse`.
  - **DateTime:** `DateTime.tryParse(json['date'] ?? '') ?? DateTime(2000)`
  - **Enum:** `Status.values.firstWhere((e) => e.name == json['status'], orElse: () => Status.initial)`
  - **Nested List:** `(json['items'] as List?)?.map((e) => e != null ? Entity.fromJson(e) : Entity.initial()).toList() ?? []`
- الهدف هنا: **عدم رمي أي استثناء من fromJson** مهما كان شكل البيانات.

---

### 7. Unknown / Unexpected States

- **ممنوع** ترك حالات enum بدون معالجة في `switch`.
- استخدم `default` أو `else` مع fallback منطقي:

```dart
switch (status) {
  case FilterStatus.active:
    // ...
  case FilterStatus.inactive:
    // ...
  default:
    // fallback آمن
    break;
}
```

---

### 8. Pre-Delivery Error Checklist

- [ ] لا يوجد `try/catch` عشوائي في الـ UI؛ كل API calls تمر عبر cubit/usecase.
- [ ] كل cubit له مسار خطأ واضح (setError + UI مناسب).
- [ ] لكل شاشة API رئيسية يوجد زر "إعادة المحاولة".
- [ ] تم استخدام `ErrorView` / `EmptyWidget` بدلاً من Widgets مخصصة للحالات الشائعة.
- [ ] لا يوجد `throw` في الـ View أو الـ Cubit إلا في حالات debug واضحة ومؤقتة.
- [ ] `fromJson` لا يمكن أن يرمي أي استثناء (كل الحقول محمية).
