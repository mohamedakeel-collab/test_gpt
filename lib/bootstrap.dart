import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import 'flavors.dart';
import 'src/app.dart';
import 'src/config/language/languages.dart';
import 'src/config/res/config_imports.dart';
import 'src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'src/core/shared/helpers/helpers.dart';
import 'src/core/network/auth/token_storage.dart';
import 'src/core/navigation/constants/imports_constants.dart';
import 'src/core/navigation/go.dart';
import 'src/core/navigation/page_router/implementation/imports_page_router.dart';
import 'src/core/navigation/page_router/imports_page_router_builder.dart';
import 'src/core/network/cache/cache_config.dart';
import 'src/core/network/network_info.dart';
import 'src/core/network/offline/offline_queue_manager.dart';
import 'src/core/shared/observer/bloc_observer.dart';
import 'src/core/shared/service_locators/setup_service_locators.dart';
import 'src/core/widgets/exception_view.dart';

/// Shared app bootstrap for every flavor.
///
/// Each flavor entry point (`main_user.dart`, `main_provider.dart`) only picks
/// its [Flavor] and delegates here so the initialization sequence is never
/// duplicated.
Future<void> bootstrap(Flavor flavor) async {
  F.appFlavor = flavor;

  // Only attach the logging observer in debug — keeps bloc event/state data
  // (which can include PII) out of release logs.
  if (kDebugMode) Bloc.observer = AppBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  // Hive needs to be ready before any cache/queue store opens a box.
  await Hive.initFlutter();

  await Future.wait([
    // Firebase.initializeApp(),
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

  // Restore the previous session (user payload + tokens) from encrypted
  // storage BEFORE the first frame, so the initial route already knows the
  // auth status without a flicker.
  await injector<UserCubit>().init();

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

  Helpers.changeStatusbarColor(statusBarColor: Colors.transparent);

  runApp(
    EasyLocalization(
      supportedLocales: Languages.supportLocales,
      path: 'assets/translations',
      fallbackLocale: Languages.english.locale,
      saveLocale: true,
      child: const App(),
    ),
  );
}
