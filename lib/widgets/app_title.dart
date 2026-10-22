import 'package:flutter/material.dart';

import 'app_icon_badge.dart';

/// Published-app title with its icon when one is supplied.
///
/// Wide layouts place the icon beside the name; narrow layouts stack it above
/// so the large display title keeps its full line width.
class AppTitle extends StatelessWidget {
  const AppTitle({super.key, required this.name, this.iconPath});

  final String name;
  final String? iconPath;

  static const double _inlineIconBreakpoint = 480;

  @override
  Widget build(BuildContext context) {
    final title = Text(name, style: Theme.of(context).textTheme.displayLarge);
    final iconPath = this.iconPath;
    if (iconPath == null) {
      return title;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < _inlineIconBreakpoint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppIconBadge(iconPath: iconPath, size: 56),
              const SizedBox(height: 16),
              title,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppIconBadge(iconPath: iconPath, size: 64),
            const SizedBox(width: 20),
            Expanded(child: title),
          ],
        );
      },
    );
  }
}
