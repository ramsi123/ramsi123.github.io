import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:ahmad_ramsi_portfolio/pages/not_found_page.dart';
import 'package:ahmad_ramsi_portfolio/pages/project_detail_page.dart';
import 'package:ahmad_ramsi_portfolio/router/app_router.dart';
import 'package:ahmad_ramsi_portfolio/theme/app_theme.dart';

Widget _appWith(GoRouter router) {
  return MaterialApp.router(theme: buildAppTheme(), routerConfig: router);
}

void main() {
  testWidgets('each published app opens its shared detail template', (
    tester,
  ) async {
    final router = buildRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(_appWith(router));
    await tester.pumpAndSettle();

    router.go('/projects/cma-stock');
    await tester.pumpAndSettle();
    expect(find.byType(ProjectDetailPage), findsOneWidget);
    expect(find.text('CMA Stock'), findsWidgets);
    expect(find.text('Google Play'), findsOneWidget);
    expect(find.text('Back to portfolio'), findsOneWidget);

    router.go('/projects/focustime');
    await tester.pumpAndSettle();
    expect(find.byType(ProjectDetailPage), findsOneWidget);
    expect(find.text('FocusTime'), findsWidgets);
    expect(find.text('Google Play'), findsOneWidget);
  });

  testWidgets('an unknown slug renders the not found page', (tester) async {
    final router = buildRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(_appWith(router));
    await tester.pumpAndSettle();

    router.go('/projects/does-not-exist');
    await tester.pumpAndSettle();

    expect(find.byType(NotFoundPage), findsOneWidget);
    expect(find.text('Page not found'), findsOneWidget);
  });

  testWidgets('an unknown path renders the not found page', (tester) async {
    final router = buildRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(_appWith(router));
    await tester.pumpAndSettle();

    router.go('/some/unknown/route');
    await tester.pumpAndSettle();

    expect(find.byType(NotFoundPage), findsOneWidget);
  });

  testWidgets('a direct load of a detail path works', (tester) async {
    final router = buildRouter(initialLocation: '/projects/cma-stock');
    addTearDown(router.dispose);

    await tester.pumpWidget(_appWith(router));
    await tester.pumpAndSettle();

    expect(find.byType(ProjectDetailPage), findsOneWidget);
    expect(find.text('CMA Stock'), findsWidgets);
  });

  testWidgets('a home anchor captured from the browser scrolls on load', (
    tester,
  ) async {
    final router = buildRouter(initialAnchor: 'experience');
    addTearDown(router.dispose);

    await tester.pumpWidget(_appWith(router));
    await tester.pumpAndSettle();

    final scrollable = tester.state<ScrollableState>(
      find.descendant(
        of: find.byType(SingleChildScrollView),
        matching: find.byType(Scrollable),
      ),
    );
    expect(scrollable.position.pixels, greaterThan(0));
  });
}
