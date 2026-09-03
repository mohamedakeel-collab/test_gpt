part of '../imports/home_imports.dart';

class MainTapScreen extends StatefulWidget {
  const MainTapScreen({super.key});

  @override
  State<MainTapScreen> createState() => _MainTapScreenState();
}

class _MainTapScreenState extends State<MainTapScreen> {
  int _selectedIndex = 0;

  int _ordersRefreshToken = 0;
  int _employeesRefreshToken = 0;
  int _requestsRefreshToken = 0;

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
                  _buildTab(
                    index: 0,
                    child: HomeScreen(
                      key: ValueKey('home-${locale.languageCode}'),
                    ),
                  ),

                  _buildTab(
                    index: 1,
                    child: MyTeamScreen(
                      key: ValueKey('my-team-${locale.languageCode}'),
                    ),
                  ),

                  _buildTab(
                    index: 2,
                    child: OrdersScreen(
                      key: ValueKey('orders-${locale.languageCode}'),

                      refreshToken: _ordersRefreshToken,
                    ),
                  ),

                  _buildTab(index: 3, child: const ProfileScreen()),
                ]
              : [
                  _buildTab(
                    index: 0,
                    child: HomeScreen(
                      key: ValueKey('home-${locale.languageCode}'),
                    ),
                  ),

                  _buildTab(
                    index: 1,
                    child: OrdersScreen(
                      key: ValueKey('orders-${locale.languageCode}'),

                      refreshToken: _ordersRefreshToken,
                    ),
                  ),

                  _buildTab(index: 2, child: const ProfileScreen()),
                ]
        : [
            _buildTab(
              index: 0,
              child: EmployeesScreen(
                key: ValueKey('employees-${locale.languageCode}'),

                refreshToken: _employeesRefreshToken,
              ),
            ),

            _buildTab(
              index: 1,
              child: RequestsScreen(
                key: ValueKey('requests-${locale.languageCode}'),

                refreshToken: _requestsRefreshToken,
              ),
            ),

            _buildTab(index: 2, child: const ProfileScreen()),
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

            if (!isUser && index == 0) {
              _employeesRefreshToken++;
            }

            if (!isUser && index == 1) {
              _requestsRefreshToken++;
            }

            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildTab({required int index, required Widget child}) {
    return Offstage(
      offstage: _selectedIndex != index,

      child: TickerMode(enabled: _selectedIndex == index, child: child),
    );
  }
}
