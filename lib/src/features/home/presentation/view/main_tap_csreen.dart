part of '../imports/home_imports.dart';

class MainTapScreen extends StatefulWidget {
  const MainTapScreen({super.key});

  @override
  State<MainTapScreen> createState() => _MainTapScreenState();
}

class _MainTapScreenState extends State<MainTapScreen> {
  int _selectedIndex = 0;

  late final List<NavigationBarEntity> _tabs;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    final isUser = F.appFlavor == Flavor.user;

    _tabs = isUser
        ? [
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

    _screens = isUser
        ? [const HomeScreen(), OrdersScreen(), const ProfileScreen()]
        : [
            const EmployeesScreen(),

            const RequestsScreen(),

            const ProfileScreen(),
          ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),

      bottomNavigationBar: AppBottomNavigationBar(
        tabs: _tabs,
        activeColor: AppColors.brandSurface,

        selectedIndex: _selectedIndex,

        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
