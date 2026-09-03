part of '../imports/profile_imports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.refreshToken = 0});

  final int refreshToken;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileCubit _cubit;
  late final LanguageCubit _languageCubit;
  late final LogoutCubit _logoutCubit;
  late final ProfileViewController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = injector<ProfileCubit>()..getProfile();
    _languageCubit = injector<LanguageCubit>();
    _logoutCubit = injector<LogoutCubit>();
    _controller = const ProfileViewController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _logoutCubit.close();
    _languageCubit.close();
    _cubit.close();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ProfileScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.refreshToken != oldWidget.refreshToken) {
      _cubit.getProfile();
    }
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>.value(value: _cubit),
        BlocProvider<LanguageCubit>.value(value: _languageCubit),
        BlocProvider<LogoutCubit>.value(value: _logoutCubit),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.main,
        ),
        child: _ProfileBody(controller: _controller),
      ),
    );
  }
}
