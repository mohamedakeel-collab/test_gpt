// `Go.context` is the app's global Navigator context — always mounted
// while the app is alive, so the cross-await BuildContext warning never
// applies to this file.
// ignore_for_file: use_build_context_synchronously

import 'dart:io' show Platform;

import 'package:clean_arch_base/src/core/shared/extensions/text_style_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../config/language/languages.dart';
import '../../../config/res/config_imports.dart';
import '../../navigation/navigator.dart';

/// Picks a date adaptively:
///
/// Android -> Material DatePicker
/// iOS     -> Cupertino DatePicker
///
/// [controller] is optional.
/// Always returns the selected [DateTime].
Future<DateTime?> showCustomDatePicker({
  TextEditingController? controller,
  String? dateFormat,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final BuildContext context = Go.context;

  final DateTime now = DateUtils.dateOnly(DateTime.now());

  final DateTime first = DateUtils.dateOnly(
    firstDate ?? DateTime(now.year - 1, now.month, now.day),
  );

  final DateTime last = DateUtils.dateOnly(
    lastDate ?? DateTime(now.year + 2, now.month, now.day),
  );

  DateTime initial = DateUtils.dateOnly(initialDate ?? now);

  // Make sure initialDate is inside the allowed range.
  if (initial.isBefore(first)) {
    initial = first;
  }

  if (initial.isAfter(last)) {
    initial = last;
  }

  final DateTime? picked = Platform.isIOS
      ? await _showCupertinoDatePicker(
          context: context,
          initial: initial,
          first: first,
          last: last,
        )
      : await _showMaterialDatePicker(
          context: context,
          initial: initial,
          first: first,
          last: last,
        );

  if (picked == null) {
    return null;
  }

  if (controller != null) {
    controller.text = formatAppDate(picked, format: dateFormat);
  }

  return picked;
}

/// Android Material Date Picker.
Future<DateTime?> _showMaterialDatePicker({
  required BuildContext context,
  required DateTime initial,
  required DateTime first,
  required DateTime last,
}) {
  return showDatePicker(
    context: context,

    locale: Languages.currentLanguage.locale,

    initialDate: initial,
    firstDate: first,
    lastDate: last,

    initialEntryMode: DatePickerEntryMode.calendarOnly,

    barrierColor: AppColors.black.withValues(alpha: 0.45),

    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          datePickerTheme: DatePickerThemeData(
            backgroundColor: AppColors.white,

            surfaceTintColor: AppColors.white,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppCircular.r20),
            ),

            headerBackgroundColor: AppColors.brandSurface,

            headerForegroundColor: AppColors.white,

            headerHeadlineStyle: const TextStyle().setWhiteColor.s20.medium,

            headerHelpStyle: const TextStyle().setWhiteColor.s12.regular,

            todayForegroundColor: WidgetStatePropertyAll(AppColors.primary),

            todayBorder: BorderSide(color: AppColors.primary),

            dayForegroundColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.white;
              }

              return AppColors.black;
            }),

            dayBackgroundColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.brandSurface;
              }

              return Colors.transparent;
            }),

            cancelButtonStyle: TextButton.styleFrom(
              foregroundColor: AppColors.black,
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.pW16,
                vertical: AppPadding.pH10,
              ),
              textStyle: const TextStyle().setHintColor.s14.medium,
            ),

            confirmButtonStyle: TextButton.styleFrom(
              foregroundColor: AppColors.white,
              backgroundColor: AppColors.brandSurface,
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.pW20,
                vertical: AppPadding.pH10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppCircular.r10),
              ),
              textStyle: const TextStyle().setWhiteColor.s14.medium,
            ),
          ),
        ),
        child: child!,
      );
    },
  );
}

/// iOS Cupertino Date Picker.
Future<DateTime?> _showCupertinoDatePicker({
  required BuildContext context,
  required DateTime initial,
  required DateTime first,
  required DateTime last,
}) {
  DateTime selectedDate = initial;

  return showModalBottomSheet<DateTime>(
    context: context,

    backgroundColor: AppColors.white,

    barrierColor: AppColors.black.withValues(alpha: 0.45),

    showDragHandle: true,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppCircular.r20),
      ),
    ),

    builder: (sheetContext) {
      final localizations = MaterialLocalizations.of(sheetContext);

      return SafeArea(
        child: SizedBox(
          height: AppSize.sH320,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.pW12),
                child: Row(
                  children: [
                    /// Cancel
                    CupertinoButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.pW12,
                      ),
                      onPressed: () {
                        Navigator.of(sheetContext).pop();
                      },
                      child: Text(
                        localizations.cancelButtonLabel,
                        style:
                            const TextStyle().setBrandSurfaceColor.s14.medium,
                      ),
                    ),

                    const Spacer(),

                    /// Confirm
                    CupertinoButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.pW12,
                      ),
                      onPressed: () {
                        Navigator.of(sheetContext).pop(selectedDate);
                      },
                      child: Text(
                        localizations.okButtonLabel,
                        style: const TextStyle().setPrimaryColor.s16.medium,
                      ),
                    ),
                  ],
                ),
              ),

              Divider(height: AppSize.sH1, color: AppColors.border),

              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initial,
                  minimumDate: first,
                  maximumDate: last,
                  onDateTimeChanged: (value) {
                    selectedDate = value;
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// Formats DateTime for displaying in UI.
String formatAppDate(DateTime date, {String? format}) {
  return DateFormat(
    format ?? 'dd/MM/yyyy',
    Languages.currentLanguage.locale.languageCode,
  ).format(date);
}
