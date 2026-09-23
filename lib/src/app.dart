import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../flavors.dart';
import 'config/res/config_imports.dart';
import 'config/themes/app_theme.dart';
import 'core/navigation/named_routes.dart';
import 'core/navigation/navigator.dart';
import 'core/navigation/route_generator.dart';
import 'core/network/auth/token_storage.dart';
import 'core/network/cubits/connectivity_cubit.dart';
import 'core/network/cubits/offline_queue_cubit.dart';
import 'core/notifications/notification_manager.dart';
import 'core/notifications/notification_router.dart';
import 'core/shared/cubits/user_cubit/user_cubit.dart';
import 'features/home/presentation/imports/home_imports.dart';
import 'features/home/presentation/keys/main_tap_key.dart';
import 'features/intro/presentation/imports/intro_imports.dart';
import 'features/login/presentation/imports/login_imports.dart';
import 'features/splash/presentation/imports/splash_imports.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final bool _hasToken;
  @override
  void initState() {
    super.initState();
    _hasToken = TokenStorage.instance.hasAccessToken;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeNotifications();
    });
  }

  Future<void> _initializeNotifications() async {
    final notificationManager = injector<NotificationManager>();

    await notificationManager.initialize(
      router: const AppNotificationRouter(),
      debug: kDebugMode,
    );

    await notificationManager.requestPermissions();

    await notificationManager.requestToken();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,

      builder: (_, child) => MultiBlocProvider(
        providers: [
          BlocProvider<UserCubit>.value(value: injector<UserCubit>()),

          BlocProvider<ConnectivityCubit>.value(
            value: injector<ConnectivityCubit>(),
          ),

          BlocProvider<OfflineQueueCubit>.value(
            value: injector<OfflineQueueCubit>(),
          ),
        ],

        child: MaterialApp(
          title: F.title,

          debugShowCheckedModeBanner: false,

          navigatorKey: Go.navigatorKey,

          theme: AppTheme.light,

          darkTheme: AppTheme.dark,

          themeMode: ThemeMode.system,

          locale: context.locale,

          supportedLocales: context.supportedLocales,

          localizationsDelegates: context.localizationDelegates,

          home: _hasToken
              ? MainTapScreen(key: mainTapKey)
              : const SplashScreen(),
        ),
      ),
    );
  }
}
