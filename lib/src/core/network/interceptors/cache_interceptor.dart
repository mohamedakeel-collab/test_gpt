import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import '../cache/cache_config.dart';

/// Thin wrapper around the Hive-backed DioCacheInterceptor so the
/// rest of the code never imports the package directly.
class AppCacheInterceptor {
  AppCacheInterceptor._();

  static Interceptor build() {
    return DioCacheInterceptor(options: CacheConfig.defaultOptions);
  }
}
