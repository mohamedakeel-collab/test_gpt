part of '../imports/profile_imports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileCubit _cubit;
  late final LogoutCubit _logoutCubit;
  late final ProfileViewController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = injector<ProfileCubit>()..getProfile();
    _logoutCubit = injector<LogoutCubit>();
    _controller = const ProfileViewController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _logoutCubit.close();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>.value(value: _cubit),
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
