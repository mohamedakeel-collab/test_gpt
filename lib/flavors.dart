enum Flavor {
  user,
  provider,
}

class F {
  /// Current flavor, set once at startup by `bootstrap(flavor)`.
  static late final Flavor appFlavor;

  /// Flavor name, e.g. "user" / "provider".
  static String get name => appFlavor.name;

  /// User-facing app title for the current flavor.
  static String get title {
    switch (appFlavor) {
      case Flavor.user:
        return 'User Tag';
      case Flavor.provider:
        return 'Provider Tag';
    }
  }

  /// API base URL for the current flavor.
  ///
  /// Can be overridden per build with `--dart-define=API_BASE_URL=...`.
  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.user:
        return String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'https://attendance.syt-inf.com/api',
        );
      case Flavor.provider:
        return String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'https://attendance.syt-inf.com/api',
        );
    }
  }
}
