part of '../imports/home_imports.dart';

class MainTapScreen extends StatefulWidget {
  const MainTapScreen({super.key});

  @override
  State<MainTapScreen> createState() => _MainTapScreenState();
}

class _MainTapScreenState extends State<MainTapScreen> {
  int _selectedIndex = 0;
  late final List<NavigationBarEntity> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
           HomeScreen(),
           OrdersScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        tabs: _tabs,
        activeColor: AppColors.brandSurface,
        selectedIndex: _selectedIndex,
        onTabChange: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
