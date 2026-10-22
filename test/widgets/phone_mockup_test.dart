import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ahmad_ramsi_portfolio/theme/app_theme.dart';
import 'package:ahmad_ramsi_portfolio/widgets/phone_mockup.dart';

Future<void> _pumpMockup(WidgetTester tester, PhoneMockup mockup) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: buildAppTheme(),
      home: Scaffold(body: Center(child: mockup)),
    ),
  );
}

void main() {
  test('frame width is fixed at the 20:9 screen ratio', () {
    // Bezel (28 vertical, 14 horizontal) and the 2px border on each side are
    // removed before applying the screen ratio.
    expect(PhoneMockup.frameWidth(440), closeTo((440 - 32) * 0.45 + 18, 0.001));
    expect(PhoneMockup.frameWidth(440), closeTo(201.6, 0.001));
  });

  testWidgets('placeholder fills the fixed 20:9 screen', (tester) async {
    await _pumpMockup(tester, const PhoneMockup(height: 400));
    await tester.pumpAndSettle();

    final size = tester.getSize(find.byType(PhoneMockup));
    expect(size.width, closeTo((400 - 32) * 0.45 + 18, 0.01));
    expect(size.height, 400);
    expect(find.text('Screenshot coming soon'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('screenshot fills the fixed screen without relying on its size', (
    tester,
  ) async {
    await _pumpMockup(
      tester,
      const PhoneMockup(
        screenshotPath: 'assets/screenshots/cma-stock/1_dashboard.jpg',
        height: 440,
        semanticLabel: 'App screenshot 1',
      ),
    );
    await tester.pumpAndSettle();

    final image = tester.widget<Image>(find.byType(Image));
    expect(image.fit, BoxFit.cover);
    expect(image.semanticLabel, 'App screenshot 1');
    expect(tester.takeException(), isNull);
  });
}
