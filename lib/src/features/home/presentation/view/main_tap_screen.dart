part of '../imports/home_imports.dart';

class MainTapScreen extends StatefulWidget {
  const MainTapScreen({
    super.key,
    this.initialIndex = 0,
  });

  final int initialIndex;

  @override
  State<MainTapScreen> createState() => MainTapScreenState();
}

class MainTapScreenState extends State<MainTapScreen> {
  int _selectedIndex = 0;

  int _ordersRefreshToken = 0;
  int _employeesRefreshToken = 0;
  int _requestsRefreshToken = 0;
  int _myTeamRefreshToken = 0;
  int _profileRefreshToken = 0;

  late List<Widget?> _screens;

  bool _initialized = false;

  String? _currentLanguage;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initialIndex;

    _screens = [];
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final language = context.locale.languageCode;

    if (_currentLanguage != language) {
      _currentLanguage = language;

      if (!_initialized) {
        _initialized = true;

        _initializeScreens();
      } else {
        _refreshScreensForLanguage();
      }
    }
  }

  void _initializeScreens() {
    final user = context.read<UserCubit>().user;

    final isUser = F.appFlavor == Flavor.user;

    final isManager = isUser && user.role == 'manager';

    final length = isUser ? (isManager ? 4 : 3) : 3;

    _screens = List.generate(length, (_) => null);

    // create first tab immediately

    _screens[0] = _createScreen(index: 0, isUser: isUser, isManager: isManager);

    setState(() {});
  }

  void _refreshScreensForLanguage() {
    final user = context.read<UserCubit>().user;

    final isUser = F.appFlavor == Flavor.user;

    final isManager = isUser && user.role == 'manager';

    final length = isUser ? (isManager ? 4 : 3) : 3;

    setState(() {
      _screens = List.generate(length, (_) => null);

      // recreate current screen only

      _screens[_selectedIndex] = _createScreen(
        index: _selectedIndex,
        isUser: isUser,
        isManager: isManager,
      );
    });
  }
  void changeTab(int index, {bool refresh = false}) {
    if (!mounted || index < 0 || index >= _screens.length) return;

    final isUser = F.appFlavor == Flavor.user;
    final isManager = isUser && context.read<UserCubit>().user.role == 'manager';

    setState(() {
      if (refresh) {
        if (!isUser && index == 1) _requestsRefreshToken++;
        if (isManager && index == 1) _myTeamRefreshToken++;
        if (isUser && index == (isManager ? 2 : 1)) _ordersRefreshToken++;
      }

      if (_screens[index] == null || refresh) {
        _screens[index] = _createScreen(
          index: index,
          isUser: isUser,
          isManager: isManager,
        );
      }

      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().user;

    final isUser = F.appFlavor == Flavor.user;

    final isManager = isUser && user.role == 'manager';

    final tabs = _buildTabs(isUser: isUser, isManager: isManager);
    if (_screens.isEmpty) {
      return const Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: IndexedStack(
        index: _selectedIndex,

        children: [
          for (final screen in _screens) screen ?? const SizedBox.shrink(),
        ],
      ),

      bottomNavigationBar: AppBottomNavigationBar(
        tabs: tabs,

        activeColor: AppColors.brandSurface,

        selectedIndex: _selectedIndex,

        onTabChange: (index) {
          setState(() {
            if (_screens[index] == null) {
              _screens[index] = _createScreen(
                index: index,

                isUser: isUser,

                isManager: isManager,
              );
            }

            _selectedIndex = index;
          });
        },
      ),
    );
  }

  List<NavigationBarEntity> _buildTabs({
    required bool isUser,
    required bool isManager,
  }) {
    if (isUser) {
      if (isManager) {
        return [
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
        ];
      }

      return [
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

    return [
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
  }

  Widget _createScreen({
    required int index,
    required bool isUser,
    required bool isManager,
  }) {
    final language = context.locale.languageCode;

    if (isUser) {
      if (isManager) {
        switch (index) {
          case 0:
            return HomeScreen(key: ValueKey('home-$language'));

          case 1:
            return MyTeamScreen(
              key: ValueKey('team-$language'),
              refreshToken: _myTeamRefreshToken,
            );

          case 2:
            return OrdersScreen(
              key: ValueKey('orders-$language'),
              refreshToken: _ordersRefreshToken,
            );

          case 3:
            return ProfileScreen(
              key: ValueKey('profile-$language'),
              refreshToken: _profileRefreshToken,
            );
        }
      } else {
        switch (index) {
          case 0:
            return HomeScreen(key: ValueKey('home-$language'));

          case 1:
            return OrdersScreen(
              key: ValueKey('orders-$language'),
              refreshToken: _ordersRefreshToken,
            );

          case 2:
            return ProfileScreen(
              key: ValueKey('profile-$language'),
              refreshToken: _profileRefreshToken,
            );
        }
      }
    } else {
      switch (index) {
        case 0:
          return EmployeesScreen(
            key: ValueKey('employees-$language'),
            refreshToken: _employeesRefreshToken,
          );

        case 1:
          return RequestsScreen(
            key: ValueKey('requests-$language'),
            refreshToken: _requestsRefreshToken,
          );

        case 2:
          return ProfileScreen(
            key: ValueKey('profile-$language'),
            refreshToken: _profileRefreshToken,
          );
      }
    }

    return const SizedBox.shrink();
  }
}
