// `Go.context` is the app's global Navigator context — always mounted
// while the app is alive, so the cross-await BuildContext warning never
// applies to this file.
// ignore_for_file: use_build_context_synchronously

import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../config/language/languages.dart';
import '../../../config/language/locale_keys.g.dart';
import '../../../config/res/config_imports.dart';
import '../../navigation/navigator.dart';
import '../../shared/extensions/text_style_extensions.dart';

/// Picks a time adaptively:
///
/// Android -> Material TimePicker
/// iOS     -> Cupertino TimePicker
///
/// [controller] is optional.
/// Always returns the selected [TimeOfDay].
Future<TimeOfDay?> showCustomTimePicker({
  TextEditingController? controller,
  TimeOfDay? initialTime,
  String? timeFormat,
}) async {
  final BuildContext context = Go.context;

  final TimeOfDay initial =
      initialTime ??
          const TimeOfDay(
            hour: 9,
            minute: 0,
          );

  final TimeOfDay? picked = Platform.isIOS
      ? await _showCupertinoTimePicker(
    context: context,
    initialTime: initial,
  )
      : await _showMaterialTimePicker(
    context: context,
    initialTime: initial,
  );

  if (picked == null) {
    return null;
  }

  if (controller != null) {
    controller.text = formatAppTime(
      picked,
      format: timeFormat,
    );
  }

  return picked;
}

/// Material Time Picker - Android
Future<TimeOfDay?> _showMaterialTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
}) {
  return showTimePicker(
    context: context,
    initialTime: initialTime,

    barrierColor: AppColors.black.withValues(
      alpha: 0.45,
    ),

    cancelText: LocaleKeys.timePickerCancel,
    confirmText: LocaleKeys.timePickerConfirm,
    helpText: LocaleKeys.timePickerHelpText,

    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          timePickerTheme: TimePickerThemeData(
            // Dialog
            backgroundColor: AppColors.white,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppCircular.r20,
              ),
            ),

            // Clock
            dialBackgroundColor: AppColors.border.withValues(
              alpha: 0.25,
            ),

            dialHandColor: AppColors.brandSurface,

            dialTextColor: WidgetStateColor.resolveWith(
                  (states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.white;
                }

                return AppColors.black;
              },
            ),

            // Hour / Minute
            hourMinuteShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppCircular.r12,
              ),
            ),

            hourMinuteColor: WidgetStateColor.resolveWith(
                  (states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.primary.withValues(
                    alpha: 0.10,
                  );
                }

                return AppColors.border.withValues(
                  alpha: 0.25,
                );
              },
            ),

            hourMinuteTextColor: WidgetStateColor.resolveWith(
                  (states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.brandSurface;
                }

                return AppColors.black;
              },
            ),

            // AM / PM
            dayPeriodShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppCircular.r10,
              ),
            ),

            dayPeriodColor: WidgetStateColor.resolveWith(
                  (states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.brandSurface;
                }

                return AppColors.border.withValues(
                  alpha: 0.25,
                );
              },
            ),

            dayPeriodTextColor: WidgetStateColor.resolveWith(
                  (states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.white;
                }

                return AppColors.black;
              },
            ),

            // Cancel
            cancelButtonStyle: TextButton.styleFrom(
              foregroundColor: AppColors.black,
              backgroundColor: AppColors.border.withValues(
                alpha: 0.30,
              ),

              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.pW20,
                vertical: AppPadding.pH12,
              ),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppCircular.r10,
                ),
              ),

              textStyle:
              const TextStyle().setHintColor.s14.medium,
            ),

            // Confirm
            confirmButtonStyle: TextButton.styleFrom(
              foregroundColor: AppColors.white,
              backgroundColor: AppColors.brandSurface,

              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.pW20,
                vertical: AppPadding.pH12,
              ),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppCircular.r10,
                ),
              ),

              textStyle: const TextStyle().s14.medium,
            ),

            helpTextStyle:
            const TextStyle().setMainTextColor.s14.medium,
          ),
        ),
        child: child!,
      );
    },
  );
}

/// Cupertino Time Picker - iOS
Future<TimeOfDay?> _showCupertinoTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
}) {
  final DateTime now = DateTime.now();

  DateTime selectedTime = DateTime(
    now.year,
    now.month,
    now.day,
    initialTime.hour,
    initialTime.minute,
  );

  return showModalBottomSheet<TimeOfDay>(
    context: context,

    backgroundColor: AppColors.white,

    barrierColor: AppColors.black.withValues(
      alpha: 0.45,
    ),

    showDragHandle: true,
    isScrollControlled: true,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          AppCircular.r20,
        ),
      ),
    ),

    builder: (sheetContext) {
      return SafeArea(
        child: SizedBox(
          height: AppSize.sH320,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.pW16,
                ),
                child: Row(
                  children: [
                    /// Cancel
                    CupertinoButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.pW12,
                      ),
                      onPressed: () {
                        Navigator.of(
                          sheetContext,
                        ).pop();
                      },
                      child: Text(
                        LocaleKeys.timePickerCancel,
                        style:
                        const TextStyle()
                            .setHintColor
                            .s14
                            .medium,
                      ),
                    ),

                    const Spacer(),

                    /// Title
                    Text(
                      LocaleKeys.timePickerHelpText,
                      style:
                      const TextStyle()
                          .setMainTextColor
                          .s16
                          .medium,
                    ),

                    const Spacer(),

                    /// Confirm
                    CupertinoButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.pW12,
                      ),
                      onPressed: () {
                        Navigator.of(
                          sheetContext,
                        ).pop(
                          TimeOfDay.fromDateTime(
                            selectedTime,
                          ),
                        );
                      },
                      child: Text(
                        LocaleKeys.timePickerConfirm,
                        style:
                        const TextStyle()
                            .setPrimaryColor
                            .s14
                            .medium,
                      ),
                    ),
                  ],
                ),
              ),

              Divider(
                height: AppSize.sH1,
                color: AppColors.border,
              ),

              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,

                  initialDateTime: selectedTime,

                  use24hFormat: false,

                  onDateTimeChanged: (value) {
                    selectedTime = value;
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

/// Formats TimeOfDay for UI.
String formatAppTime(
    TimeOfDay time, {
      String? format,
    }) {
  final DateTime now = DateTime.now();

  final DateTime dateTime = DateTime(
    now.year,
    now.month,
    now.day,
    time.hour,
    time.minute,
  );

  return DateFormat(
    format ?? 'hh:mm a',
    Languages.currentLanguage.locale.languageCode,
  ).format(dateTime);
}