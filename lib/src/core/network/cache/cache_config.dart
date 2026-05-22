import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

/// Wires `dio_cache_interceptor` to an in-memory `MemCacheStore`.
///
/// We dropped `dio_cache_interceptor_hive_store` (discontinued upstream and
/// incompatible with `hive_ce`). If you need cache to survive an app
/// restart, swap [_store] for a custom `CacheStore` backed by Hive CE,
/// sqflite, or any other persistent backend.
class CacheConfig {
  CacheConfig._();

  static MemCacheStore? _store;

  /// Caps the cache around ~5 MB (50 000 bytes per entry × 100 entries) — a
  /// reasonable default for screen-level GET responses. Tune per project.
  static const int _maxSize = 5 * 1024 * 1024;
  static const int _maxEntrySize = 50 * 1024;

  static Future<void> init() async {
    _store ??= MemCacheStore(
      maxSize: _maxSize,
      maxEntrySize: _maxEntrySize,
    );
  }

  static CacheStore get store {
    final s = _store;
    if (s == null) {
      throw StateError(
        'CacheConfig.init() must be called before accessing the cache store.',
      );
    }
    return s;
  }

  /// Default cache policy: try cache first then refresh from network.
  /// Override per request with `Options(extra: { ... CacheOptions.toExtra() })`.
  ///
  /// `hitCacheOnErrorExcept: const []` means: on any non-success status
  /// code (and network failures), fall back to the cached response.
  static CacheOptions get defaultOptions => CacheOptions(
        store: store,
        policy: CachePolicy.refreshForceCache,
        hitCacheOnErrorExcept: const [],
        maxStale: const Duration(days: 7),
        priority: CachePriority.normal,
        keyBuilder: CacheOptions.defaultCacheKeyBuilder,
        allowPostMethod: false,
      );
}
