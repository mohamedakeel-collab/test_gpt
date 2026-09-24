part of '../imports/splash_imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _goNext();
  }

  Future<void> _goNext() async {
    if (_navigated) return;
    _navigated = true;

    await Future.delayed(
      const Duration(milliseconds: ConstantManager.splashTimer),
    );
    if (!mounted) return;


    final isLoggedIn = injector<UserCubit>().isUserLoggedIn;
    if (isLoggedIn) {
      Go.offAll(MainTapScreen(key: mainTapKey));
    } else {
      Go.offAll(const IntroScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.main,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.splashBackground,
          body: SplashBody(),
        ),
      ),
    );
  }
}