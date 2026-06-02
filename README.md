<h1 align="center">{PROJECT_NAME}</h1>

<p align="center">
  <img src="assets/svg/app_svg/app_logo.png" width="140" alt="{PROJECT_NAME} logo" />
</p>

<p align="center"><b>{PROJECT_TAGLINE}</b></p>

<p align="center">
  <img alt="Flutter"  src="https://img.shields.io/badge/Flutter-{FLUTTER_VERSION}-02569B?logo=flutter&logoColor=white" />
  <img alt="Dart"     src="https://img.shields.io/badge/Dart-{DART_VERSION}-0175C2?logo=dart&logoColor=white" />
  <img alt="Backend"  src="https://img.shields.io/badge/Backend-{BACKEND}-777BB4" />
  <img alt="Status"   src="https://img.shields.io/badge/status-in--development-yellow" />
</p>

---

## Table of contents

1. [Project overview](#1-project-overview)
2. [Links](#2-links)
3. [Accounts](#3-accounts)
4. [Identity](#4-identity)
5. [Firebase](#5-firebase)
6. [Team](#6-team)
7. [Setup & commands](#7-setup--commands)
8. [Architecture](#8-architecture)
9. [Project structure](#9-project-structure)
10. [Conventions](#10-conventions)
11. [Template notes](#11-template-notes)

---

## 1. Project overview

| Field | Value |
| --- | --- |
| Name | **{PROJECT_NAME}** |
| Main idea | {PROJECT_DESCRIPTION} |
| Backend | {BACKEND} |
| Flutter SDK | {3.41.9} |
| User types | {USER_TYPES} |

### Feature highlights
- {FEATURE_1}
- {FEATURE_2}
- {FEATURE_3}

---

## 2. Links

### Development

| Resource | Link |
| --- | --- |
| Postman collection | `{POSTMAN_LINK}` |
| Figma (UI) | `{FIGMA_LINK}` |
| Test plan | `{TEST_FILE_LINK}` |

### Production

| Channel | Link |
| --- | --- |
| App Store | `{APP_STORE_LINK}` |
| Google Play | `{GOOGLE_PLAY_LINK}` |

### Dashboard

| Field | Value |
| --- | --- |
| URL | `{DASHBOARD_LINK}` |
| Email | `{DASHBOARD_EMAIL}` |
| Password | `{DASHBOARD_PASSWORD}` |

---

## 3. Accounts

### App test accounts

| Role | Email | Password |
| --- | --- | --- |
| {ROLE_1} | `{USER_EMAIL}` | `{USER_PASSWORD}` |

> Keep this section in sync with QA — every test environment must have at least one verified account per role.

---

## 4. Identity

| Field | Value |
| --- | --- |
| App display name | {APP_DISPLAY_NAME} |
| Bundle ID (Android) | `{ANDROID_BUNDLE_ID}` |
| Bundle ID (iOS) | `{IOS_BUNDLE_ID}` |
| Minimum iOS | {MIN_IOS_VERSION} |
| Minimum Android | {MIN_ANDROID_VERSION} |

---

## 5. Firebase

| Field | Value |
| --- | --- |
| Account holder | **{FIREBASE_ACCOUNT_HOLDER}** |
| Project name | **{FIREBASE_PROJECT_NAME}** |
| Console URL | `{FIREBASE_CONSOLE_LINK}` |
| Services in use | {FIREBASE_SERVICES} |

> `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are **not committed** — pull them from the Firebase console before building.

---

## 6. Team

| Role | Name | Contact |
| --- | --- | --- |
| Flutter | **{FLUTTER_DEV_NAME}** | `{FLUTTER_DEV_CONTACT}` |
| Backend | **{BACKEND_DEV_NAME}** | `{BACKEND_DEV_CONTACT}` |
| Testing | `{TESTER_NAME}` | `{TESTER_CONTACT}` |
| Design | `{DESIGNER_NAME}` | `{DESIGNER_CONTACT}` |
| Product | `{PM_NAME}` | `{PM_CONTACT}` |

---

## 7. Setup & commands

### First run

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

### Environments (API base URL)

The API base URL is **not hardcoded** — it is read from the `API_BASE_URL`
compile-time variable via `--dart-define` (falls back to
`https://api.example.com/api/v1/` when omitted). All endpoints in
`ApiEndpoints` are **relative** (e.g. `auth/login`); `DioClient` prepends the
base, so the value **must end with a trailing `/`**.

```bash
flutter run   --dart-define=API_BASE_URL=https://dev.api.com/api/v1/
flutter run   --dart-define=API_BASE_URL=https://staging.api.com/api/v1/
flutter build apk --dart-define=API_BASE_URL=https://api.production.com/api/v1/
```

> Tip: keep per-environment values in a `--dart-define-from-file` JSON to avoid
> retyping them.

### Translations

The master file is `assets/translations/lang.json` in the format `"snake_case_key #$ English text": "Arabic text"`.
After editing it, regenerate `ar.json`, `en.json`, and `lib/src/config/language/locale_keys.g.dart`:

```bash
dart run generate/strings/main.dart
```

> The script also starts a watcher. Stop with `Ctrl+C` once the first generation prints `Lang Json File Updated successfully`.

### Code generation (DI + Hive adapters)

```bash
dart run build_runner build --delete-conflicting-outputs
```

Re-run whenever you add a class with `@injectable`, `@lazySingleton`, `@LazySingleton(as: ...)`, or `@HiveType`.

### Asset generation

```bash
dart pub global activate flutter_gen
dart run build_runner build --delete-conflicting-outputs
```

Outputs typed asset accessors at `lib/src/config/res/assets.gen.dart` (`AppAssets.svg.…`, `AppAssets.lottie.…`).

### Quality checks

```bash
flutter analyze
flutter test
```

---

## 8. Architecture

This project is built on the **clean_arch_base** template. Below is a quick map — open the source files for the full doc-comments.

### Clean Architecture layers

```
┌────────────────────────────────────────────────────────────────┐
│  presentation/  view + widgets + cubits + controllers          │
│       ↑                                                        │
│  domain/        entities + abstract repos + use cases          │
│       ↑                                                        │
│  data/          models + mappers + concrete repos/data sources │
└────────────────────────────────────────────────────────────────┘
```

Domain knows nothing about Flutter, Dio, or Hive. Data is the only place that imports them.

### State management

| Tool | Purpose |
| --- | --- |
| `AsyncCubit<T>` | One-shot async data — emits `AsyncInitial / AsyncLoading / AsyncSuccess(T) / AsyncFailure(Failure)`. |
| `AsyncBlocBuilder<C, T>` | UI consumer with built-in loading / error / empty handling. |
| `PaginatedAsyncCubit<T>` | Paginated lists — `fetchInitialData / loadMore / refresh / filterKey`. Uses `BaseStatus` enum. |
| `PaginatedListWidget<C, T>` | Full-featured list with skeleton loading, pull-to-refresh, auto load-more on scroll, inline error tile, grid / list / separated views. |

### Network

| Layer | Component |
| --- | --- |
| Singleton client | `DioClient()` with interceptors: `LocaleInterceptor → AuthInterceptor → RetryInterceptor → AppCacheInterceptor → LoggingInterceptor`. |
| Unified call | `BaseRemoteSource.request<T>()` — pass `HttpMethod.get/post/put/patch/delete` + body / query / headers / `skipAuth` / `asFormData`. Returns `Either<Failure, T>`. |
| Endpoint registry | `ApiEndpoints` (central). |
| Error type | Sealed `Failure` hierarchy — `NetworkFailure`, `TimeoutFailure`, `ValidationFailure`, `UnauthorizedFailure`, `ServerFailure`, `CancelledFailure`, … All localized via `LocaleKeys`. |
| Cancellation | `RequestCancellationManager` — newer requests cancel older same-keyed ones (search-while-typing UX). |
| Offline queue | `OfflineQueueManager` (Hive-backed) — replays writes when connectivity returns. |

### Storage

| Use case | Component |
| --- | --- |
| Encrypted at-rest | `SecureStorage` (only at-rest store — `shared_preferences` deliberately dropped). |
| Tokens | `TokenStorage` — in-memory cache backed by `SecureStorage`; hydrated at app start. |
| Hive boxes | `hive_ce` — offline queue & generic key-value. |

### Dependency injection

`injectable` + `get_it`. Use `@injectable`, `@lazySingleton`, `@LazySingleton(as: Interface)`. Run `build_runner` to regenerate `setup_service_locators.config.dart`.

### Localization

`easy_localization` + custom generator under `generate/strings/`. Master file is `assets/translations/lang.json`. Access via `LocaleKeys.xxx` — resolved at read time, so language switches don't need a rebuild.

### Design tokens

| Token class | Purpose |
| --- | --- |
| `AppColors` | Brand + neutrals + status + dark-mode variants. |
| `AppSize` | Heights / widths (`.h` / `.w` scaled). |
| `AppPadding`, `AppMargin` | Spacing tokens. |
| `AppCircular` | Border-radius. |
| `FontSizeManager`, `FontWeightManager` | Type ramp. |
| `ConstantManager` | Numeric / string constants (`pgSize`, `emptyText`, …). |

> No hardcoded numbers or hex colors inside widgets — every visual constant lives in the tables above.

### Adaptive UI (Material + Cupertino)

| Helper | Behaviour |
| --- | --- |
| `CustomLoading.inline()` | `CircularProgressIndicator` on Android, `CupertinoActivityIndicator` on iOS. |
| `showAdaptiveAlert()` | Material `AlertDialog.adaptive` — iOS gets Cupertino styling automatically. |
| `showCustomDatePicker()` | `showDatePicker` on Android, `CupertinoDatePicker` in a bottom sheet on iOS. |
| `showDefaultBottomSheet()` | Material `showModalBottomSheet` with `showDragHandle: true`. |

---

## 9. Project structure

```
lib/
├── main.dart                        App bootstrap (Hive, Firebase, DI, EasyLocalization, runApp)
└── src/
    ├── app.dart                     MaterialApp + MultiBlocProvider + Go.navigatorKey
    ├── config/
    │   ├── language/                LocaleKeys.g.dart + Languages enum
    │   ├── res/                     AppColors, AppSize, AppPadding, ConstantManager, Assets
    │   └── themes/                  AppTheme
    ├── core/
    │   ├── extensions/              Context, String, TextStyle, JSON, BaseStatus, …
    │   ├── helpers/                 Validators, ImageHelper, LauncherHelper, SecureStorage
    │   ├── navigation/              Go class, named routes, page routers, transitions
    │   ├── network/
    │   │   ├── auth/                TokenStorage
    │   │   ├── base/                BaseRemoteSource
    │   │   ├── cache/               CacheConfig (MemCacheStore)
    │   │   ├── cancel/              RequestCancellationManager
    │   │   ├── cubits/              ConnectivityCubit, OfflineQueueCubit
    │   │   ├── error/               Failure sealed class + AppException mapping
    │   │   ├── exceptions/          AppException (low-level transport)
    │   │   ├── interceptors/        Auth / Retry / Cache / Locale / Logging
    │   │   ├── offline/             OfflineQueueManager + QueuedOperation (Hive)
    │   │   ├── options/             RequestExtra
    │   │   ├── parser/              ResponseParser, StatusCodeHandler
    │   │   ├── api_endpoints.dart
    │   │   ├── dio_client.dart
    │   │   ├── http_method.dart
    │   │   └── network_info.dart
    │   ├── notifications/           awesome_notifications + FCM wiring
    │   ├── shared/
    │   │   ├── bloc_observer.dart
    │   │   ├── cubits/              UserCubit, BaseUrlCubit
    │   │   ├── models/              UserModel
    │   │   └── service_locators/    setup_service_locators.dart (+ .config.dart generated)
    │   ├── state/
    │   │   ├── async/               AsyncCubit, AsyncState, AsyncBlocBuilder
    │   │   └── paginated/           PaginationMeta, PaginatedData, PaginatedAsyncCubit, ListWidget
    │   └── widgets/                 Buttons, fields, dialogs, pickers, scaffolds, …
    └── features/
        └── <feature_name>/          See "Feature folder convention" below

assets/
├── fonts/                           Beiruti family (8 weights)
├── lottie/
├── svg/                             base_svg/, app_svg/
└── translations/
    ├── lang.json                    Master ("snake_case #$ English": "Arabic")
    ├── ar.json                      Generated
    └── en.json                      Generated

generate/
└── strings/                         Localization generator + watcher
```

### Feature folder convention

```
lib/src/features/<feature_name>/
├── data/
│   ├── datasources/                 Concrete (extends BaseRemoteSource)
│   ├── mappers/                     Model ↔ Entity extensions
│   ├── models/                      DTOs (fromJson uses JsonGetters)
│   └── repositories/                Concrete (implements abstract)
├── domain/
│   ├── datasources/                 Abstract interface
│   ├── entities/                    Pure domain objects + initial() factories
│   ├── enums/                       Domain enums with fromRaw() safety
│   ├── repositories/                Abstract interface
│   └── usecases/                    Business rules — return Either<Failure, T>
└── presentation/
    ├── imports/                     library file + part directives
    ├── view/                        Public screens (provide cubit)
    ├── widgets/                     Body, cards, dialogs, sheets — private to feature
    ├── controllers/                 ViewControllers (non-bloc UI state)
    └── cubits/                      AsyncCubit / PaginatedAsyncCubit subclasses
```

See `lib/src/features/products/` for the canonical example.

---

## 10. Conventions

### Error handling
- **No `try/catch` past the data layer.** All errors flow as `Either<Failure, T>`.
- The UI consumes `AsyncFailure(failure)` → `AppErrorHandler` renders icon + localized message + retry button.
- `CancelledFailure` is silent — the UI keeps its previous state (a newer request superseded an in-flight one).

### Optimistic CRUD
Local list mutations (`addProduct / updateProduct / removeProduct`) update the cubit immediately. The network call follows; on failure, the cubit reverts.

### Search debounce
`rxdart.BehaviorSubject + debounceTime(350ms)` inside the screen's `initState`, fed by the search field's `onChanged`.

### Form validation
- `FormMixin` provides `formKey + validate() + validateAndScroll()`.
- Validators in `core/helpers/validators.dart` use `LocaleKeys` for messages.

### Logging
- Network: `LoggingInterceptor` (debug only).
- BLoC events: `AppBlocObserver` (debug only).
- Avoid `print` — use `dart:developer log` or remove before merging.

### Translations
- Add new keys to `assets/translations/lang.json` only — never edit `ar.json` / `en.json` / `locale_keys.g.dart` by hand.
- Run `dart run generate/strings/main.dart` to regenerate the trio.
- Prefer per-feature prefixes: `products_*`, `cart_*`, `auth_*` — keeps the generated `LocaleKeys` class navigable.

### Hardcoded values
- Numbers → `AppSize`, `AppPadding`, `AppMargin`, `AppCircular`.
- Colors → `AppColors`.
- Strings → `LocaleKeys.*`.
- Fixed business constants → `ConstantManager`.

### Pull-request checklist
- [ ] `flutter analyze` is clean.
- [ ] `flutter test` passes.
- [ ] New translations added to `lang.json` (not `ar.json` / `en.json` directly).
- [ ] No `print` statements; no commented-out code blocks.
- [ ] No hardcoded numeric / color / string literals.
- [ ] `build_runner` re-run if any annotation was touched.

---

## 11. Template notes

This README is a **template**. Sections 1–6 are project-specific — every `{PLACEHOLDER}` between curly braces (and every `` `placeholder` `` in backticks) must be replaced for each new project. Sections 7–11 describe the **base** architecture and stay the same across projects.

### Quick checklist when starting a new project

1. **Search & replace every `{PLACEHOLDER}`** in sections 1–6 with the real value. Suggested order:
   - `{PROJECT_NAME}` (title + logo alt text)
   - `{PROJECT_TAGLINE}`, `{PROJECT_DESCRIPTION}`, `{USER_TYPES}`, `{FEATURE_1..3}`
   - `{FLUTTER_VERSION}`, `{DART_VERSION}`, `{BACKEND}`
   - `{POSTMAN_LINK}`, `{FIGMA_LINK}`, `{TEST_FILE_LINK}`
   - `{APP_STORE_LINK}`, `{GOOGLE_PLAY_LINK}`
   - `{DASHBOARD_LINK}`, `{DASHBOARD_EMAIL}`, `{DASHBOARD_PASSWORD}`
   - `{ROLE_1}`, `{USER_EMAIL}`, `{USER_PASSWORD}` — duplicate the table row for each role
   - `{APP_DISPLAY_NAME}`, `{ANDROID_BUNDLE_ID}`, `{IOS_BUNDLE_ID}`, `{MIN_IOS_VERSION}`, `{MIN_ANDROID_VERSION}`
   - `{FIREBASE_ACCOUNT_HOLDER}`, `{FIREBASE_PROJECT_NAME}`, `{FIREBASE_CONSOLE_LINK}`, `{FIREBASE_SERVICES}`
   - `{FLUTTER_DEV_NAME}`, `{BACKEND_DEV_NAME}`, `{TESTER_NAME}`, `{DESIGNER_NAME}`, `{PM_NAME}` (+ their `{*_CONTACT}` columns)
2. **Replace the logo** at `assets/svg/app_svg/app_logo.png`.
3. **Update `pubspec.yaml`** → `name`, `description`, `version`.
4. **Update the Android bundle ID** in `android/app/build.gradle` and the **iOS bundle ID** in `ios/Runner/Info.plist`.
5. **Drop the Firebase config files** for the new project (`google-services.json`, `GoogleService-Info.plist`).
6. **Clear `assets/translations/lang.json`** of any project-specific keys and start fresh — keep only the core entries (failures / common UI / validation).

### Customization checklist (base → your project)

Everything below is **project-specific**. The rest of `core/` is infrastructure
you should not need to touch.

| What | Where | Notes |
| --- | --- | --- |
| **Brand color** | `lib/src/config/res/color_manager.dart` → `AppColors.brand` (+ `brandLight` / `brandDark`) | Single anchor — the gradient and the legacy aliases (`buttonColor`, `loginPrimary`, …) all derive from it. Change these three and the theme follows. |
| **App name** | `lib/src/config/res/constants_manager.dart` → `ConstantManager.appName` | Used in `MaterialApp.title` and as a fallback screen title. |
| **Font** | `ConstantManager.fontFamily` (`Beiruti`) + `pubspec.yaml` `fonts:` + `assets/fonts/` | Swap the family and the 8 weight files. |
| **User shape** | `lib/src/core/shared/models/user_model.dart` | Ships a sample shape (`fullName`, `phoneNumber`, `city`, `userType`, `allowNotify`). Trim/extend to match *your* backend's user object. |
| **API base URL** | `--dart-define=API_BASE_URL=…` (see *Environments* above) | No code change — set per environment at build time. |
| **App icons (SVG)** | `assets/svg/app_svg/` + regenerate with `flutter_gen` | Feature-specific glyphs live here; shared ones in `base_svg/`. |
| **Demo feature** | `lib/src/features/products/` | The reference implementation. Delete it once you've copied the pattern: `./scripts/remove_demo.sh` (then re-run `build_runner`). |
| **New features** | `./scripts/new_feature.sh <name> [entity]` | Generates a compileable, rule-following scaffold. |

> **Goal:** a fresh clone should run with only `pubspec.yaml`, the Firebase
> files, and `AppColors.brand` changed. Everything else is optional polish.

---

<p align="center">
  Built with <a href="https://flutter.dev">Flutter</a> on top of the <b>clean_arch_base</b> template.
</p>
