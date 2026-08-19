part of '../imports/home_imports.dart';

/// View-level state that doesn't belong in a cubit:
///   - scroll controller (lifecycle tied to the widget)
///   - selected leaves/permissions tab
///
/// Pattern
///   - Create in `initState`.
///   - Always call `dispose()` from the screen's `dispose`.
class HomeViewController {
  HomeViewController();

  final ScrollController scrollController = ScrollController();
  final ValueNotifier<int> selectedTab = ValueNotifier(0);

  void dispose() {
    scrollController.dispose();
    selectedTab.dispose();
  }
}