import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
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
      AuthInterceptor(_dio),
      RetryInterceptor(_dio),
      AppCacheInterceptor.build(),
      if (kDebugMode) LoggingInterceptor.build(),
    ]);
  }

  static final DioClient _instance = DioClient._();
  factory DioClient() => _instance;

  late final Dio _dio;
  Dio get dio => _dio;

  /// Opt-in TLS certificate pinning (defense in depth — disabled by default).
  ///
  /// Pass the lowercase, colon-free **SHA-256 fingerprints of the server
  /// certificate(s)** you trust. Call ONCE during bootstrap, before the first
  /// request:
  ///
  /// ```dart
  /// DioClient().enableCertificatePinning(const [
  ///   'a1b2c3...', // primary cert
  ///   'd4e5f6...', // backup cert (rotate without an app update)
  /// ]);
  /// ```
  ///
  /// No-op on web (there is no [HttpClient] to configure there).
  void enableCertificatePinning(List<String> allowedSha256Fingerprints) {
    if (kIsWeb) return;
    final allowed =
        allowedSha256Fingerprints.map((e) => e.toLowerCase()).toSet();
    final adapter = _dio.httpClientAdapter;
    if (adapter is IOHttpClientAdapter) {
      adapter.createHttpClient = () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) {
          final fingerprint = sha256.convert(cert.der).toString();
          return allowed.contains(fingerprint);
        };
        return client;
      };
    }
  }

  // Guarantee a trailing slash so relative endpoints (`auth/login`) resolve
  // as `<base>/auth/login` instead of replacing the last path segment.
  static final String _normalizedBaseUrl = ApiEndpoints.baseUrl.endsWith('/')
      ? ApiEndpoints.baseUrl
      : '${ApiEndpoints.baseUrl}/';

  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: _normalizedBaseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 15),
    responseType: ResponseType.json,
    headers: const {
      //'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    // We treat 4xx ourselves through StatusCodeHandler / ResponseParser.
    // Only 5xx and lower-level failures travel through Dio's onError path.
    validateStatus: (status) => status != null && status < 500,
  );
}
