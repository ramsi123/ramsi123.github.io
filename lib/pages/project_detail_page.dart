import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/models.dart';
import '../router/app_routes.dart';
import '../theme/app_theme.dart';
import '../widgets/app_title.dart';
import '../widgets/bullet_list.dart';
import '../widgets/content_width.dart';
import '../widgets/phone_mockup.dart';
import '../widgets/play_cta_row.dart';
import '../widgets/tech_tag.dart';

/// Shared template for every published app's detail page.
///
/// Driven entirely by [PublishedApp]; adding a published app requires no new
/// page code.
class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key, required this.app});

  final PublishedApp app;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        children: [
          _DetailTopBar(appName: app.name),
          Expanded(
            child: SingleChildScrollView(
              child: ContentWidth(
                child: Padding(
                  padding: const EdgeInsets.only(top: 48, bottom: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Published app · ${app.tagline}'.toUpperCase(),
                        style: textTheme.labelSmall,
                      ),
                      const SizedBox(height: 12),
                      AppTitle(name: app.name, iconPath: app.iconPath),
                      const SizedBox(height: 16),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 760),
                        child: Text(app.summary, style: textTheme.bodyMedium),
                      ),
                      const SizedBox(height: 40),
                      _DetailGallery(screenshots: app.screenshots),
                      if (app.features.isNotEmpty) ...[
                        const SizedBox(height: 48),
                        Text('Key features', style: textTheme.headlineSmall),
                        const SizedBox(height: 16),
                        BulletList(items: app.features),
                      ],
                      if (app.tags.isNotEmpty) ...[
                        const SizedBox(height: 40),
                        Text(
                          'Technology stack',
                          style: textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final tag in app.tags) TechTag(label: tag),
                          ],
                        ),
                      ],
                      const SizedBox(height: 48),
                      PlayCtaRow(app: app),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailTopBar extends StatelessWidget {
  const _DetailTopBar({required this.appName});

  final String appName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        bottom: false,
        child: ContentWidth(
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: () => context.go(AppRoutes.home),
                  icon: const Icon(Icons.arrow_back, size: 18),
                  label: const Text('Back to portfolio'),
                ),
                const Spacer(),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    appName,
                    style: textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailGallery extends StatelessWidget {
  const _DetailGallery({required this.screenshots});

  final List<String> screenshots;

  @override
  Widget build(BuildContext context) {
    if (screenshots.isEmpty) {
      return const Center(child: PhoneMockup(height: 400));
    }

    return SizedBox(
      height: 440,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: screenshots.length,
        separatorBuilder: (context, index) => const SizedBox(width: 24),
        itemBuilder: (context, index) => PhoneMockup(
          screenshotPath: screenshots[index],
          height: 440,
          semanticLabel: 'App screenshot ${index + 1}',
        ),
      ),
    );
  }
}
