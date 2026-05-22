class ApiEndpoints {
  ApiEndpoints._();

  // Base URLs
  static const String baseUrl = 'https://api.example.com';
  static const String apiV1 = '$baseUrl/api/v1';

  // Auth
  static const String login = '$apiV1/auth/login';
  static const String register = '$apiV1/auth/register';
  static const String refreshToken = '$apiV1/auth/refresh-token';
  static const String logout = '$apiV1/auth/logout';
  static const String forgotPassword = '$apiV1/auth/forgot-password';
  static const String resetPassword = '$apiV1/auth/reset-password';

  // User
  static const String me = '$apiV1/users/me';
  static const String users = '$apiV1/users';
  static String userById(int id) => '$apiV1/users/$id';
  static const String updateProfile = '$apiV1/users/profile';

  // Generic resource paths — replace with real ones per project
  static const String products = '$apiV1/products';
  static String productById(int id) => '$apiV1/products/$id';
}
