import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ahmad_ramsi_portfolio/app.dart';
import 'package:ahmad_ramsi_portfolio/widgets/qr_code_tile.dart';
import 'package:ahmad_ramsi_portfolio/widgets/qr_reveal.dart';

const List<Size> _viewports = <Size>[
  Size(390, 844), // phone
  Size(768, 1024), // tablet
  Size(1024, 768), // small laptop
  Size(1280, 900), // desktop
];

Future<void> _pumpHome(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const PortfolioApp());
  await tester.pumpAndSettle();
}

void main() {
  for (final size in _viewports) {
    final label = '${size.width.toInt()}x${size.height.toInt()}';
    testWidgets('home lays out without errors at $label', (tester) async {
      await _pumpHome(tester, size);

      expect(tester.takeException(), isNull);

      expect(find.text("Dhiya' Ulhaq Ahmad Ramsi"), findsOneWidget);
      expect(find.text('CMA Stock'), findsOneWidget);
      expect(find.text('FocusTime'), findsOneWidget);
      expect(find.text('Agrisight'), findsOneWidget);

      // A clickable Play Store link remains next to every QR trigger.
      expect(find.text('Google Play'), findsNWidgets(2));
      expect(find.byType(QrRevealButton), findsNWidgets(2));

      // The revealed QR code never shrinks below a scannable size.
      final reveal = find.byType(QrRevealButton).first;
      await tester.ensureVisible(reveal);
      await tester.pumpAndSettle();
      await tester.tap(reveal);
      await tester.pumpAndSettle();
      expect(
        tester.getSize(find.byType(QrCodeTile)).width,
        greaterThanOrEqualTo(112),
        reason: 'QR popup at $label',
      );
    });
  }
}
