import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../config/res/config_imports.dart';
import '../../shared/extensions/text_style_extensions.dart';
import 'animated_button.dart';
import 'navigation_bar_entity.dart';
class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.tabs,
    this.selectedIndex = 0,
    this.onTabChange,
    required this.activeColor,
  });

  final List<NavigationBarEntity> tabs;
  final int selectedIndex;
  final Color? activeColor;
  final ValueChanged<int>? onTabChange;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  late int _selectedIndex;
  bool _isClickable = true;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _handleTabPress(int index) {
    if (!_isClickable) return;

    setState(() {
      _selectedIndex = index;
      _isClickable = false;
    });

    widget.onTabChange?.call(index);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _isClickable = true);
    });
  }

  Widget _buildTab(NavigationBarEntity tab, int index) {
    final isActive = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _handleTabPress(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                tab.icon,
                width: 24.w,
                height: 24.h,
                color: isActive ? widget.activeColor : const Color(0xFF5F5E5E),
              ),
              const SizedBox(height: 4),
                  Text(
                tab.text,
                style:isActive ? TextStyle().setBrandSurfaceColor.s13.medium : TextStyle().setHintColor.s13.medium ,
              ),
              if (isActive)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: widget.activeColor,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      padding:  EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: widget.tabs
            .asMap()
            .entries
            .map((entry) => _buildTab(entry.value, entry.key))
            .toList(),
      ),
    );
  }
}