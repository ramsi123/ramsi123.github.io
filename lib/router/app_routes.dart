/// Route paths and in-page anchors shared by the router and widgets.
abstract final class AppRoutes {
  static const String home = '/';

  /// GoRouter pattern for a published-app detail page.
  static const String projectPattern = '/projects/:slug';

  static const String projectDetailPrefix = '/projects/';

  // Anchor ids used by the single-page navigation.
  static const String homeAnchor = 'home';
  static const String publishedAppsAnchor = 'published-apps';
  static const String developmentProjectsAnchor = 'development-projects';
  static const String experienceAnchor = 'experience';
  static const String aboutAnchor = 'about';
  static const String educationAnchor = 'education';
  static const String contactAnchor = 'contact';

  /// Internal path for a published app's detail page.
  static String projectDetail(String slug) => '$projectDetailPrefix$slug';
}
