part of '../imports/login_imports.dart';

/// View-level state for the login screen that doesn't belong in the cubit:
///   - the email/phone field controller
///   - the password field controller
///
/// Pattern
///   - Create in `initState`.
///   - Always call `dispose()` from the screen's `dispose`.
///   - The cubit owns server state (`AsyncState<LoginEntity>`); this owns all
///     ephemeral form state.
class LoginViewController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// The `login` key on the wire is "email or phone" — trimmed verbatim.
  String get login => emailController.text.trim();
  String get password => passwordController.text;

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
