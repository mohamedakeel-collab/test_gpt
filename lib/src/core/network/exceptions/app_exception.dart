sealed class AppException implements Exception {
  final String userMessage;
  final String? technicalInfo;
  final int? statusCode;
  final bool retryable;

  const AppException({
    required this.userMessage,
    this.technicalInfo,
    this.statusCode,
    this.retryable = false,
  });

  @override
  String toString() =>
      '$runtimeType(status: $statusCode, retryable: $retryable, msg: $userMessage'
      '${technicalInfo != null ? ", tech: $technicalInfo" : ""})';
}

final class NetworkException extends AppException {
  const NetworkException([String? tech])
      : super(
          userMessage: 'لا يوجد اتصال بالإنترنت، تحقق من الشبكة',
          technicalInfo: tech,
          retryable: true,
        );
}

final class ConnectionTimeoutException extends AppException {
  const ConnectionTimeoutException([String? tech])
      : super(
          userMessage: 'انتهت مهلة الاتصال، حاول مرة أخرى',
          technicalInfo: tech,
          retryable: true,
        );
}

final class SendTimeoutException extends AppException {
  const SendTimeoutException([String? tech])
      : super(
          userMessage: 'انتهت مهلة الإرسال، حاول مرة أخرى',
          technicalInfo: tech,
          retryable: true,
        );
}

final class ReceiveTimeoutException extends AppException {
  const ReceiveTimeoutException([String? tech])
      : super(
          userMessage: 'انتهت مهلة استقبال البيانات، حاول مرة أخرى',
          technicalInfo: tech,
          retryable: true,
        );
}

final class BadCertificateException extends AppException {
  const BadCertificateException([String? tech])
      : super(
          userMessage: 'فشل التحقق من شهادة الأمان',
          technicalInfo: tech,
          retryable: false,
        );
}

final class UnauthorizedException extends AppException {
  const UnauthorizedException([String? tech])
      : super(
          userMessage: 'انتهت جلستك، يرجى تسجيل الدخول',
          technicalInfo: tech,
          statusCode: 401,
          retryable: false,
        );
}

final class PermissionException extends AppException {
  PermissionException([String? msg, String? tech])
      : super(
          userMessage: msg ?? 'ليس لديك صلاحية لهذا الإجراء',
          technicalInfo: tech,
          statusCode: 403,
          retryable: false,
        );
}

final class ValidationException extends AppException {
  final Map<String, List<String>>? fields;
  ValidationException(
    String? msg, {
    this.fields,
    String? tech,
  }) : super(
          userMessage: msg ?? 'البيانات المرسلة غير صحيحة',
          technicalInfo: tech,
          statusCode: 400,
          retryable: false,
        );
}

final class UnprocessableException extends AppException {
  final Map<String, List<String>>? errors;
  UnprocessableException(
    String? msg, {
    this.errors,
    String? tech,
  }) : super(
          userMessage: msg ?? 'خطأ في التحقق من البيانات',
          technicalInfo: tech,
          statusCode: 422,
          retryable: false,
        );
}

final class NotFoundException extends AppException {
  const NotFoundException([String? tech])
      : super(
          userMessage: 'البيانات غير موجودة',
          technicalInfo: tech,
          statusCode: 404,
          retryable: false,
        );
}

final class ConflictException extends AppException {
  ConflictException([String? msg, String? tech])
      : super(
          userMessage: msg ?? 'البيانات موجودة بالفعل',
          technicalInfo: tech,
          statusCode: 409,
          retryable: false,
        );
}

final class RateLimitException extends AppException {
  final Duration? retryAfter;
  RateLimitException({this.retryAfter, String? tech})
      : super(
          userMessage: 'تجاوزت الحد المسموح، انتظر قليلاً',
          technicalInfo: tech,
          statusCode: 429,
          retryable: true,
        );
}

final class PayloadTooLargeException extends AppException {
  const PayloadTooLargeException([String? tech])
      : super(
          userMessage: 'حجم الملف كبير جداً',
          technicalInfo: tech,
          statusCode: 413,
          retryable: false,
        );
}

final class InternalServerException extends AppException {
  const InternalServerException([String? tech])
      : super(
          userMessage: 'حدث خطأ في الخادم، نعمل على إصلاحه',
          technicalInfo: tech,
          statusCode: 500,
          retryable: true,
        );
}

final class BadGatewayException extends AppException {
  const BadGatewayException([String? tech])
      : super(
          userMessage: 'خطأ في الاتصال بالخادم، حاول مرة أخرى',
          technicalInfo: tech,
          statusCode: 502,
          retryable: true,
        );
}

final class MaintenanceException extends AppException {
  final Duration? retryAfter;
  MaintenanceException({this.retryAfter, String? tech})
      : super(
          userMessage: 'الخدمة تحت الصيانة مؤقتاً',
          technicalInfo: tech,
          statusCode: 503,
          retryable: true,
        );
}

final class GatewayTimeoutException extends AppException {
  const GatewayTimeoutException([String? tech])
      : super(
          userMessage: 'انتهت مهلة الخادم',
          technicalInfo: tech,
          statusCode: 504,
          retryable: true,
        );
}

final class ServerException extends AppException {
  ServerException(String? msg, {super.statusCode, String? tech})
      : super(
          userMessage: msg ?? 'خطأ غير متوقع',
          technicalInfo: tech,
          retryable: false,
        );
}

final class HtmlResponseException extends AppException {
  const HtmlResponseException([String? tech])
      : super(
          userMessage: 'حدث خطأ غير متوقع',
          technicalInfo: tech,
          retryable: false,
        );
}

final class ParseException extends AppException {
  const ParseException([String? tech])
      : super(
          userMessage: 'فشل في قراءة البيانات',
          technicalInfo: tech,
          retryable: false,
        );
}

final class CancelledRequest extends AppException {
  const CancelledRequest()
      : super(
          userMessage: '',
          retryable: false,
        );
}

final class UnknownException extends AppException {
  const UnknownException([String? tech])
      : super(
          userMessage: 'حدث خطأ غير متوقع',
          technicalInfo: tech,
          retryable: false,
        );
}
