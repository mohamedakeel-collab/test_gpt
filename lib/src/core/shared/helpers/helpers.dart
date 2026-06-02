import 'dart:io';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../../config/language/languages.dart';
import '../../../config/res/config_imports.dart';
import '../../widgets/custom_loading.dart';

class Helpers {
  /// Returns the FCM token via `awesome_notifications_fcm` (the rest of the
  /// notification stack is built on top of it, so we route through it too).
  static Future<String> getFcmToken() async {
    final token = await AwesomeNotificationsFcm().requestFirebaseAppToken();
    return token;
  }

  static void changeStatusbarColor({
    required Color statusBarColor,
    Brightness? statusBarIconBrightness,
  }) {
    return SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness ?? Brightness.dark,
        systemNavigationBarColor: AppColors.main,
      ),
    );
  }

  static void shareApp(String url) {
    CustomLoading.showFullScreenLoading();
    final ShareParams params = ShareParams(uri: Uri.parse(url));
    SharePlus.instance.share(params).whenComplete(() {
      CustomLoading.hideFullScreenLoading();
    });
  }

  static String getDeviceType() {
    if (Platform.isIOS) {
      return 'ios';
    } else {
      return 'android';
    }
  }

  /// Normalizes a Saudi mobile number to the canonical `9665XXXXXXXX` form.
  /// Handles inputs starting with `05`, `5`, `+966` and `966`.
  static String normalizeSaudiPhone(String input) {
    final digits = input.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.startsWith('966')) return digits;
    if (digits.startsWith('05')) return '966${digits.substring(1)}';
    if (digits.startsWith('5')) return '966$digits';
    return digits;
  }

  static String showByLang({required String ar, required String en}) {
    if (Languages.currentLanguage.languageCode == 'ar') {
      return ar;
    } else {
      return en;
    }
  }
}
