import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../error/failures.dart';
import '../exceptions/app_exception.dart';
import 'status_code_handler.dart';

/// Turns a raw Dio response (or DioException) into an
/// `Either<Failure, T>`. The data-source layer never has to spell out
/// status-code logic — it just calls this.
class ResponseParser {
  ResponseParser._();

  static Either<Failure, T> parse<T>(
    Response response,
    T Function(dynamic json) fromJson,
  ) {
    final status = response.statusCode ?? 0;
    final data = _safeDecode(response.data);

    if (_looksLikeHtml(data) || _looksLikeHtml(response.data)) {
      return Left(ParseFailure(
        technical:
            'HTML response on $status from ${response.requestOptions.uri}',
      ));
    }

    if (status >= 200 && status < 300) {
      if (status == 204 || _isEmpty(data)) {
        try {
          return Right(fromJson(const <String, dynamic>{}));
        } catch (_) {
          return Right(fromJson(null));
        }
      }
      try {
        return Right(fromJson(data));
      } catch (e, st) {
        return Left(ParseFailure(technical: 'parse: $e\n$st'));
      }
    }

    return Left(
      StatusCodeHandler.handle(statusCode: status, responseData: data)
          .toFailure(),
    );
  }

  /// Maps a low-level [DioException] (timeout, no internet, cert error,
  /// or a 4xx/5xx with `validateStatus` having rejected it) to a [Failure].
  static Failure parseDioError(DioException e) {
    final res = e.response;
    final exception = switch (e.type) {
      DioExceptionType.connectionTimeout =>
        ConnectionTimeoutException(e.message),
      DioExceptionType.sendTimeout => SendTimeoutException(e.message),
      DioExceptionType.receiveTimeout => ReceiveTimeoutException(e.message),
      DioExceptionType.badCertificate => BadCertificateException(e.message),
      DioExceptionType.cancel => const CancelledRequest(),
      DioExceptionType.connectionError ||
      DioExceptionType.unknown =>
        _classifyConnectionError(e),
      DioExceptionType.badResponse => () {
          if (res == null) return const UnknownException('badResponse no res');
          final data = _safeDecode(res.data);
          if (_looksLikeHtml(data) || _looksLikeHtml(res.data)) {
            return const HtmlResponseException();
          }
          return StatusCodeHandler.handle(
            statusCode: res.statusCode ?? 0,
            responseData: data,
          );
        }(),
    };
    return exception.toFailure();
  }

  /// Catch-all for unexpected errors raised inside the data source
  /// (e.g. a `SocketException` that didn't come from Dio).
  static Failure parseUnknownError(Object e) {
    if (e is SocketException) return NetworkFailure(technical: e.message);
    return UnknownFailure(technical: e.toString());
  }

  // ── helpers ──────────────────────────────────────────────────────

  static AppException _classifyConnectionError(DioException e) {
    final inner = e.error;
    if (inner is SocketException) return NetworkException(inner.message);
    return NetworkException(e.message);
  }

  static dynamic _safeDecode(dynamic raw) {
    if (raw == null) return null;
    if (raw is Map || raw is List) return raw;
    if (raw is String) {
      final trimmed = raw.trim();
      if (trimmed.isEmpty) return null;
      try {
        return jsonDecode(trimmed);
      } catch (_) {
        return {'message': trimmed};
      }
    }
    return raw;
  }

  static bool _looksLikeHtml(dynamic data) {
    if (data is! String) return false;
    final lower = data.toLowerCase().trimLeft();
    return lower.startsWith('<!doctype html') ||
        lower.startsWith('<html') ||
        lower.contains('<head>') ||
        lower.contains('<body');
  }

  static bool _isEmpty(dynamic data) {
    if (data == null) return true;
    if (data is String) return data.trim().isEmpty;
    if (data is Map) return data.isEmpty;
    if (data is List) return data.isEmpty;
    return false;
  }
}
