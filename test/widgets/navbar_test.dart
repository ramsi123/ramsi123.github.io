import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ahmad_ramsi_portfolio/router/app_routes.dart';
import 'package:ahmad_ramsi_portfolio/theme/app_theme.dart';
import 'package:ahmad_ramsi_portfolio/widgets/navbar.dart';

Future<void> _pumpNavbar(WidgetTester tester, List<String> taps) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: buildAppTheme(),
      home: Scaffold(body: Navbar(onNavigate: taps.add)),
    ),
  );
}

void main() {
  testWidgets('narrow layout collapses links into a menu', (tester) async {
    tester.view.physicalSize = const Size(390, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final taps = <String>[];
    await _pumpNavbar(tester, taps);

    expect(find.text('Published Apps'), findsNothing);

    await tester.tap(find.byTooltip('Open navigation'));
    await tester.pumpAndSettle();
    expect(find.text('Published Apps'), findsOneWidget);

    await tester.tap(find.text('Published Apps'));
    await tester.pumpAndSettle();

    expect(taps, <String>[AppRoutes.publishedAppsAnchor]);
    expect(find.text('Published Apps'), findsNothing);
  });

  testWidgets('wide layout shows inline links that report anchors', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final taps = <String>[];
    await _pumpNavbar(tester, taps);

    expect(find.byType(IconButton), findsNothing);
    expect(find.text('Contact'), findsOneWidget);

    await tester.tap(find.text('Contact'));
    await tester.pump();

    expect(taps, <String>[AppRoutes.contactAnchor]);
  });
}
