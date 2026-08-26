part of '../imports/home_imports.dart';

class MainTapScreen extends StatefulWidget {
  const MainTapScreen({super.key});

  @override
  State<MainTapScreen> createState() => _MainTapScreenState();
}

class _MainTapScreenState extends State<MainTapScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final isUser = F.appFlavor == Flavor.user;
    final tabs = isUser
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
    final screens = isUser
        ? [
            HomeScreen(key: ValueKey('home-${locale.languageCode}')),
            OrdersScreen(key: ValueKey('orders-${locale.languageCode}')),
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
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
