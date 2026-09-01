part of '../imports/requests_imports.dart';

class RequestsViewController {
  RequestsViewController({required this.onTabChanged});

  final ValueChanged<String?> onTabChanged;

  final ValueNotifier<int> selectedTab = ValueNotifier(0);

  static const Map<int, String?> _leaveTypesByTab = {
    0: 'leave',
    1: 'permission',
    2: 'remote',
  };

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
