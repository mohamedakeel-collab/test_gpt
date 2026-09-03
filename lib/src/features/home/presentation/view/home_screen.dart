part of '../imports/home_imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit _cubit;
  late final HomeViewController _vc;

  @override
  void initState() {
    super.initState();
    _cubit = injector<HomeCubit>()..fetchHome();
    _vc = HomeViewController();
  }

  @override
  void dispose() {
    _vc.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>.value(
      value: _cubit,
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            InkWell(
              onTap: () {
                Go.to(NotificationsScreen());
              },
              child: IconWidget(
                icon: Icons.notifications_none,
                color: AppColors.primary,
                height: AppSize.sH25,
              ).paddingSymmetric(horizontal: AppPadding.pH12),
            ),
          ],
        ),
        body: _HomeBody(controller: _vc),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Go.to(const NewRequestScreen());

            print('-----------------------------------');
            print(result);

            if (result == true && mounted) {
              _cubit.fetchHome();
            }
          },
        ),
      ),
    );
  }
}
