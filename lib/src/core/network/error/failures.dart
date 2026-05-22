import 'package:equatable/equatable.dart';

import '../../../config/language/locale_keys.g.dart';
import '../exceptions/app_exception.dart';

/// Domain-layer error type.
///
/// **Every** repository, use-case, and cubit in the app speaks in
/// `Either<Failure, T>`. Low-level exceptions (Dio, parsing, sockets…)
/// are mapped into one of the subtypes below at the data-source boundary
/// so the rest of the codebase only deals with a closed, well-typed
/// error model — no `try/catch` past the data layer.
///
/// Localization
///   [userMessage] is an **abstract getter**, so each subtype maps itself
///   to a key from [LocaleKeys] and the string is resolved against the
///   current locale at read time. Switching language at runtime updates
///   any rendered failure instantly — no rebuild of the Failure object.
///   A few subtypes accept an explicit override (e.g. server-returned
///   validation message) which trumps the default key.
sealed class Failure extends Equatable {
  /// Localized message safe to surface in the UI. Resolved against the
  /// active locale every time it is read.
  String get userMessage;

  /// Developer-facing context (stack-trace excerpt, raw error message, …).
  /// Never displayed to the user.
  final String? technical;

  /// HTTP status if the failure came from a server response.
  final int? statusCode;

  /// Whether retrying makes sense (drives the "إعادة المحاولة" button).
  final bool retryable;

  const Failure({
    this.technical,
    this.statusCode,
    this.retryable = false,
  });

  // Compared by `runtimeType` instead of `userMessage` so two instances of
  // the same Failure are equal regardless of the active locale.
  @override
  List<Object?> get props => [runtimeType, technical, statusCode, retryable];

  @override
  String toString() =>
      '$runtimeType(status: $statusCode, retryable: $retryable'
      '${technical != null ? ", tech: $technical" : ""})';
}

// ── Connectivity / transport ────────────────────────────────────────

final class NetworkFailure extends Failure {
  const NetworkFailure({super.technical}) : super(retryable: true);

  @override
  String get userMessage => LocaleKeys.failureNoInternet;
}

final class TimeoutFailure extends Failure {
  const TimeoutFailure({super.technical}) : super(retryable: true);

  @override
  String get userMessage => LocaleKeys.failureTimeout;
}

final class BadCertificateFailure extends Failure {
  const BadCertificateFailure({super.technical});

  @override
  String get userMessage => LocaleKeys.failureBadCertificate;
}

// ── Auth ────────────────────────────────────────────────────────────

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.technical}) : super(statusCode: 401);

  @override
  String get userMessage => LocaleKeys.failureUnauthorized;
}

final class PermissionFailure extends Failure {
  /// Optional server-supplied message that overrides the default key.
  final String? customMessage;

  const PermissionFailure({this.customMessage, super.technical})
      : super(statusCode: 403);

  @override
  String get userMessage =>
      customMessage ?? LocaleKeys.failurePermissionDenied;

  @override
  List<Object?> get props => [...super.props, customMessage];
}

// ── Resource state ──────────────────────────────────────────────────

final class NotFoundFailure extends Failure {
  const NotFoundFailure({super.technical}) : super(statusCode: 404);

  @override
  String get userMessage => LocaleKeys.failureNotFound;
}

final class ConflictFailure extends Failure {
  final String? customMessage;

  const ConflictFailure({this.customMessage, super.technical})
      : super(statusCode: 409);

  @override
  String get userMessage => customMessage ?? LocaleKeys.failureConflict;

  @override
  List<Object?> get props => [...super.props, customMessage];
}

final class PayloadTooLargeFailure extends Failure {
  const PayloadTooLargeFailure({super.technical}) : super(statusCode: 413);

  @override
  String get userMessage => LocaleKeys.failurePayloadTooLarge;
}

// ── Client-side validation ──────────────────────────────────────────

final class ValidationFailure extends Failure {
  /// Per-field error map sent back by the server (Laravel/422-style).
  final Map<String, List<String>>? fields;

  /// Optional server-supplied message (e.g. "Email is already in use").
  final String? customMessage;

  const ValidationFailure({
    this.customMessage,
    this.fields,
    super.technical,
    int? statusCode,
  }) : super(statusCode: statusCode ?? 422);

  @override
  String get userMessage => customMessage ?? LocaleKeys.failureValidation;

  @override
  List<Object?> get props => [...super.props, customMessage, fields];
}

// ── Rate limiting / server ──────────────────────────────────────────

final class RateLimitFailure extends Failure {
  final Duration? retryAfter;
  const RateLimitFailure({this.retryAfter, super.technical})
      : super(statusCode: 429, retryable: true);

  @override
  String get userMessage => LocaleKeys.failureRateLimit;

  @override
  List<Object?> get props => [...super.props, retryAfter];
}

final class ServerFailure extends Failure {
  final String? customMessage;

  const ServerFailure({
    this.customMessage,
    super.statusCode,
    super.technical,
  }) : super(retryable: true);

  @override
  String get userMessage => customMessage ?? LocaleKeys.failureServer;

  @override
  List<Object?> get props => [...super.props, customMessage];
}

final class MaintenanceFailure extends Failure {
  final Duration? retryAfter;
  const MaintenanceFailure({this.retryAfter, super.technical})
      : super(statusCode: 503, retryable: true);

  @override
  String get userMessage => LocaleKeys.failureMaintenance;

  @override
  List<Object?> get props => [...super.props, retryAfter];
}

// ── Cancellation / parsing / unknown ────────────────────────────────

/// Emitted by [BaseRemoteSource] when a newer call cancels the in-flight
/// token. The UI **must** treat this as a no-op (don't show an error).
final class CancelledFailure extends Failure {
  const CancelledFailure();

  // Intentionally empty — the UI should silently keep its previous state
  // (e.g. show the old list while a new search request flies).
  @override
  String get userMessage => '';
}

final class ParseFailure extends Failure {
  const ParseFailure({super.technical});

  @override
  String get userMessage => LocaleKeys.failureParse;
}

final class UnknownFailure extends Failure {
  const UnknownFailure({super.technical});

  @override
  String get userMessage => LocaleKeys.failureUnknown;
}

// ════════════════════════════════════════════════════════════════════
// AppException → Failure mapping
// ════════════════════════════════════════════════════════════════════

/// Translates the low-level transport [AppException] (raised inside
/// `ResponseParser` / interceptors) into a domain-layer [Failure].
///
/// Server-supplied messages on the underlying exception are forwarded as
/// `customMessage` on the failure types that support overrides — so an
/// API error like `{"message": "Email already in use"}` reaches the UI
/// verbatim instead of being replaced by the localized default.
extension AppExceptionToFailure on AppException {
  Failure toFailure() {
    final tech = technicalInfo;
    final exception = this;
    if (exception is NetworkException) return NetworkFailure(technical: tech);
    if (exception is ConnectionTimeoutException ||
        exception is SendTimeoutException ||
        exception is ReceiveTimeoutException ||
        exception is GatewayTimeoutException) {
      return TimeoutFailure(technical: tech);
    }
    if (exception is BadCertificateException) {
      return BadCertificateFailure(technical: tech);
    }
    if (exception is UnauthorizedException) {
      return UnauthorizedFailure(technical: tech);
    }
    if (exception is PermissionException) {
      return PermissionFailure(customMessage: userMessage, technical: tech);
    }
    if (exception is NotFoundException) return NotFoundFailure(technical: tech);
    if (exception is ConflictException) {
      return ConflictFailure(customMessage: userMessage, technical: tech);
    }
    if (exception is PayloadTooLargeException) {
      return PayloadTooLargeFailure(technical: tech);
    }
    if (exception is ValidationException) {
      return ValidationFailure(
        customMessage: userMessage,
        fields: exception.fields,
        technical: tech,
        statusCode: exception.statusCode,
      );
    }
    if (exception is UnprocessableException) {
      return ValidationFailure(
        customMessage: userMessage,
        fields: exception.errors,
        technical: tech,
        statusCode: exception.statusCode,
      );
    }
    if (exception is RateLimitException) {
      return RateLimitFailure(
        retryAfter: exception.retryAfter,
        technical: tech,
      );
    }
    if (exception is MaintenanceException) {
      return MaintenanceFailure(
        retryAfter: exception.retryAfter,
        technical: tech,
      );
    }
    if (exception is InternalServerException ||
        exception is BadGatewayException ||
        exception is ServerException) {
      return ServerFailure(
        customMessage: userMessage,
        statusCode: statusCode,
        technical: tech,
      );
    }
    if (exception is CancelledRequest) return const CancelledFailure();
    if (exception is ParseException || exception is HtmlResponseException) {
      return ParseFailure(technical: tech);
    }
    return UnknownFailure(technical: tech);
  }
}
