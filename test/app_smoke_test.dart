import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ahmad_ramsi_portfolio/app.dart';
import 'package:ahmad_ramsi_portfolio/theme/app_theme.dart';
import 'package:ahmad_ramsi_portfolio/widgets/app_icon_badge.dart';
import 'package:ahmad_ramsi_portfolio/widgets/dev_project_card.dart';

void main() {
  testWidgets('home renders the portfolio content and theme', (tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    // Hero.
    expect(find.text("Dhiya' Ulhaq Ahmad Ramsi"), findsOneWidget);
    expect(find.textContaining('Flutter and Kotlin'), findsWidgets);

    // Navigation (desktop inline links).
    for (final label in <String>[
      'Published Apps',
      'Development Projects',
      'Experience',
      'About / Skills',
      'Contact',
    ]) {
      expect(find.text(label), findsWidgets, reason: label);
    }

    // Published apps and the separate development project.
    expect(find.text('CMA Stock'), findsOneWidget);
    expect(find.text('FocusTime'), findsOneWidget);
    expect(find.text('Agrisight'), findsOneWidget);

    // Both published apps show their owner-supplied icons.
    expect(find.byType(AppIconBadge), findsNWidgets(2));

    // Agrisight's confirmed repository URL renders a GitHub CTA.
    final agrisightCard = find.ancestor(
      of: find.text('Agrisight'),
      matching: find.byType(DevProjectCard),
    );
    expect(agrisightCard, findsOneWidget);
    expect(
      find.descendant(of: agrisightCard, matching: find.text('GitHub')),
      findsOneWidget,
    );

    // Navigation anchors present for every section.
    expect(find.text('Skills and focus'), findsOneWidget);
    expect(find.text('Education and certification'), findsOneWidget);
    expect(find.text('Get in touch'), findsOneWidget);

    final theme = Theme.of(tester.element(find.byType(Scaffold).first));
    expect(theme.scaffoldBackgroundColor, AppColors.background);
    expect(theme.textTheme.displayLarge?.fontFamily, 'PlusJakartaSans');
    expect(theme.textTheme.displayMedium?.fontFamily, 'PlusJakartaSans');
    expect(theme.textTheme.bodyMedium?.fontFamily, 'PlusJakartaSans');
    expect(theme.textTheme.labelSmall?.fontFamily, 'PlusJakartaSans');
  });
}
