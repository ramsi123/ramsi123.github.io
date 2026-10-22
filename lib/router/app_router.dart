import 'package:go_router/go_router.dart';

import '../data/projects_data.dart';
import '../pages/home_page.dart';
import '../pages/not_found_page.dart';
import '../pages/project_detail_page.dart';
import 'app_routes.dart';

/// Builds the app router.
///
/// [initialLocation] lets tests simulate a direct browser load; go_router
/// uses path-based URLs on web, matching `/projects/<slug>`.
///
/// [initialAnchor] carries a `/#anchor` fragment captured before the web
/// router normalizes the browser URL.
GoRouter buildRouter({
  String initialLocation = AppRoutes.home,
  String? initialAnchor,
}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => HomePage(initialAnchor: initialAnchor),
      ),
      GoRoute(
        path: AppRoutes.projectPattern,
        builder: (context, state) {
          final slug = state.pathParameters['slug'];
          final app = slug == null ? null : publishedAppBySlug(slug);
          if (app == null) {
            return const NotFoundPage();
          }
          return ProjectDetailPage(app: app);
        },
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
}
