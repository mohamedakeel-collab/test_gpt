part of '../imports/home_imports.dart';

class MainTapScreen extends StatefulWidget {
  const MainTapScreen({super.key});

  @override
  State<MainTapScreen> createState() => _MainTapScreenState();
}

class _MainTapScreenState extends State<MainTapScreen> {
  int _selectedIndex = 0;
  int _ordersRefreshToken = 0;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final user = context.read<UserCubit>().user;
    final isUser = F.appFlavor == Flavor.user;
    final isManager = isUser && user.role == 'manager';
    final ordersIndex = isManager ? 2 : 1;
    final tabs = isUser
        ? isManager
            ? [
                NavigationBarEntity(
                  icon: AppAssets.svg.baseSvg.home.path,
                  text: LocaleKeys.home,
                ),
                NavigationBarEntity(
                  icon: AppAssets.svg.baseSvg.myTeam.path,
                  text: LocaleKeys.myTeam,
                ),
                NavigationBarEntity(
                  icon: AppAssets.svg.baseSvg.order.path,
                  text: LocaleKeys.orders,
                ),
                NavigationBarEntity(
                  icon: AppAssets.svg.baseSvg.person.path,
                  text: LocaleKeys.homeProfile,
                ),
              ]
            : [
                NavigationBarEntity(
                  icon: AppAssets.svg.baseSvg.home.path,
                  text: LocaleKeys.home,
                ),
                NavigationBarEntity(
                  icon: AppAssets.svg.baseSvg.order.path,
                  text: LocaleKeys.orders,
                ),
                NavigationBarEntity(
                  icon: AppAssets.svg.baseSvg.person.path,
                  text: LocaleKeys.homeProfile,
                ),
              ]
        : [
            NavigationBarEntity(
              icon: AppAssets.svg.baseSvg.employees.path,
              text: LocaleKeys.employees,
            ),
            NavigationBarEntity(
              icon: AppAssets.svg.baseSvg.order.path,
              text: LocaleKeys.requests,
            ),
            NavigationBarEntity(
              icon: AppAssets.svg.baseSvg.person.path,
              text: LocaleKeys.homeProfile,
            ),
          ];
    final screens = isUser
        ? isManager
            ? [
                HomeScreen(key: ValueKey('home-${locale.languageCode}')),
                MyTeamScreen(key: ValueKey('my-team-${locale.languageCode}')),
                OrdersScreen(
                  key: ValueKey('orders-${locale.languageCode}'),
                  refreshToken: _ordersRefreshToken,
                ),
                const ProfileScreen(),
              ]
            : [
                HomeScreen(key: ValueKey('home-${locale.languageCode}')),
                OrdersScreen(
                  key: ValueKey('orders-${locale.languageCode}'),
                  refreshToken: _ordersRefreshToken,
                ),
                const ProfileScreen(),
              ]
        : [
            EmployeesScreen(key: ValueKey('employees-${locale.languageCode}')),
            RequestsScreen(key: ValueKey('requests-${locale.languageCode}')),
            const ProfileScreen(),
          ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: screens),

      bottomNavigationBar: AppBottomNavigationBar(
        tabs: tabs,
        activeColor: AppColors.brandSurface,

        selectedIndex: _selectedIndex,

        onTabChange: (index) {
          setState(() {
            if (isUser && index == ordersIndex) {
              _ordersRefreshToken++;
            }
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
