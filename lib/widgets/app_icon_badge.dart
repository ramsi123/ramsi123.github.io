import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Rounded, owner-supplied app icon.
///
/// The app name always appears next to this badge, so the image itself is
/// excluded from the semantics tree. If the asset ever goes missing, a neutral
/// glyph is shown instead of a broken image.
class AppIconBadge extends StatelessWidget {
  const AppIconBadge({super.key, required this.iconPath, this.size = 64});

  final String iconPath;
  final double size;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(size * 0.22);

    return Container(
      width: size,
      height: size,
      foregroundDecoration: BoxDecoration(
        borderRadius: radius,
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Image.asset(
          iconPath,
          width: size,
          height: size,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.medium,
          excludeFromSemantics: true,
          errorBuilder: (context, error, stackTrace) => ColoredBox(
            color: AppColors.surface,
            child: Icon(
              Icons.apps,
              size: size * 0.45,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
