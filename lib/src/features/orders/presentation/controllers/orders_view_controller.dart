part of '../imports/orders_imports.dart';

/// View-level state that doesn't belong in a cubit:
///   - selected filter tab (maps to the `leave_type` query param)
///
/// Pattern
///   - Create in `initState`.
///   - Always call `dispose()` from the screen's `dispose`.
///   - Expose state via `ValueNotifier`s so widgets can listen via
///     `ValueListenableBuilder` instead of rebuilding the whole screen.
class OrdersViewController {
  OrdersViewController({required this.onTabChanged});

  /// Called whenever the selected tab changes (already mapped to a
  /// `leave_type`); the cubit re-fetches with that filter.
  final ValueChanged<String?> onTabChanged;

  /// Selected tab index — 0 = all leaves, 1 = permissions, 2 = remote.
  final ValueNotifier<int> selectedTab = ValueNotifier(0);

  /// Maps the tab index to the `leave_type` value sent to the API.
  /// `null` means "no filter" (fetch every leave request).
  static const Map<int, String?> _leaveTypesByTab = {
    0: 'leave',
    1: 'permission',
    2: 'remote',
  };

  /// `leave_type` matching the currently selected tab.
  String? get selectedLeaveType => _leaveTypesByTab[selectedTab.value];

  void selectTab(int index) {
    if (selectedTab.value == index) return;
    selectedTab.value = index;
    onTabChanged(selectedLeaveType);
  }

  void dispose() {
    selectedTab.dispose();
  }
}