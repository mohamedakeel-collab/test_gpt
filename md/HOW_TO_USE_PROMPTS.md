# كيف تستخدم المشروع مع Claude Code و Cursor (2026)

> آخر تحديث: أبريل 2026 (بعد refactor الـ skills + cursor sync)

---

## 🆕 إيه اللي اتغيّر في الـ Refactor

| قبل | بعد |
|-----|-----|
| `.cursor/rules/` و `.claude/skills/` كانوا منفصلين، فيه drift كتير | **single source of truth** — `.claude/skills/<name>/SKILL.md` هو الأصل، الـ `.cursor/rules/*.mdc` بتتولّد منه أوتوماتيك |
| 28 skill | **34 skill** (7 جداد: figma-mcp-read-first, no-mock-without-permission, view-controller-pattern, localization-keys, extensions-and-helpers, naming-and-cleanup, widget-reference) — `api-design` اتشال |
| `feature-prompt` كان 381 سطر فيه قواعد inline | **147 سطر orchestrator فقط** — كل phase بتشاور على الـ skill المناسب |
| `coding-standards` كان 1526 سطر بقى ضخم جداً | **893 سطر** — الأقسام التفصيلية اتقسمت لـ skills مستقلة |
| `alwaysApply` على Cursor كان ~2900 سطر/conv | **~262 سطر/conv فقط** — الباقي عبر globs |
| Legacy slugs: `flutter-base-coding-standards`, `flutter-feature-development`, `scaffold-statusbar` | **اتشالوا** — الأسماء الموحدة دلوقتي: `coding-standards`, `feature-development`, `scaffold-patterns` |

**الـ Workflow الجديد لتعديل أي skill:**
1. عدّل في `.claude/skills/<name>/SKILL.md` (canonical source)
2. لو عايز تغيّر `globs` أو `alwaysApply` لـ Cursor → عدّل `.claude/skills/<name>/.cursor.yaml`
3. اعمل commit — الـ pre-commit hook هيشغّل `scripts/sync-cursor.sh` تلقائي ويحدّث `.cursor/rules/`
4. **ممنوع** تعدّل في `.cursor/rules/*.mdc` مباشرة — أي تعديل هيتم overwrite

---

## Claude Code

### المفاهيم الأساسية

Claude Code منصة Agent كاملة. فيه 5 أنظمة أساسية:

| النظام | الوصف | الملف/المكان |
|--------|-------|--------------|
| **CLAUDE.md** | تعليمات ثابتة بيقرأها Claude تلقائياً في كل محادثة | `CLAUDE.md` في root المشروع |
| **Skills** | ملفات Markdown بتعلم Claude workflows معينة — بتتشغل كـ slash commands | `.claude/skills/*/SKILL.md` |
| **Hooks** | أوامر بتتنفذ تلقائياً في أوقات معينة | `.claude/settings.json` |
| **Subagents** | agents فرعية بتشتغل بشكل مستقل بأدوات وصلاحيات محددة | `.claude/agents/*.md` |
| **MCP Servers** | ربط Claude بأدوات خارجية (Figma, Postman, etc.) | `.claude/settings.json` |

### CLAUDE.md — الملف الأساسي

أهم ملف. Claude Code بيقرأه **تلقائياً** أول كل محادثة. دلوقتي بقى **رفيع ومركز** بيدّي السياق الأساسي بس:

- ملخص المشروع (Flutter, Clean Arch, BLoC, Arabic-first/RTL)
- هيكل الـ folders
- 8 قواعد non-negotiable (RTL, no raw values, Figma MCP read-first, no mock without permission, etc.)
- "Where to look first" — index لأهم الـ skills

التفاصيل التنفيذية مش في `CLAUDE.md` — في الـ skills نفسها.

### بدء فيشتر جديد

اكتب في الشات:

```
/feature-prompt

Feature: [اسم الفيشتر]
Figma Node: [لينك الفيجما]
Mode: [UI_ONLY / UI_AND_API]
Postman: [POSTMAN_URL لو UI_AND_API، اتركه فاضي لو UI_ONLY]
```

#### الـ Decision Tree (Claude هيسألك لو الـ inputs مش واضحة):

> **السؤال الوحيد:** UI بس ولا UI + API؟
> - **UI Only** → static data في الـ widgets، بدون cubits، بدون API
> - **UI + API** → ادّيني link الـ Postman Collection (جاهز من فريق الباك إند)

#### الأوضاع الـ 2:

| الوضع | Cubits | Postman | MockConfig |
|-------|--------|---------|------------|
| **UI Only** | ❌ | ❌ | ❌ |
| **UI + API** | ✅ | جاهز من الباك إند | ✅ بطلب صريح |

> **Mock data:** ممنوع تلقائياً. لازم تطلبه صراحةً (see `no-mock-without-permission` skill).

#### أمثلة عملية:

**UI Only:**
```
/feature-prompt
Feature: الإشعارات
Figma Node: https://figma.com/design/xxx?node-id=123-456
Mode: UI_ONLY
```

**UI + API (Postman جاهز من الباك إند):**
```
/feature-prompt
Feature: المحفظة
Figma Node: https://figma.com/design/AbCdEf/App?node-id=850-1234
Mode: UI_AND_API
Postman: https://www.postman.com/team-name/workspace/collection/abc123
```

#### الـ 6 Phases الجديدة (orchestrator):

`feature-prompt` بقت **orchestrator** — كل phase بتشاور على skills تانية:

| Phase | الوصف | الـ Skills المستخدمة |
|-------|-------|---------------------|
| **PHASE 1 — Audit** | فحص color_manager + app_sizes + assets + core/widgets قبل ما يكتب أي حاجة | `feature-development` |
| **PHASE 2 — Read Figma** | قراءة Figma MCP لكل الـ states (main, empty, loading, error, modals) | `figma-mcp-read-first` (إجباري — لو فشل STOP)، `figma-mcp-mapping`، `figma-widget-mapping`، `design-tokens`، `rtl-arabic`، `localization-keys` |
| **PHASE 3 — Postman Collection** | يُتخطى لو UI_ONLY. وإلا: قراءة الـ Postman اللي ادّاه المستخدم (جاهز من الباك إند) | `api-pipeline` |
| **PHASE 4 — Plan** | يعرض خطة كاملة (folder structure, entities, cubits, scaffold types, CRUD plan) — بينتظر موافقتك | `flutter-patterns`, `scaffold-patterns`, `bloc-patterns` |
| **PHASE 5 — Implement** | كتابة الكود الفعلي — يستدعي ~20 skill حسب اللي محتاج | كل الـ skills المتخصصة |
| **PHASE 6 — Verify** | `flutter analyze` + RTL check + 21-point checklist | `post-feature-review` |

### الـ Skills المتاحة (34 skill)

اكتب `/اسم-الـskill` لتشغيل أي واحد:

#### Workflow & Entry Points

| الأمر | الوصف |
|-------|-------|
| `/feature-prompt` | **ابدأ هنا** — orchestrator (147 سطر) ينظم كل المراحل |
| `/feature-development` | Workflow كامل بدون decision tree |
| `/post-feature-review` | مراجعة تلقائية بعد كل فيشتر — checklist 12 نقطة |

#### Architecture & Patterns

| الأمر | الوصف |
|-------|-------|
| `/coding-standards` | المرجع الأساسي (893 سطر) — كل الـ standards الأساسية + pointers للـ subdomains |
| `/bloc-patterns` | AsyncCubit + CRUD local update + BlocListener + PaginatedCubit |
| `/flutter-patterns` | أنماط الويدجتس + هيكل الملفات + body = layout only |
| `/di-and-architecture` | DI + Injectable + طبقات Clean Architecture |
| `/bloc-provider-scoping` | وين تحط BlocProvider + قرارات الـ scoping |

#### Sub-domains (مستخرجة من coding-standards)

| الأمر | الوصف |
|-------|-------|
| `/extensions-and-helpers` | TextStyleEx, .szH/.szW, .toSliver, .onClick, FormatString, Validators, ImageHelper |
| `/naming-and-cleanup` | PascalCase classes, snake_case files, access modifiers, const, unused cleanup |
| `/widget-reference` | كاتالوج كامل لـ core/widgets/ — استخدمه قبل ما تبني widget جديدة |
| `/view-controller-pattern` | TextEditingController, ValueNotifier, FocusNode → كلهم في class منفصل (ViewController) |
| `/localization-keys` | lang.json format `"key #$ English": "عربي"` + LocaleKeys.tr() |

#### API & Data Flow

| الأمر | الوصف |
|-------|-------|
| `/api-pipeline` | Postman → ApiConstants → Entity → Cubit → UI |
| `/mock-data` | نظام التبديل بين Mock و Real API |
| `/no-mock-without-permission` | **alwaysApply** — ممنوع mock data بدون طلب صريح |
| `/form-api-pipeline` | خط أنابيب الفورمات: Form → ViewController → Params → API |
| `/navigation-patterns` | Go.to() + arguments + back with result |
| `/multi-screen-flow` | List/Detail/Edit/Create patterns |

#### Figma & Design

| الأمر | الوصف |
|-------|-------|
| `/figma-mcp-read-first` | **alwaysApply** — قراءة Figma MCP إجبارية. لو فشلت STOP |
| `/design-tokens` | تحويل Figma → AppColors/AppSize/AppPadding/AppCircular + sizing/icons rules |
| `/figma-to-flutter` | تحويل Figma لـ Flutter بالكامل |
| `/figma-widget-mapping` | جدول شامل: عنصر Figma → Widget Flutter |
| `/figma-mcp-mapping` | ربط قيم Figma MCP بالكود |
| `/figma-task-extractor` | استخراج مهام من ملف Figma |

#### RTL & Localization

| الأمر | الوصف |
|-------|-------|
| `/rtl-arabic` | قواعد RTL + منع الانعكاس + start=RIGHT, end=LEFT |

#### UI Patterns

| الأمر | الوصف |
|-------|-------|
| `/scaffold-patterns` | **alwaysApply** — أنواع الـ Scaffold + Status Bar |
| `/search-field-debounce` | حقل بحث + rxdart debounce |

#### Quality & Standards

| الأمر | الوصف |
|-------|-------|
| `/clean-code-and-refactoring` | تقسيم الويدجتس + إعادة الاستخدام |
| `/error-handling-and-resilience` | معالجة الأخطاء + retry patterns |
| `/logging-and-debugging` | لا print في الكود النهائي |
| `/performance-and-memory` | أداء + ذاكرة + dispose |
| `/pubspec-manager` | باكدجات + إعدادات المنصات |
| `/accessibility` | Tap targets + semantic labels |

> **ملاحظة:** الـ skills اللي عليها `alwaysApply: true` (figma-mcp-read-first, no-mock-without-permission, scaffold-patterns) Cursor بيحملها في كل conversation — مجموعها ~262 سطر فقط.

### Hooks — الأوامر التلقائية

الـ Hooks أوامر بتتنفذ تلقائياً في أوقات معينة. مثال على hook بيشغل `flutter analyze` بعد كل تعديل:

```json
// .claude/settings.json
{
  "hooks": {
    "PostToolUse": [
      { "matcher": "Edit|Write", "command": "flutter analyze --no-fatal-infos" }
    ]
  }
}
```

### Pre-commit hook (مهم بعد الـ refactor)

في `.git/hooks/pre-commit` — بيتشغل أوتوماتيك على كل commit:

```bash
if git diff --cached --name-only | grep -qE '^\.claude/skills/'; then
  bash scripts/sync-cursor.sh
  git add .cursor/rules/ .cursor/prompt/
fi
```

أي تعديل في `.claude/skills/` بيعمل sync تلقائي للـ `.cursor/rules/` والـ `.cursor/prompt/`.

### MCP Servers — الربط بالأدوات الخارجية

| الـ MCP | الاستخدام |
|---------|----------|
| **Figma (TalkToFigma)** | قراءة التصميمات وتحويلها لكود |
| **Postman** | قراءة الـ API collections وتوليد entities |

---

## Cursor

### المفاهيم الأساسية

| النظام | الوصف | المكان |
|--------|-------|--------|
| **Project Rules** | قواعد بتتطبق على ملفات معينة (globs) أو دايماً (alwaysApply) | `.cursor/rules/*.mdc` (auto-generated) |
| **Manual Prompts** | برومبتس تنسخها وتلصقها في الشات | `.cursor/prompt/*.md` (auto-generated) |
| **User Rules** | قواعد شخصية على كل المشاريع | Settings → Rules |
| **Team Rules** | قواعد الفريق من الـ Dashboard | Cursor Dashboard |
| **Context (@mentions)** | تحكم في السياق | `@Files`, `@Codebase`, `@Web` |
| **MCP Servers** | ربط بأدوات خارجية | `.cursor/mcp.json` |

### كيف الـ Rules بتشتغل بعد الـ refactor

كل rule في `.cursor/rules/<name>.mdc` بيتولّد من `.claude/skills/<name>/SKILL.md` + `.cursor.yaml`. الـ frontmatter بيحدد متى يتطبق:

**1. alwaysApply: true** (3 skills فقط، ~262 سطر):
- `figma-mcp-read-first` — Figma MCP read-first rule
- `no-mock-without-permission` — gate على mock data
- `scaffold-patterns` — Scaffold + Status Bar

**2. globs** (الباقي — بتتطبق على ملفات محددة):
- `coding-standards` → `lib/**/*.dart`
- `bloc-patterns` → `lib/src/features/**/cubits/**/*.dart`
- `rtl-arabic` → `lib/src/features/**/widgets/**/*.dart, lib/src/features/**/view/**/*.dart`
- `pubspec-manager` → `pubspec.yaml, android/**/*.xml, ios/**/*.plist`
- وهكذا — كل skill بتتطبق على الملفات المتعلقة بيها فقط

**3. Manual** (`feature-prompt`, `figma-task-extractor`):
- مفيش globs ولا alwaysApply — بتتشغل بـ `@` في الشات بس

### بدء فيشتر جديد

1. افتح Cursor's chat (Cmd/Ctrl+L)
2. اكتب `@` واختر `feature_prompt.md` من `.cursor/prompt/`
3. عدّل الـ placeholders:
   - `[FEATURE_NAME]` → اسم الفيشتر
   - `[FIGMA_URL]` → لينك الفيجما
   - `[UI_ONLY | UI_AND_API]` → اختار واحد
   - لو UI_AND_API → ادّيه link الـ Postman Collection
4. ابعت

#### مثال:

```
@feature_prompt.md

Feature: المحفظة
Figma Node: https://figma.com/design/AbCdEf/App?node-id=850-1234
Mode: UI_AND_API
Postman: https://www.postman.com/team-name/workspace/collection/abc123
```

### Agent Mode

في Cursor's Agent Mode:
- **Auto Context Gathering:** بيجمع السياق لوحده — مش محتاج `@` لكل ملف
- **Multi-step Execution:** بيقدر ينفذ خطوات متعددة تلقائي
- **Tool Integration:** Terminal + File Edit + MCP تلقائي
- **Checkpoints:** نقاط حفظ للـ rollback

### Context (@mentions)

| الأمر | الوصف |
|-------|-------|
| `@Files` | إضافة ملفات محددة |
| `@Folders` | إضافة مجلد كامل |
| `@Codebase` | بحث في كل الكود |
| `@Web` | بحث على الإنترنت |
| `@Docs` | الوثائق الرسمية للمكتبات |
| `@Git` | معلومات الـ Git |
| `@.cursor/prompt/feature_prompt.md` | البرومبت الجاهز |

> **نصيحة:** الـ rules بتتطبق تلقائي حسب الـ globs. مش محتاج تعمل `@` للـ rule.

### مهم: ممنوع تعدّل في `.cursor/rules/` مباشرة

أي تعديل في `.cursor/rules/*.mdc` أو `.cursor/prompt/*.md` هيتم overwrite في الـ commit القادم بسبب الـ pre-commit hook.

**عاوز تعدل rule؟** → عدّل `.claude/skills/<name>/SKILL.md`
**عاوز تغيّر globs أو alwaysApply؟** → عدّل `.claude/skills/<name>/.cursor.yaml`
**عاوز sync يدوي؟** → `bash scripts/sync-cursor.sh`
**عاوز تتأكد إن الاتنين متطابقين؟** → `bash scripts/sync-cursor.sh --check`

---

## الفرق بين الاتنين

| | Cursor | Claude Code |
|---|--------|-------------|
| **القواعد** | `.cursor/rules/*.mdc` (auto-generated) — تتطبق تلقائي حسب globs/alwaysApply | `.claude/skills/*/SKILL.md` — تتشغل بـ `/اسم` أو يقررها بنفسه |
| **الـ Source** | **مولّد من** `.claude/skills/` | **canonical** — مكان التحرير الفعلي |
| **الملف الأساسي** | Project Rules + User Rules | `CLAUDE.md` — يتقرأ تلقائي كل محادثة |
| **البرومبت** | `@.cursor/prompt/feature_prompt.md` (auto-generated) | `/feature-prompt` |
| **Agents** | `AGENTS.md` + Automations | Subagents (`.claude/agents/*.md`) |
| **Hooks** | مفيش (rules تتطبق تلقائي) | 12 event متاح |
| **MCP** | `.cursor/mcp.json` | `.claude/settings.json` |
| **alwaysApply load** | ~262 سطر/conv | بقدر ما يلزم |
| **Sync** | بـ `scripts/sync-cursor.sh` + pre-commit hook | غير محتاج — بيقرأ مباشرة |
| **المحتوى** | **متطابق 100%** | **متطابق 100%** |

---

## نصائح عامة لأفضل نتيجة

### لـ Claude Code:
1. **`CLAUDE.md` رفيع ومركز** — السياق الأساسي بس، التفاصيل في الـ skills
2. **`/feature-prompt` هي البداية** — الـ orchestrator يدير كل phase
3. **استخدم Hooks** — `flutter analyze` تلقائي بعد كل edit
4. **Subagents** للمهام المتكررة (review, testing)
5. **MCP** — Figma + Postman يوفرا وقت كبير

### لـ Cursor:
1. **Agent Mode دايماً** — يجمع السياق لوحده
2. **`@Codebase`** لما عاوز يفهم pattern موجود
3. **الـ Rules تشتغل في الخلفية** — مش محتاج تفكر فيها
4. **Team Rules** للمشاريع الجماعية
5. **ممنوع تعدّل في `.cursor/rules/` مباشرة** — هيتم overwrite

### Workflow عام:
1. **عدّل `.claude/skills/<name>/SKILL.md`** فقط — هو الـ canonical
2. **commit** — الـ pre-commit hook يحدّث `.cursor/` تلقائي
3. **ابدأ بـ "UI Only or UI + API?"** — قبل أي فيشتر
4. **وفر Figma + Postman** — كل ما المعلومات أكتر، النتيجة أحسن
5. **راجع الخطة في PHASE 4** — فرصتك تعدل قبل التنفيذ
6. **`/post-feature-review`** بعد كل فيشتر للتأكد من الجودة

---

## Sync Script Reference

```bash
# Sync كل الـ skills للـ cursor (أوتوماتيك في pre-commit)
bash scripts/sync-cursor.sh

# تحقق إن الاتنين متطابقين بدون ما يعدّل (يفيد في CI)
bash scripts/sync-cursor.sh --check

# Verbose mode
bash scripts/sync-cursor.sh --verbose
```

**الملفات اللي بتتولّد:**
- `.cursor/rules/<name>.mdc` — لكل skill في `.claude/skills/`
- `.cursor/prompt/feature_prompt.md` — paste-able copy للبرومبت
- `.cursor/prompt/README.md` — instructions للـ Cursor users

---

## مصادر ومراجع

- [Claude Code Docs](https://code.claude.com/docs/en/overview)
- [Claude Code Skills](https://code.claude.com/docs/en/skills)
- [Claude Code Hooks](https://code.claude.com/docs/en/hooks)
- [Claude Code Subagents](https://code.claude.com/docs/en/sub-agents)
- [Cursor Docs — Rules](https://cursor.com/docs/context/rules)
- [Cursor Docs — Agent](https://cursor.com/product)

---

## الـ Skills الجديدة (Phase 5 + 7 من الـ refactor)

| Skill | المصدر | الغرض |
|-------|--------|-------|
| `figma-mcp-read-first` | جديد كانوني | إجبار قراءة Figma MCP قبل أي UI code، STOP لو فشل |
| `no-mock-without-permission` | جديد كانوني | gate يمنع mock data بدون طلب صريح |
| `view-controller-pattern` | اتنقل من coding-standards §22 | نمط ViewController class للـ controllers/notifiers |
| `localization-keys` | جديد كانوني | format lang.json + LocaleKeys.tr() |
| `extensions-and-helpers` | اتنقل من coding-standards §12, §13, §8.4 | كاتالوج extensions و helpers |
| `naming-and-cleanup` | اتنقل من coding-standards §19, §20, §29, §30, §31 | naming + access + const + cleanup |
| `widget-reference` | اتنقل من coding-standards §11 | كاتالوج core widgets |

كل واحد منهم له `.cursor.yaml` بيحدد متى يتطبق في Cursor (globs أو alwaysApply).
