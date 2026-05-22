import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/res/config_imports.dart';
import '../dropdown_layout.dart';

/// White surface with rounded top corners — shared chrome for both
/// single- and multi-select sheets.
class DropdownSheetContainer extends StatelessWidget {
  const DropdownSheetContainer({
    super.key,
    required this.height,
    required this.child,
  });

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DropdownLayout.sheetTopRadius.r),
        ),
      ),
      child: child,
    );
  }
}
