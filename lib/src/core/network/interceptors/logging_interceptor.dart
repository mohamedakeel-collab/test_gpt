import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Pretty-prints requests / responses / errors in debug mode only.
class LoggingInterceptor {
  LoggingInterceptor._();

  static Interceptor build() {
    return PrettyDioLogger(
      requestHeader: kDebugMode,
      requestBody: kDebugMode,
      responseHeader: false,
      responseBody: kDebugMode,
      error: kDebugMode,
      compact: true,
      maxWidth: 120,
    );
  }
}
