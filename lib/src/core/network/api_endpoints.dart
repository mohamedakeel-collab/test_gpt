import '../../../flavors.dart';

class ApiEndpoints {
  ApiEndpoints._();

  /// Base URL for the current flavor (see [F.baseUrl]).
  ///
  /// MUST end with a trailing `/` so relative endpoints resolve correctly.
  /// `DioClient` prepends this base to every (relative) endpoint below.
  static String get baseUrl => F.baseUrl;

  // Endpoints are RELATIVE — DioClient already prepends [baseUrl].
  // No leading slash, no base prefix.

  // Auth
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String refreshToken = 'auth/refresh-token';
  static const String logout = 'auth/logout';
  static const String profile = 'auth/me';
  static const String setLanguage = 'auth/set-lang';
  static const String forgotPassword = 'auth/forgot-password';
  static const String resetPassword = 'auth/reset-password';

  // User
  static const String me = 'users/me';
  static const String users = 'users';
  static String userById(int id) => 'users/$id';
  static const String updateProfile = 'users/profile';

  // Generic resource paths — replace with real ones per project
  static const String products = 'products';
  static String productById(int id) => 'products/$id';

  // Home dashboard
  static const String home = 'home';

  // Notifications
  static const String notifications = 'notifications';

  // Attendance
  static const String myAttendance = 'me/attendance';
  static const String checkIn = 'attendance/check-in';
  static const String checkOut = 'attendance/check-out';

  // Leave requests
  static const String leaveRequests = 'leave-requests';
  static const String storeLeaveRequest = 'leave-requests/store';
  static const String myLeaveRequests = 'me/leave-requests';
  static String leaveRequestDetails(int id) => 'leave-requests/$id';
  static String updateLeaveRequest(int id) => 'leave-requests/$id';
  static String deleteLeaveRequest(int id) => 'leave-requests/$id';
}
