enum NamedRoutes {
  splash('/'),
  login('/login'),
  home('/home');

  final String routeName;

  const NamedRoutes(this.routeName);
}
