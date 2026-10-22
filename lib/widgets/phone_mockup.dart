import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// A phone frame showing a real app screenshot, or a clearly neutral
/// placeholder while authentic screenshots are unavailable.
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

  @override
  Widget build(BuildContext context) {
    final path = screenshotPath;
    return SizedBox(
      height: height,
      child: AspectRatio(
        aspectRatio: 9 / 19.5,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.border, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 30,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: path == null
                ? const _ScreenshotPlaceholder()
                : Image.asset(
                    path,
                    fit: BoxFit.cover,
                    semanticLabel: semanticLabel ?? 'App screenshot',
                    errorBuilder: (context, error, stackTrace) =>
                        const _ScreenshotPlaceholder(),
                  ),
          ),
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
