import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ahmad_ramsi_portfolio/data/models.dart';
import 'package:ahmad_ramsi_portfolio/theme/app_theme.dart';
import 'package:ahmad_ramsi_portfolio/widgets/app_icon_badge.dart';
import 'package:ahmad_ramsi_portfolio/widgets/app_showcase_card.dart';
import 'package:ahmad_ramsi_portfolio/widgets/play_store_button.dart';
import 'package:ahmad_ramsi_portfolio/widgets/qr_code_tile.dart';
import 'package:ahmad_ramsi_portfolio/widgets/qr_reveal.dart';

const PublishedApp _fixture = PublishedApp(
  name: 'CMA Stock',
  slug: 'cma-stock',
  tagline: 'Inventory management',
  summary: 'An inventory management application.',
  tags: <String>['Flutter', 'Firebase'],
  iconPath: 'assets/icons/cma-stock.png',
  playStoreUrl: 'https://bit.ly/CMAStockApp',
);

Future<void> _pumpCard(WidgetTester tester, {required Size size}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MaterialApp(
      theme: buildAppTheme(),
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: const AppShowcaseCard(app: _fixture, ordinal: 1),
        ),
      ),
    ),
  );
}

Future<void> _hoverQr(WidgetTester tester) async {
  final reveal = find.byType(QrRevealButton);
  await tester.ensureVisible(reveal);
  await tester.pumpAndSettle();

  final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
  addTearDown(mouse.removePointer);
  await mouse.addPointer(location: Offset.zero);
  await tester.pump();
  await mouse.moveTo(tester.getCenter(reveal));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows editorial content, visit link, Play button and QR', (
    tester,
  ) async {
    await _pumpCard(tester, size: const Size(1200, 1200));

    expect(find.text('01'), findsOneWidget);
    expect(find.text('CMA Stock'), findsOneWidget);
    expect(find.byType(AppIconBadge), findsOneWidget);
    expect(find.text('Visit CMA Stock'), findsOneWidget);
    expect(find.text('Google Play'), findsOneWidget);
    expect(find.byType(QrRevealButton), findsOneWidget);
    expect(find.byType(QrCodeTile), findsNothing);

    final play = tester.widget<PlayStoreButton>(find.byType(PlayStoreButton));
    final qr = tester.widget<QrRevealButton>(find.byType(QrRevealButton));
    expect(play.url, _fixture.playStoreUrl);
    expect(qr.url, _fixture.playStoreUrl);
    expect(qr.url, _fixture.qrPayload);

    await _hoverQr(tester);

    final tile = find.byType(QrCodeTile);
    expect(tile, findsOneWidget);

    final semantics = tester.widget<Semantics>(
      find.descendant(of: tile, matching: find.byType(Semantics)),
    );
    expect(semantics.properties.label, 'Scan to open CMA Stock on Google Play');
  });

  testWidgets('omits tags and features when none are confirmed', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        home: const Scaffold(
          body: SingleChildScrollView(
            child: AppShowcaseCard(
              app: PublishedApp(
                name: 'FocusTime',
                slug: 'focustime',
                tagline: 'Focus and productivity',
                summary: 'A focus and productivity app.',
                playStoreUrl: 'https://example.com',
              ),
              ordinal: 2,
            ),
          ),
        ),
      ),
    );

    expect(find.text('FocusTime'), findsOneWidget);
    expect(find.text('unknown'), findsNothing);
    expect(find.text('Flutter'), findsNothing);
  });

  testWidgets('stacks without overflow on a phone-width viewport', (
    tester,
  ) async {
    await _pumpCard(tester, size: const Size(390, 2200));

    expect(tester.takeException(), isNull);
    expect(find.text('Visit CMA Stock'), findsOneWidget);
    expect(find.byType(QrRevealButton), findsOneWidget);

    await tester.ensureVisible(find.byType(QrRevealButton));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(QrRevealButton));
    await tester.pumpAndSettle();

    expect(find.byType(QrCodeTile), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tapAt(const Offset(5, 5));
    await tester.pumpAndSettle();
    expect(find.byType(QrCodeTile), findsNothing);
  });
}
