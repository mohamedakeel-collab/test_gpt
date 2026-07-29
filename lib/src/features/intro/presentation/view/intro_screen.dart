part of '../imports/intro_imports.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late final PageController _pageController;
  late final ValueNotifier<int> _currentPageNotifier;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentPageNotifier = ValueNotifier(0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_currentPageNotifier.value < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skip() {
    Go.to(LoginScreen());
  }

  void _onPageChanged(int page) {
    _currentPageNotifier.value = page;
  }

  void _getStarted() {
    Go.to(LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.main,
      ),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: _IntroBody(
          pageController: _pageController,
          currentPageNotifier: _currentPageNotifier,
          onNext: _goNext,
          onSkip: _skip,
          onPageChanged: _onPageChanged,
          onGetStarted: _getStarted,
        ),
      ),
    );
  }
}
