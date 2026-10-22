import 'models.dart';

/// Single source of truth for the published apps shown on the portfolio.
///
/// Adding a new published app means adding one entry here (and optionally
/// dropping screenshots into `assets/screenshots/<slug>/`) — the showcase and
/// detail page layouts are fully data-driven.
const List<PublishedApp> publishedApps = <PublishedApp>[
  PublishedApp(
    name: 'CMA Stock',
    slug: 'cma-stock',
    tagline: 'Inventory management',
    summary:
        'An inventory management application for CV Cahaya Mulya Abadi, '
        'including stock management, notifications, and background tasks.',
    tags: <String>[
      'Flutter',
      'Firebase',
      'Supabase',
      'Lottie',
      'Local Notifications',
      'Flutter Background Service',
    ],
    features: <String>['Stock management', 'Notifications', 'Background tasks'],
    screenshots: <String>[
      'assets/screenshots/cma-stock/1_dashboard.jpg',
      'assets/screenshots/cma-stock/2_listofstock.jpg',
      'assets/screenshots/cma-stock/3_requeststock.jpg',
    ],
    iconPath: 'assets/icons/cma-stock.png',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.ahmadramsi.cahaya_mulya_abadi',
  ),
  PublishedApp(
    name: 'FocusTime',
    slug: 'focustime',
    tagline: 'Focus and productivity',
    summary:
        'A local-first Pomodoro focus app with a customizable timer, daily '
        'task checklist, and streak and session analytics — fully offline, '
        'ad-free, and requiring no account.',
    // Owner-confirmed technology stack.
    tags: <String>['Flutter', 'Riverpod'],
    // Owner-confirmed key features.
    features: <String>[
      'Customizable Pomodoro focus timer',
      'Background notification shade controls',
      'Integrated daily task checklist',
      'Streak and session analytics',
      'Fully offline and ad-free, with no registration or cloud data tracking',
    ],
    screenshots: <String>[
      'assets/screenshots/focustime/app_screenshot.png',
      'assets/screenshots/focustime/tasks_screenshot.png',
      'assets/screenshots/focustime/analytics_screenshot.png',
      'assets/screenshots/focustime/break_screenshot.png',
    ],
    iconPath: 'assets/icons/focustime.png',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.ahmadramsi.focustime',
  ),
];

/// Development/GitHub projects, shown separately from the published apps.
const List<DevelopmentProject> developmentProjects = <DevelopmentProject>[
  DevelopmentProject(
    name: 'Agrisight',
    summary:
        'An Android project that aims to identify soil types and recommend '
        'crops from user-uploaded photos using computer vision.',
    tags: <String>[
      'Kotlin',
      'Jetpack Compose',
      'MVVM',
      'Firebase',
      'Retrofit',
      'OkHttp',
      'Coil',
      'CameraX',
      'TensorFlow Lite',
    ],
    // Owner-confirmed public repository; the GitHub button renders only
    // when this URL is present.
    githubUrl: 'https://github.com/ramsi123/Agrisight',
  ),
];

/// Returns the published app for [slug], or null when no such app exists.
PublishedApp? publishedAppBySlug(String slug) {
  for (final app in publishedApps) {
    if (app.slug == slug) {
      return app;
    }
  }
  return null;
}
