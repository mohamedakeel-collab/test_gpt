import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import 'src/app.dart';
import 'src/config/language/languages.dart';
import 'src/core/helpers/helpers.dart';
import 'src/core/network/auth/token_storage.dart';
import 'src/core/navigation/Constants/imports_constants.dart';
import 'src/core/navigation/go.dart';
import 'src/core/navigation/page_router/Implementation/imports_page_router.dart';
import 'src/core/navigation/page_router/imports_page_router_builder.dart';
import 'src/core/network/cache/cache_config.dart';
import 'src/core/network/network_info.dart';
import 'src/core/network/offline/offline_queue_manager.dart';
import 'src/core/notifications/notification_manager.dart';
import 'src/core/notifications/notification_router.dart';
import 'src/core/shared/bloc_observer.dart';
import 'src/core/shared/service_locators/setup_service_locators.dart';
import 'src/core/widgets/handling_views/exeption_view.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  // Hive needs to be ready before any cache/queue store opens a box.
  await Hive.initFlutter();

  await Future.wait([
    Firebase.initializeApp(),
    EasyLocalization.ensureInitialized(),
    ScreenUtil.ensureScreenSize(),
    NetworkInfo().check(),
    // Hydrate the in-memory token cache from encrypted storage so the
    // first authed request after launch already has a Bearer header.
    TokenStorage.instance.init(),
  ]);

  // These depend on Hive being initialised.
  await CacheConfig.init();
  await OfflineQueueManager().init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // DI: TokenStorage, DioClient, NotificationManager, ConnectivityCubit, UserCubit, …
  setUpServiceLocator();

  // Notifications route through Go.navigatorKey (shared with the rest of the app).
  await NotificationManager.instance.initialize(
    router: const AppNotificationRouter(),
    debug: kDebugMode,
  );

  PageRouterBuilder().initAppRouter(
    config: PlatformConfig(
      android: CustomPageRouterCreator(
        parentTransition: TransitionType.fade,
        parentOptions: const FadeAnimationOptions(
          duration: Duration(milliseconds: 300),
        ),
      ),
    ),
  );

  Animate.restartOnHotReload = true;

  if (kReleaseMode) {
    ErrorWidget.builder =
        (FlutterErrorDetails details) => const ExceptionView();
  }

  if (kDebugMode) {
    EasyLocalization.logger.enableLevels = [
      LevelMessages.error,
      LevelMessages.warning,
    ];
  }

  Helpers.changeStatusbarColor(statusBarColor: Colors.transparent);

  runApp(
    EasyLocalization(
      supportedLocales: Languages.supportLocales,
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      saveLocale: true,
      child: const App(),
    ),
  );
}
