import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// A Pixel 4-style phone frame showing a real app screenshot, or a clearly
/// neutral placeholder while authentic screenshots are unavailable.
///
/// The screen has a fixed 20:9 ratio — matching the Play Store screenshot
/// captures — so every phone on the site is identical. Screenshots fill the
/// screen; a capture with another ratio is cropped slightly rather than
/// changing the phone's shape.
class PhoneMockup extends StatelessWidget {
  const PhoneMockup({
    super.key,
    this.screenshotPath,
    this.height = 460,
    this.semanticLabel,
  });

  final String? screenshotPath;
  final double height;

  /// Accessibility label announced for a real screenshot.
  final String? semanticLabel;

  /// Fixed screen ratio (20:9, e.g. 1080 x 2400).
  static const double screenAspect = 9 / 20;

  /// Pixel 4 bezel insets; the top inset is the forehead housing the camera.
  static const EdgeInsets bezel = EdgeInsets.fromLTRB(7, 16, 7, 12);

  static const double _borderWidth = 2;

  /// Frame width for a frame [height] with the fixed 20:9 screen.
  ///
  /// The screen is inset by both the bezel and the frame's border, so the
  /// screen ends up with exactly [screenAspect] inside the frame box.
  static double frameWidth(double height) {
    final screenHeight = height - bezel.vertical - _borderWidth * 2;
    return screenHeight * screenAspect + bezel.horizontal + _borderWidth * 2;
  }

  @override
  Widget build(BuildContext context) {
    final path = screenshotPath;

    return SizedBox(
      width: frameWidth(height),
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(36),
          border: Border.all(color: AppColors.border, width: _borderWidth),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 30,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: bezel,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: path == null
                      ? const _ScreenshotPlaceholder()
                      : ColoredBox(
                          color: Colors.black,
                          child: Image.asset(
                            path,
                            fit: BoxFit.cover,
                            semanticLabel: semanticLabel ?? 'App screenshot',
                            errorBuilder: (context, error, stackTrace) =>
                                const _ScreenshotPlaceholder(),
                          ),
                        ),
                ),
              ),
            ),
            Positioned(
              top: 5,
              left: 13,
              child: Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScreenshotPlaceholder extends StatelessWidget {
  const _ScreenshotPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: 'Screenshot coming soon',
      child: Container(
        color: const Color(0xFF141114),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.phone_android,
              size: 32,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 10),
            Text(
              'Screenshot coming soon',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
