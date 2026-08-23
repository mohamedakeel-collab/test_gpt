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

  static DateTime? parseArabicDate(String? value) {

    if (value == null || value.isEmpty) {
      return null;
    }


    try {

      final months = {
        'يناير': 1,
        'فبراير': 2,
        'مارس': 3,
        'أبريل': 4,
        'مايو': 5,
        'يونيو': 6,
        'يوليو': 7,
        'أغسطس': 8,
        'سبتمبر': 9,
        'أكتوبر': 10,
        'نوفمبر': 11,
        'ديسمبر': 12,
      };


      final parts = value.split(' ');


      // الخميس, 13 أغسطس 2026
      final day = int.parse(
        parts[1],
      );


      final month = months[
      parts[2]
      ];


      final year = int.parse(
        parts[3],
      );


      if(month == null) {
        return null;
      }


      return DateTime(
        year,
        month,
        day,
      );


    } catch (_) {

      return null;

    }
  }
}
