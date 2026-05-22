import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_endpoints.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/cache_interceptor.dart';
import 'interceptors/locale_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

class DioClient {
  DioClient._() {
    _dio = Dio(_baseOptions);
    _dio.interceptors.addAll([
      // Order matters:
      //   1. LocaleInterceptor — sets Accept-Language first so subsequent
      //      retries / refresh-token call get the same header.
      //   2. AuthInterceptor   — Bearer token + 401 refresh-token cycle.
      //   3. RetryInterceptor  — retries idempotent failures.
      //   4. CacheInterceptor  — short-circuits with cached payloads.
      //   5. LoggingInterceptor (debug only) — last so it logs the final
      //      shape the network actually sees.
      LocaleInterceptor(),
      AuthInterceptor(),
      RetryInterceptor(),
      AppCacheInterceptor.build(),
      if (kDebugMode) LoggingInterceptor.build(),
    ]);
  }

  static final DioClient _instance = DioClient._();
  factory DioClient() => _instance;

  late final Dio _dio;
  Dio get dio => _dio;

  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 15),
    responseType: ResponseType.json,
    headers: const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    // We treat 4xx ourselves through StatusCodeHandler / ResponseParser.
    // Only 5xx and lower-level failures travel through Dio's onError path.
    validateStatus: (status) => status != null && status < 500,
  );
}
