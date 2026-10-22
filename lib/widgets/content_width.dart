import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Centres page content at the maximum content width and applies responsive
/// side gutters so nothing touches the viewport edges.
class ContentWidth extends StatelessWidget {
  const ContentWidth({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontal = width >= 900
        ? 48.0
        : width >= 600
        ? 32.0
        : 20.0;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kContentMaxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontal),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }
}
