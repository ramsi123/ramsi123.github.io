import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/models.dart';
import '../theme/app_theme.dart';
import 'app_title.dart';
import 'phone_mockup.dart';
import 'play_cta_row.dart';
import 'tech_tag.dart';

/// Full-width editorial showcase for one published app.
///
/// Text and actions sit on one side with the app media on the other; below
/// 900 px the layout stacks. Every published app uses this same widget.
class AppShowcaseCard extends StatelessWidget {
  const AppShowcaseCard({super.key, required this.app, required this.ordinal});

  final PublishedApp app;

  /// 1-based position, displayed as a large editorial number.
  final int ordinal;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final editorial = _EditorialColumn(app: app, ordinal: ordinal);
        final media = _ShowcaseMedia(app: app);

        if (constraints.maxWidth < 900) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              editorial,
              const SizedBox(height: 40),
              Center(child: media),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 6, child: editorial),
            const SizedBox(width: 56),
            Expanded(flex: 5, child: media),
          ],
        );
      },
    );
  }
}

class _EditorialColumn extends StatelessWidget {
  const _EditorialColumn({required this.app, required this.ordinal});

  final PublishedApp app;
  final int ordinal;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final number = ordinal.toString().padLeft(2, '0');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: textTheme.displayLarge?.copyWith(
            fontSize: 96,
            height: 1,
            color: AppColors.crimson.withValues(alpha: 0.28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Published app · ${app.tagline}'.toUpperCase(),
          style: textTheme.labelSmall,
        ),
        const SizedBox(height: 16),
        AppTitle(name: app.name, iconPath: app.iconPath),
        const SizedBox(height: 16),
        Text(app.summary, style: textTheme.bodyMedium),
        if (app.tags.isNotEmpty) ...[
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [for (final tag in app.tags) TechTag(label: tag)],
          ),
        ],
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 20,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            FilledButton(
              onPressed: () => context.go(app.detailPath),
              child: Text('Visit ${app.name}'),
            ),
            PlayCtaRow(app: app),
          ],
        ),
      ],
    );
  }
}

class _ShowcaseMedia extends StatelessWidget {
  const _ShowcaseMedia({required this.app});

  final PublishedApp app;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        gradient: RadialGradient(
          radius: 0.9,
          colors: [
            AppColors.maroonDeep.withValues(alpha: 0.65),
            Colors.transparent,
          ],
        ),
      ),
      child: Center(
        child: PhoneMockup(
          screenshotPath: app.screenshots.isEmpty
              ? null
              : app.screenshots.first,
          height: 420,
          semanticLabel: '${app.name} screenshot',
        ),
      ),
    );
  }
}
