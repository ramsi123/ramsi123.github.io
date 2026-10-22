import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ahmad_ramsi_portfolio/data/models.dart';
import 'package:ahmad_ramsi_portfolio/pages/home_page.dart';
import 'package:ahmad_ramsi_portfolio/pages/project_detail_page.dart';
import 'package:ahmad_ramsi_portfolio/router/app_router.dart';
import 'package:ahmad_ramsi_portfolio/theme/app_theme.dart';
import 'package:ahmad_ramsi_portfolio/widgets/app_icon_badge.dart';
import 'package:ahmad_ramsi_portfolio/widgets/play_store_button.dart';
import 'package:ahmad_ramsi_portfolio/widgets/qr_code_tile.dart';

const PublishedApp _minimalApp = PublishedApp(
  name: 'CMA Stock',
  slug: 'cma-stock',
  tagline: 'Inventory management',
  summary: 'An inventory management application.',
  playStoreUrl: 'https://bit.ly/CMAStockApp',
);

const PublishedApp _detailedApp = PublishedApp(
  name: 'FocusTime',
  slug: 'focustime',
  tagline: 'Focus and productivity',
  summary: 'A focus and productivity app.',
  playStoreUrl:
      'https://play.google.com/store/apps/details?id=com.ahmadramsi.focustime',
  tags: <String>['Flutter', 'Firebase'],
  features: <String>['Focus sessions', 'Daily summaries'],
  iconPath: 'assets/icons/focustime.png',
);

Future<void> _pumpDetail(WidgetTester tester, PublishedApp app) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: buildAppTheme(),
      home: ProjectDetailPage(app: app),
    ),
  );
}

void main() {
  testWidgets('omits Key features and Technology stack when empty', (
    tester,
  ) async {
    await _pumpDetail(tester, _minimalApp);

    expect(find.text('Key features'), findsNothing);
    expect(find.text('Technology stack'), findsNothing);
    expect(find.text('Google Play'), findsOneWidget);
  });

  testWidgets('QR encodes exactly the Google Play URL', (tester) async {
    await _pumpDetail(tester, _minimalApp);

    final play = tester.widget<PlayStoreButton>(find.byType(PlayStoreButton));
    final qr = tester.widget<QrCodeTile>(find.byType(QrCodeTile));
    expect(play.url, _minimalApp.playStoreUrl);
    expect(qr.url, _minimalApp.playStoreUrl);
  });

  testWidgets('shows a neutral placeholder when no screenshots exist', (
    tester,
  ) async {
    await _pumpDetail(tester, _minimalApp);

    expect(find.text('Screenshot coming soon'), findsOneWidget);
  });

  testWidgets('renders features and stack when supplied', (tester) async {
    await _pumpDetail(tester, _detailedApp);

    expect(find.text('Key features'), findsOneWidget);
    expect(find.text('Focus sessions'), findsOneWidget);
    expect(find.text('Technology stack'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.byType(AppIconBadge), findsOneWidget);
  });

  testWidgets('omits the app icon when none is supplied', (tester) async {
    await _pumpDetail(tester, _minimalApp);

    expect(find.byType(AppIconBadge), findsNothing);
  });

  testWidgets('the back link returns to the portfolio home', (tester) async {
    final router = buildRouter(initialLocation: '/projects/cma-stock');
    addTearDown(router.dispose);

    await tester.pumpWidget(
      MaterialApp.router(theme: buildAppTheme(), routerConfig: router),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Back to portfolio'));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
  });
}
