part of '../imports/login_imports.dart';

/// Public entry point — `Go.to(const LoginScreen())`.
///
/// Responsibilities of a *screen* file:
///   - Provide the cubit (via [BlocProvider]).
///   - Own the [LoginViewController] lifecycle (init / dispose).
///   - Compose scaffold + body. **Never** layout content directly here —
///     that's the body widget's job.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginCubit _cubit;
  late final LoginViewController _vc;

  @override
  void initState() {
    super.initState();
    _cubit = injector<LoginCubit>();
    _vc = LoginViewController();
  }

  @override
  void dispose() {
    _vc.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>.value(
      value: _cubit,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.main,
        ),
        child: Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: _LoginBody(vc: _vc),
        ),
      ),
    );
  }
}
