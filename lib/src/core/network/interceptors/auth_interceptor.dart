import 'dart:async';

import 'package:dio/dio.dart';

import '../api_endpoints.dart';
import '../auth/token_storage.dart';
import '../options/request_extra.dart';

/// Adds Bearer token to every request and refreshes it once when the
/// server replies with 401. If the refresh fails the original error
/// is propagated and the stored tokens are cleared (caller can react
/// by routing to the login screen on UnauthorizedException).
///
/// Concurrent 401s share a single in-flight refresh via a [Completer] — no
/// busy-wait polling — so the refresh endpoint is hit at most once even when
/// a burst of requests fails together.
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor(
    this._dio, {
    TokenStorage? storage,
    this.onAuthFailure,
  }) : _storage = storage ?? TokenStorage.instance;

  /// Shared client used for both the refresh-token call and the retry of the
  /// original request. Reusing it (instead of `Dio()`) means those calls go
  /// through the same interceptor chain (locale, logging, …) and never leak.
  final Dio _dio;
  final TokenStorage _storage;
  final Future<void> Function()? onAuthFailure;

  // Shared with BaseRemoteSource via RequestExtra so callers can opt out
  // of auth attachment per-request (e.g. login/register endpoints).
  static const _retriedFlag = RequestExtra.retried;
  static const _skipAuthFlag = RequestExtra.skipAuth;

  /// In-flight refresh, shared by all callers that hit a 401 at once.
  Completer<bool>? _refreshCompleter;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final skip = options.extra[_skipAuthFlag] == true;
    if (!skip && _storage.hasAccessToken) {
      options.headers['Authorization'] = 'Bearer ${_storage.accessToken}';
    }
    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    // Since DioClient uses validateStatus < 500, a 401 lands here as a
    // normal response. Treat it the same way we would in onError.
    if (response.statusCode != 401) return handler.next(response);

    final req = response.requestOptions;
    if (!_shouldAttemptRefresh(req)) return handler.next(response);

    try {
      final refreshed = await _refresh();
      if (!refreshed) {
        await _failAuth();
        return handler.next(response);
      }
      final retried = await _retry(req);
      return handler.resolve(retried);
    } catch (_) {
      await _failAuth();
      return handler.next(response);
    }
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final isUnauthorized = err.response?.statusCode == 401;
    if (!isUnauthorized || !_shouldAttemptRefresh(err.requestOptions)) {
      return handler.next(err);
    }

    try {
      final refreshed = await _refresh();
      if (!refreshed) {
        await _failAuth();
        return handler.next(err);
      }
      final retried = await _retry(err.requestOptions);
      return handler.resolve(retried);
    } catch (_) {
      await _failAuth();
      return handler.next(err);
    }
  }

  bool _shouldAttemptRefresh(RequestOptions req) {
    if (req.extra[_retriedFlag] == true) return false;
    if (req.extra[_skipAuthFlag] == true) return false;
    final refresh = _storage.refreshToken;
    return refresh != null && refresh.isNotEmpty;
  }

  /// Single-flight refresh: the first caller performs the actual refresh,
  /// every concurrent caller awaits the same [Completer].
  Future<bool> _refresh() {
    final inFlight = _refreshCompleter;
    if (inFlight != null) return inFlight.future;

    final completer = _refreshCompleter = Completer<bool>();
    _doRefresh().then((ok) {
      completer.complete(ok);
    }).catchError((Object e, StackTrace st) {
      completer.completeError(e, st);
    }).whenComplete(() {
      _refreshCompleter = null;
    });
    return completer.future;
  }

  Future<bool> _doRefresh() async {
    final refreshToken = _storage.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) return false;

    final res = await _dio.post(
      ApiEndpoints.refreshToken,
      data: {'refresh_token': refreshToken},
      options: Options(
        // Skip auth attachment + the 401 retry cycle for the refresh call
        // itself, otherwise a failing refresh would recurse.
        extra: {_skipAuthFlag: true, _retriedFlag: true},
        validateStatus: (s) => s != null && s < 500,
      ),
    );
    if (res.statusCode != 200 || res.data is! Map) return false;
    final data = res.data as Map;
    final access = data['access_token'] ?? data['token'];
    final refresh = data['refresh_token'];
    if (access is! String || access.isEmpty) return false;
    await _storage.save(
      access: access,
      refresh: refresh is String ? refresh : null,
    );
    return true;
  }

  Future<Response<dynamic>> _retry(RequestOptions req) {
    // Mark so a second 401 on the replayed request doesn't recurse, then
    // re-issue through the shared client (full interceptor chain, no leak).
    req.extra[_retriedFlag] = true;
    req.headers['Authorization'] = 'Bearer ${_storage.accessToken}';
    return _dio.fetch(req);
  }

  Future<void> _failAuth() async {
    await _storage.clear();
    final cb = onAuthFailure;
    if (cb != null) await cb();
  }
}
