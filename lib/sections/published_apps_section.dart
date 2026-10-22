import 'package:flutter/material.dart';

import '../data/projects_data.dart';
import '../widgets/app_showcase_card.dart';
import '../widgets/content_width.dart';
import '../widgets/section_header.dart';

/// Full-width showcase of every published app, driven by [publishedApps].
class PublishedAppsSection extends StatelessWidget {
  const PublishedAppsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'Published apps',
            title: 'Published on Google Play',
            description:
                'Applications published on Google Play. Visit a project page '
                'for details, or open its listing directly on Google Play.',
          ),
          const SizedBox(height: 48),
          for (var index = 0; index < publishedApps.length; index++) ...[
            if (index > 0)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Divider(height: 1),
              ),
            AppShowcaseCard(app: publishedApps[index], ordinal: index + 1),
          ],
        ],
      ),
    );
  }
}
