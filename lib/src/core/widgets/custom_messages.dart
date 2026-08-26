import 'package:flutter/material.dart';
import '../../config/language/locale_keys.g.dart';
import '../../config/res/config_imports.dart';
import '../shared/extensions/base_state.dart';
import '../shared/extensions/text_style_extensions.dart';
import '../navigation/navigator.dart';

class MessageUtils {
  static void showSnackBar({
    BuildContext? context,
    required BaseStatus baseStatus,
    required String message,
  }) {
    final messenger = ScaffoldMessenger.of(context ?? Go.context);
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),

      content: Text(message, style: const TextStyle().setWhiteColor.s11.medium),

      action: SnackBarAction(
        label: LocaleKeys.cancel,

        textColor: AppColors.white,

        onPressed: () {
          messenger.clearSnackBars();
        },
      ),

      backgroundColor: baseStatus == BaseStatus.error
          ? AppColors.error
          : AppColors.brandSurface,

      behavior: SnackBarBehavior.floating,

      elevation: 4,
    );

    messenger.showSnackBar(snackBar);
  }
}
