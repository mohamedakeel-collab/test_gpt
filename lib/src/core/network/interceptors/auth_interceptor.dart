import 'package:dio/dio.dart';

import '../api_endpoints.dart';
import '../auth/token_storage.dart';
import '../options/request_extra.dart';

/// Adds Bearer token to every request and refreshes it once when the
/// server replies with 401. If the refresh fails the original error
/// is propagated and the stored tokens are cleared (caller can react
/// by routing to the login screen on UnauthorizedException).
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    Dio? refreshClient,
    TokenStorage? storage,
    this.onAuthFailure,
  })  : _refreshClient = refreshClient ?? Dio(),
        _storage = storage ?? TokenStorage.instance;

  final Dio _refreshClient;
  final TokenStorage _storage;
  final Future<void> Function()? onAuthFailure;

  // Shared with BaseRemoteSource via RequestExtra so callers can opt out
  // of auth attachment per-request (e.g. login/register endpoints).
  static const _retriedFlag = RequestExtra.retried;
  static const _skipAuthFlag = RequestExtra.skipAuth;

  bool _refreshing = false;

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
    if (req.extra[_retriedFlag] == true || req.extra[_skipAuthFlag] == true) {
      return handler.next(response);
    }
    final hasRefresh =
        _storage.refreshToken != null && _storage.refreshToken!.isNotEmpty;
    if (!hasRefresh) return handler.next(response);

    try {
      _refreshing = true;
      final refreshed = await _refresh();
      _refreshing = false;
      if (!refreshed) {
        await _failAuth();
        return handler.next(response);
      }
      final retried = await _retry(req);
      return handler.resolve(retried);
    } catch (_) {
      _refreshing = false;
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
    final alreadyRetried = err.requestOptions.extra[_retriedFlag] == true;
    final hasRefresh =
        _storage.refreshToken != null && _storage.refreshToken!.isNotEmpty;

    if (!isUnauthorized || alreadyRetried || !hasRefresh) {
      return handler.next(err);
    }

    if (_refreshing) {
      // another request is already refreshing — wait briefly then retry once.
      try {
        await _waitForRefresh();
        final retried = await _retry(err.requestOptions);
        return handler.resolve(retried);
      } catch (_) {
        return handler.next(err);
      }
    }

    _refreshing = true;
    try {
      final refreshed = await _refresh();
      _refreshing = false;
      if (!refreshed) {
        await _failAuth();
        return handler.next(err);
      }
      final retried = await _retry(err.requestOptions);
      return handler.resolve(retried);
    } catch (e) {
      _refreshing = false;
      await _failAuth();
      return handler.next(err);
    }
  }

  Future<bool> _refresh() async {
    final refreshToken = _storage.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) return false;

    final res = await _refreshClient.post(
      ApiEndpoints.refreshToken,
      data: {'refresh_token': refreshToken},
      options: Options(
        extra: {_skipAuthFlag: true},
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
    req.extra[_retriedFlag] = true;
    req.headers['Authorization'] = 'Bearer ${_storage.accessToken}';
    final retryClient = Dio(BaseOptions(
      baseUrl: req.baseUrl,
      headers: req.headers,
      method: req.method,
      contentType: req.contentType,
      responseType: req.responseType,
      connectTimeout: req.connectTimeout,
      receiveTimeout: req.receiveTimeout,
      sendTimeout: req.sendTimeout,
      validateStatus: req.validateStatus,
    ));
    return retryClient.fetch(req);
  }

  Future<void> _failAuth() async {
    await _storage.clear();
    final cb = onAuthFailure;
    if (cb != null) await cb();
  }

  Future<void> _waitForRefresh() async {
    const tick = Duration(milliseconds: 100);
    var waited = Duration.zero;
    const maxWait = Duration(seconds: 8);
    while (_refreshing && waited < maxWait) {
      await Future.delayed(tick);
      waited += tick;
    }
  }
}
