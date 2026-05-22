import 'package:dio/dio.dart';

/// Retries idempotent failures with exponential backoff (2s, 4s, 8s).
/// Retries on: connect/receive timeout, connection errors, and the
/// transient status codes 408, 429, 500, 502, 503, 504.
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    this.maxRetries = 3,
    this.baseDelay = const Duration(seconds: 2),
  });

  final int maxRetries;
  final Duration baseDelay;

  static const _retryCountKey = '__retry_count';
  static const _retryableStatus = {408, 429, 500, 502, 503, 504};

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final code = response.statusCode ?? 0;
    if (!_retryableStatus.contains(code)) return handler.next(response);

    final req = response.requestOptions;
    final count = (req.extra[_retryCountKey] as int?) ?? 0;
    if (count >= maxRetries) return handler.next(response);

    final next = count + 1;
    req.extra[_retryCountKey] = next;
    await Future.delayed(baseDelay * (1 << count));

    try {
      final client = Dio();
      final res = await client.fetch(req);
      return handler.resolve(res);
    } catch (_) {
      return handler.next(response);
    }
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_isRetryable(err)) return handler.next(err);

    final count = (err.requestOptions.extra[_retryCountKey] as int?) ?? 0;
    if (count >= maxRetries) return handler.next(err);

    final next = count + 1;
    err.requestOptions.extra[_retryCountKey] = next;

    final delay = baseDelay * (1 << count); // 2s, 4s, 8s
    await Future.delayed(delay);

    try {
      final client = Dio();
      final res = await client.fetch(err.requestOptions);
      return handler.resolve(res);
    } on DioException catch (e) {
      return handler.next(e);
    } catch (e) {
      return handler.next(err);
    }
  }

  bool _isRetryable(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        final code = err.response?.statusCode ?? 0;
        return _retryableStatus.contains(code);
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return false;
    }
  }
}
