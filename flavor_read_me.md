
<div dir="rtl" align="right">

# دليل إعداد Flavors في Flutter Base Project


## 📋 المحتويات

1. [مقدمة](#مقدمة)
2. [المتطلبات الأساسية](#المتطلبات-الأساسية)
3. [خطوات إضافة Flavors](#خطوات-إضافة-flavors)
4. [إعداد Firebase](#إعداد-firebase)
5. [تشغيل التطبيق](#تشغيل-التطبيق)
6. [استخدام Flavors في الكود](#استخدام-flavors-في-الكود)
7. [حل المشاكل الشائعة](#حل-المشاكل-الشائعة)

---

## مقدمة

هذا الدليل يشرح كيفية إضافة **Flavors** إلى مشروع Flutter Base باستخدام حزمة `flutter_flavorizr`. 

**Flavors** تتيح لك إنشاء نسخ متعددة من نفس التطبيق مع إعدادات مختلفة (مثل: Bundle ID مختلف، أيقونات مختلفة، إعدادات Firebase مختلفة، إلخ).

---

## ⚠️ تنبيه مهم قبل البدء

> **مهم جداً:** قبل تسجيل المشروع على Firebase، تأكد من تحديد **Bundle ID** و **Application ID** النهائيين لكل flavor في ملف `flavorizr.yaml`. 
> 
> **لماذا؟** لأن Bundle ID و Application ID لا يمكن تغييرهما بعد تسجيل التطبيق على Firebase. إذا قمت بتغييرهما لاحقاً، ستحتاج إلى إنشاء مشروع Firebase جديد وتنزيل ملفات الإعدادات مرة أخرى.
> 
> **نصيحة:** خطط لـ Bundle IDs و Application IDs قبل البدء، وتأكد من أنها:
> - فريدة لكل flavor
> - تتبع معايير التسمية الصحيحة (مثل: `com.company.app.flavor`)
> - لن تحتاج إلى تغييرها لاحقاً

---

## المتطلبات الأساسية

قبل البدء، تأكد من تثبيت المتطلبات التالية:

### 1. Ruby و Gem
<div dir="ltr" align="left">

```bash
# التحقق من تثبيت Ruby
ruby --version

# التحقق من تثبيت Gem
gem --version
```

</div>

### 2. Xcodeproj (لـ iOS و macOS فقط)
<div dir="ltr" align="left">

```bash
gem install xcodeproj
```

</div>

> **ملاحظة:** إذا كنت ستستخدم flavors على Android فقط، يمكنك تخطي هذا الخطوة.

### 3. Podfile موجود (لـ iOS و macOS)
تأكد من وجود ملف `Podfile` في مجلدات `ios/` و `macos/`.

---

## خطوات إضافة Flavors

### الخطوة 1: إضافة flutter_flavorizr كـ dev dependency

افتح ملف `pubspec.yaml` وأضف `flutter_flavorizr` في قسم `dev_dependencies`:

<div dir="ltr" align="left">

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  flutter_flavorizr: ^2.4.1  # أضف هذا السطر
```

</div>

ثم قم بتشغيل:
<div dir="ltr" align="left">

```bash
flutter pub get
```

</div>

### الخطوة 2: إنشاء ملف flavorizr.yaml

أنشئ ملف جديد باسم `flavorizr.yaml` في جذر المشروع (نفس مستوى `pubspec.yaml`).

### الخطوة 3: تعريف Flavors

افتح ملف `flavorizr.yaml` وحدد flavors الخاصة بك. إليك مثال كامل:

<div dir="ltr" align="left">

```yaml
flavors:
  # Flavor الأول - مثال: User App
  user:
    app:
      name: "User App"
    
    android:
      applicationId: "com.example.app.user"
      icon: "assets/icons/user.png"  # اختياري
      firebase:
        config: "firebase/user/google-services.json"
    
    ios:
      bundleId: "com.example.app.user"
      icon: "assets/icons/user.png"  # اختياري
      firebase:
        config: "firebase/user/GoogleService-Info.plist"
  
  # Flavor الثاني - مثال: Provider App
  provider:
    app:
      name: "Provider App"
    
    android:
      applicationId: "com.example.app.provider"
      icon: "assets/icons/provider.png"  # اختياري
      firebase:
        config: "firebase/provider/google-services.json"
    
    ios:
      bundleId: "com.example.app.provider"
      icon: "assets/icons/provider.png"  # اختياري
      firebase:
        config: "firebase/provider/GoogleService-Info.plist"
```

</div>

#### شرح الحقول:

- **`flavors`**: قائمة بجميع flavors التي تريد إنشاءها
- **`app.name`**: اسم التطبيق الذي سيظهر للمستخدم
- **`android.applicationId`**: معرف التطبيق على Android (يجب أن يكون فريد لكل flavor)
- **`android.icon`**: مسار أيقونة التطبيق على Android (اختياري)
- **`ios.bundleId`**: معرف الحزمة على iOS (يجب أن يكون فريد لكل flavor)
- **`ios.icon`**: مسار أيقونة التطبيق على iOS (اختياري)
- **`firebase.config`**: المسار الخاص بملفات الفايربيز المنزله كل من اندرويد و IOS 

### الخطوة 4: تشغيل flutter_flavorizr

بعد تعريف flavors في `flavorizr.yaml`، قم بتشغيل الأمر التالي:

<div dir="ltr" align="left">

```bash
flutter pub run flutter_flavorizr
```

</div>

> **ملاحظة:** قد يستغرق الأمر بعض الوقت لأنه يقوم بإنشاء ملفات كثيرة.

#### خيارات إضافية:

- **تشغيل في وضع verbose (مفصل):**
  <div dir="ltr" align="left">

  ```bash
  flutter pub run flutter_flavorizr -v
  ```

  </div>

- **تخطي رسالة التأكيد:**
  <div dir="ltr" align="left">

  ```bash
  flutter pub run flutter_flavorizr -f
  ```

  </div>

- **تشغيل معالجات محددة فقط:**
  <div dir="ltr" align="left">

  ```bash
  flutter pub run flutter_flavorizr -p assets:download,assets:extract
  ```

  </div>

### الخطوة 5: تحديث main.dart

بعد تشغيل `flutter_flavorizr`، سيتم إنشاء ملف `lib/flavors.dart` تلقائياً. يجب تحديث `main.dart` لاستخدام flavors.

#### مثال على main.dart بعد التعديل:

<div dir="ltr" align="left">

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
// ... باقي الـ imports

// أضف هذا الـ import
import 'flavors.dart';

void main() async {
  // تحديد Flavor الحالي بناءً على المتغير appFlavor
  // (هذا المتغير يتم تمريره تلقائياً من Flutter CLI عند تشغيل --flavor)
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );

  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Firebase (لا تمرر options هنا)
  await Firebase.initializeApp();

  // باقي الكود...
  await Future.wait([
    EasyLocalization.ensureInitialized(),
    CacheStorage.init(),
    ScreenUtil.ensureScreenSize(),
  ]);

  // ... باقي الإعدادات

  runApp(
    EasyLocalization(
      supportedLocales: Languages.supportLocales,
      path: 'assets/translations',
      saveLocale: true,
      fallbackLocale: const Locale('ar'),
      child: const App(),
    ),
  );
}
```

</div>

> **ملاحظة:** المتغير `appFlavor` يتم إنشاؤه تلقائياً بواسطة `flutter_flavorizr` في ملف `main.dart` الذي يتم إنشاؤه. إذا كنت تستخدم `main.dart` موجود مسبقاً، قد تحتاج إلى إضافة هذا المتغير يدوياً أو استخدام الطريقة البديلة المذكورة أدناه.

#### طريقة بديلة (إذا كان main.dart موجود مسبقاً):

إذا كان لديك `main.dart` موجود مسبقاً ولا تريد استخدام الملف الذي ينشئه `flutter_flavorizr`، يمكنك إضافة هذا الكود في بداية `main()`:

<div dir="ltr" align="left">

```dart
void main() async {
  // تحديد Flavor من environment variable
  const String flavorName = String.fromEnvironment('FLUTTER_FLAVOR', defaultValue: 'user');
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == flavorName,
    orElse: () => Flavor.values.first,
  );

  // باقي الكود...
}
```

</div>

---

## إعداد Firebase

> **⚠️ تذكير مهم:** قبل البدء في إعداد Firebase، تأكد من أنك حددت **Bundle ID** و **Application ID** النهائيين لكل flavor في ملف `flavorizr.yaml`. لا يمكن تغيير هذه القيم بعد تسجيل التطبيق على Firebase.

### الخطوة 1: إنشاء مشاريع Firebase

1. اذهب إلى [Firebase Console](https://console.firebase.google.com/)
2. أنشئ مشروع Firebase منفصل لكل flavor (أو استخدم مشروع واحد مع تطبيقات متعددة)
3. **تأكد من استخدام نفس `applicationId` المحدد في `flavorizr.yaml`** عند إضافة تطبيق Android
4. **تأكد من استخدام نفس `bundleId` المحدد في `flavorizr.yaml`** عند إضافة تطبيق iOS

### الخطوة 2: تنزيل ملفات الإعدادات

1. لكل تطبيق Android، حمّل ملف `google-services.json`
2. لكل تطبيق iOS، حمّل ملف `GoogleService-Info.plist`

### الخطوة 3: تنظيم الملفات

أنشئ مجلد `firebase/` في جذر المشروع، ثم أنشئ مجلد فرعي لكل flavor:

<div dir="ltr" align="left">

```
firebase/
  ├── user/
  │   ├── google-services.json
  │   └── GoogleService-Info.plist
  └── provider/
      ├── google-services.json
      └── GoogleService-Info.plist
```

</div>

### الخطوة 4: تحديث flavorizr.yaml

تأكد من أن مسارات Firebase في `flavorizr.yaml` تشير إلى الملفات الصحيحة:

<div dir="ltr" align="left">

```yaml
flavors:
  user:
    android:
      firebase:
        config: "firebase/user/google-services.json"
    ios:
      firebase:
        config: "firebase/user/GoogleService-Info.plist"
  
  provider:
    android:
      firebase:
        config: "firebase/provider/google-services.json"
    ios:
      firebase:
        config: "firebase/provider/GoogleService-Info.plist"
```

</div>

### الخطوة 5: إعادة تشغيل flutter_flavorizr

بعد إضافة ملفات Firebase، قم بتشغيل:

<div dir="ltr" align="left">

```bash
flutter pub run flutter_flavorizr
```

</div>

سيقوم `flutter_flavorizr` بنسخ ملفات Firebase إلى الأماكن الصحيحة لكل flavor.

### الخطوة 6: إضافة Firebase dependencies (اختياري)

إذا كنت تستخدم `flutterfire_cli` لإضافة Firebase dependencies، **تجاهل** ملف `firebase_options.dart` الذي يتم إنشاؤه لأنه سيتعارض مع flavors.

بدلاً من ذلك، استخدم:

<div dir="ltr" align="left">

```dart
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // لا تمرر options هنا - سيتم استخدام الملفات الصحيحة تلقائياً
  await Firebase.initializeApp();
  
  // باقي الكود...
}
```

</div>

---

## تشغيل التطبيق

### تشغيل Flavor محدد

بعد إعداد flavors، يمكنك تشغيل flavor محدد باستخدام:

<div dir="ltr" align="left">

```bash
flutter run --flavor <flavor_name>
```

</div>

#### أمثلة:

<div dir="ltr" align="left">

```bash
# تشغيل User flavor
flutter run --flavor user

# تشغيل Provider flavor
flutter run --flavor provider

# تشغيل مع build mode محدد
flutter run --flavor user --release
flutter run --flavor provider --debug
```

</div>

### تشغيل على Android

<div dir="ltr" align="left">

```bash
flutter run --flavor user -d <device_id>
```

</div>

### تشغيل على iOS

<div dir="ltr" align="left">

```bash
flutter run --flavor user -d <device_id>
```

</div>

> **ملاحظة:** على macOS، قد تحتاج لتشغيل flavors من Xcode بسبب bug في Flutter SDK. افتح `ios/Runner.xcworkspace` في Xcode واختر الـ schema المناسب.

### Build للنشر

#### Android (APK):
<div dir="ltr" align="left">

```bash
flutter build apk --flavor user --release
flutter build apk --flavor provider --release
```

</div>

#### Android (App Bundle):
<div dir="ltr" align="left">

```bash
flutter build appbundle --flavor user --release
flutter build appbundle --flavor provider --release
```

</div>

#### iOS:
<div dir="ltr" align="left">

```bash
flutter build ios --flavor user --release
flutter build ios --flavor provider --release
```

</div>

---

## استخدام Flavors في الكود

### الوصول إلى Flavor الحالي

بعد إعداد flavors، يمكنك الوصول إلى Flavor الحالي من أي مكان في الكود:

<div dir="ltr" align="left">

```dart
import 'flavors.dart';

// الحصول على اسم Flavor
String flavorName = F.name; // "user" أو "provider"

// الحصول على عنوان التطبيق
String appTitle = F.title; // "User App" أو "Provider App"
```

</div>

### تخصيص الكود بناءً على Flavor

يمكنك تخصيص الكود بناءً على Flavor الحالي:

<div dir="ltr" align="left">

```dart
import 'flavors.dart';

class ApiConfig {
  static String get baseUrl {
    switch (F.appFlavor) {
      case Flavor.user:
        return 'https://api-user.example.com';
      case Flavor.provider:
        return 'https://api-provider.example.com';
    }
  }
  
  static String get apiKey {
    switch (F.appFlavor) {
      case Flavor.user:
        return 'user_api_key';
      case Flavor.provider:
        return 'provider_api_key';
    }
  }
}
```

</div>

### تخصيص الألوان بناءً على Flavor

<div dir="ltr" align="left">

```dart
import 'flavors.dart';
import 'package:flutter/material.dart';

class AppColors {
  static Color get primary {
    switch (F.appFlavor) {
      case Flavor.user:
        return Colors.blue;
      case Flavor.provider:
        return Colors.green;
    }
  }
  
  static Color get secondary {
    switch (F.appFlavor) {
      case Flavor.user:
        return Colors.lightBlue;
      case Flavor.provider:
        return Colors.lightGreen;
    }
  }
}
```

</div>

### تخصيص النصوص بناءً على Flavor

<div dir="ltr" align="left">

```dart
import 'flavors.dart';

class AppStrings {
  static String get welcomeMessage {
    switch (F.appFlavor) {
      case Flavor.user:
        return 'مرحباً بك في تطبيق المستخدم';
      case Flavor.provider:
        return 'مرحباً بك في تطبيق مقدم الخدمة';
    }
  }
}
```

</div>

### إضافة Banner في وضع Debug

يمكنك إضافة banner يظهر Flavor الحالي في وضع Debug:

<div dir="ltr" align="left">

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: F.title,
      // ... باقي الإعدادات
      builder: (context, child) {
        // إضافة Banner في وضع Debug
        if (kDebugMode) {
          return Banner(
            location: BannerLocation.topStart,
            message: F.name.toUpperCase(),
            color: Colors.green.withAlpha(150),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.0,
              letterSpacing: 1.0,
            ),
            child: child!,
          );
        }
        return child!;
      },
    );
  }
}
```

</div>

---

## حل المشاكل الشائعة

### 1. خطأ "Unable to load contents of file list"

**السبب:** عدم وجود `Podfile` في مجلد `ios/` أو `macos/`.

**الحل:**
- تأكد من وجود `Podfile` في `ios/` و `macos/`
- إذا لم يكن موجوداً، قم بإنشائه:
  <div dir="ltr" align="left">

  ```bash
  cd ios
  pod init
  ```

  </div>

### 2. خطأ في تشغيل flavors على macOS

**السبب:** Bug معروف في Flutter SDK.

**الحل:**
- افتح `ios/Runner.xcworkspace` أو `macos/Runner.xcworkspace` في Xcode
- اختر الـ schema المناسب من القائمة المنسدلة
- اضغط Run

أو أضف هذا الإعداد في `flavorizr.yaml`:

<div dir="ltr" align="left">

```yaml
flavors:
  user:
    macos:
      bundleId: "com.example.app.user"
      buildSettings:
        LD_RUNPATH_SEARCH_PATHS:
          - "$(inherited)"
          - "@executable_path/../Frameworks"
```

</div>

### 3. Firebase لا يعمل بشكل صحيح

**السبب:** ملفات Firebase غير موجودة أو في مسارات خاطئة.

**الحل:**
- تأكد من وجود ملفات Firebase في المسارات المحددة في `flavorizr.yaml`
- تأكد من أن `applicationId` و `bundleId` في `flavorizr.yaml` تطابق ما في Firebase Console
- أعد تشغيل `flutter pub run flutter_flavorizr`

### 4. خطأ "appFlavor is not defined"

**السبب:** المتغير `appFlavor` غير موجود في `main.dart`.

**الحل:**
- تأكد من أنك تستخدم `main.dart` الذي تم إنشاؤه بواسطة `flutter_flavorizr`
- أو أضف الكود التالي في بداية `main()`:
  <div dir="ltr" align="left">

  ```dart
  const String appFlavor = String.fromEnvironment('FLUTTER_FLAVOR', defaultValue: 'user');
  ```

  </div>

### 5. الأيقونات لا تظهر بشكل صحيح

**السبب:** مسار الأيقونة غير صحيح أو الملف غير موجود.

**الحل:**
- تأكد من وجود ملفات الأيقونات في المسارات المحددة
- تأكد من إضافة الأيقونات في `pubspec.yaml`:
  <div dir="ltr" align="left">

  ```yaml
  flutter:
    assets:
      - assets/icons/
  ```

  </div>

### 6. خطأ في Ruby أو xcodeproj

**السبب:** Ruby أو xcodeproj غير مثبت بشكل صحيح.

**الحل:**
<div dir="ltr" align="left">

```bash
# تثبيت Ruby (على macOS)
brew install ruby

# تثبيت xcodeproj
gem install xcodeproj
```

</div>

### 7. flavors لا تعمل بعد التحديث

**السبب:** ملفات flavors قديمة أو غير متزامنة.

**الحل:**
<div dir="ltr" align="left">

```bash
# حذف build folder
flutter clean

# إعادة تشغيل flutter_flavorizr
flutter pub run flutter_flavorizr

# إعادة build
flutter pub get
```

</div>

---

## نصائح إضافية

### 1. استخدام Environment Variables

يمكنك استخدام environment variables لتخصيص flavors أكثر:

<div dir="ltr" align="left">

```dart
const String apiUrl = String.fromEnvironment('API_URL', defaultValue: 'https://api.example.com');
```

</div>

### 2. إدارة Secrets

لا تضع secrets (مثل API keys) مباشرة في الكود. استخدم:
- Environment variables
- `.env` files مع حزمة `flutter_dotenv`
- Firebase Remote Config

### 3. Testing مع Flavors

عند كتابة tests، تأكد من تحديد flavor:

<div dir="ltr" align="left">

```dart
void main() {
  testWidgets('User flavor test', (WidgetTester tester) async {
    F.appFlavor = Flavor.user;
    // ... باقي الكود
  });
}
```

</div>

### 4. CI/CD

عند إعداد CI/CD، تأكد من تحديد flavor في build commands:

<div dir="ltr" align="left">

```yaml
# مثال GitHub Actions
- name: Build APK
  run: flutter build apk --flavor user --release
```

</div>

---

## المراجع

- [flutter_flavorizr Documentation](https://pub.dev/packages/flutter_flavorizr)
- [Flutter Flavors Guide](https://docs.flutter.dev/deployment/flavors)
- [Firebase Setup Guide](https://firebase.google.com/docs/flutter/setup)

---

## الدعم

إذا واجهت أي مشاكل، يمكنك:
1. مراجعة قسم [حل المشاكل الشائعة](#حل-المشاكل-الشائعة)
2. فتح issue في repository المشروع
3. مراجعة [flutter_flavorizr Issues](https://github.com/AngeloAvv/flutter_flavorizr/issues)

---

**آخر تحديث:** تم إنشاء هذا الدليل بناءً على flutter_flavorizr v2.4.1

</div>

## PROMPETT

I have a Flutter project.

Please implement Flutter Flavors (user and provider) according to the instructions in the attached flavor_read_me.md file.

Follow the documentation exactly and apply it to my existing project architecture.

Requirements:

1. Create two app entry points:
- lib/main_user.dart
- lib/main_provider.dart

2. Keep my existing project initialization logic:
- Hive initialization
- EasyLocalization
- ScreenUtil
- Service Locator
- UserCubit initialization
- CacheConfig
- OfflineQueueManager
- Router initialization
- Error handling

Do not duplicate the initialization code. Create a shared bootstrap function if needed.

3. Create/update flavors.dart:
- Flavor enum:
  - user
  - provider
- Add F.appFlavor
- Add flavor name and title getters.

4. Update App widget:
- Keep the existing MaterialApp configuration.
- Use F.appFlavor to decide the initial screen.
- User flavor should start with User flow.
- Provider flavor should start with Provider flow.

Example:
User:
SplashScreen/Home flow

Provider:
LoginScreen/Provider flow

5. Add flavor-specific configuration support:
- API base URL
- App name
- Theme/colors if needed

Use the existing AppColors/AppTheme architecture.

6. Do not replace my current architecture.
   The project already uses:
- feature-first structure
- Bloc
- GetIt injector
- EasyLocalization
- ScreenUtil

Integrate flavors into the current structure.

7. Add required Android flavor configuration:
- Update android/app/build.gradle.kts
- Add productFlavors:
  - user
  - provider
- Add unique applicationId for each flavor.

8. After implementation, provide the commands:

Run user:
flutter run --flavor user -t lib/main_user.dart

Run provider:
flutter run --flavor provider -t lib/main_provider.dart

Build user:
flutter build apk --flavor user -t lib/main_user.dart

Build provider:
flutter build apk --flavor provider -t lib/main_provider.dart

9. Verify there are no duplicate imports or duplicated App classes.

Use the attached flavor_read_me.md as the source of truth.