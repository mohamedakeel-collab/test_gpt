part of '../imports/splash_imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initUserData(context);
    super.initState();
  }
  Future<void> initUserData(BuildContext context) async {
    Future.delayed(
      const Duration(milliseconds: ConstantManager.splashTimer),
    ).then((value) async {
      final result = await UserCubit.instance.init();

      if (result) {
        Go.to(IntroScreen());
      } else {
        Go.to(IntroScreen());
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.main,
        ),
        child:  SafeArea(
          child: const Scaffold(
            backgroundColor: AppColors.splashBackground, body:SplashBody(),),
        ));
  }
}
