import 'package:dio/dio.dart';

import '../../../config/language/languages.dart';

/// Attaches `Accept-Language` to every outbound request so the backend
/// returns localized strings (error messages, validation text, etc.).
///
/// Reads the current language from [Languages.currentLanguage] which is
/// fed by `easy_localization` via the `Go.navigatorKey` context. If the
/// navigator hasn't been built yet (very early bootstrap requests), we
/// simply skip the header instead of crashing.
class LocaleInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // Don't overwrite a header the caller explicitly set per-request.
    if (options.headers['Accept-Language'] == null) {
      try {
        options.headers['Accept-Language'] =
            Languages.currentLanguage.languageCode;
      } catch (_) {
        // Navigator/context not ready yet — leave the header off.
      }
    }
    handler.next(options);
  }
}
