---
name: clean-code-and-refactoring
description: Keep Flutter_Base features clean, modular, and easy to change.
---

# Skill: Clean Code & Refactoring — Flutter_Base

## When to Use

- قبل توسيع feature قديم.
- عندما:
  - widgets كتير في ملف واحد (body file كبير بـ _build methods).
  - نفس الكارد / الـ section مكرر في أكثر من مكان.
  - Cubit يحمل أكثر من مسؤولية.

## What to Do

1. **Widget File Splitting (أولوية عالية):**
   - افحص كل body widget:
     - لو فيه `_buildXxx()` methods ترجع widgets أكثر من 10 أسطر → استخرجها لملفات منفصلة.
     - كل section / card / component → ملف خاص في `widgets/`.
     - الـ body widget = layout فقط (يجمع الـ sections).
   - أضف كل ملف جديد كـ `part` في `view_imports.dart`.

2. **Widget Deduplication (أولوية عالية جداً):**
   - **قبل إنشاء أي widget جديد** — ابحث عن مثيل موجود:
     - `app_shared/widgets/` — الـ widgets المشتركة.
     - الـ features الحالية — خصوصاً اللي اتبنت في نفس الـ session.
   - لو نفس التصميم 100% → استخدمه مباشرة.
   - لو فروقات بسيطة → أضف optional params للـ widget الموجود.
   - لو widget موجود في feature واحدة ومحتاجه في تانية → انقله لـ `app_shared/widgets/`.

3. **تحليل الحجم:**
   - لو `build()` > 50 سطر → استخرج Widgets فرعية لملفات منفصلة.
   - لو Cubit مع منطق متداخل جداً → فكّر تفصله أو تنظفه.

4. **تحسين الأسماء:**
   - غيّر:
     - `data`, `item`, `temp` → أسماء تعبر عن الدور (`orders`, `selectedCity`, ...).

5. **تنظيف التعليقات:**
   - احذف التعليقات التي تشرح "ماذا" يفعل الكود.
   - اترك فقط التعليقات التي تشرح "لماذا" أو قيود خاصة.

6. **Section Sub-Folders for Complex Screens:**
   - لما الشاشة فيها widgets كتير (4+ sections)، اعمل sub-folder لكل مجموعة مرتبطة.
   - كل folder يعبر عن الـ section (header/, categories/, products/).
   - الـ body يفضل في `widgets/` مباشرة.
   - ده بيخلي الكود أقرأ وأسهل في الصيانة.

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

## Output

عند استخدام هذا الـ skill، اعرض:
- قائمة بالـ widgets التي تم استخراجها لملفات منفصلة.
- قائمة بالـ widgets المكررة اللي تم توحيدها.
- أي إعادة تسمية مهمة (قبل/بعد) إن كانت مفيدة للمراجعة. 

