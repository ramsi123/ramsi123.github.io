import 'package:flutter/material.dart';

import '../data/projects_data.dart';
import '../widgets/content_width.dart';
import '../widgets/dev_project_card.dart';
import '../widgets/section_header.dart';

/// Compact cards for unpublished/GitHub projects, driven by
/// [developmentProjects]. Never shows Play Store actions.
class DevelopmentProjectsSection extends StatelessWidget {
  const DevelopmentProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'Development projects',
            title: 'Projects in development',
            description:
                'Unpublished projects and experiments, kept separate from the '
                'published apps. Source links appear only when a public '
                'repository is available.',
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final twoColumns = constraints.maxWidth >= 800;
              final cardWidth = twoColumns
                  ? (constraints.maxWidth - 24) / 2
                  : constraints.maxWidth;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  for (final project in developmentProjects)
                    SizedBox(
                      width: cardWidth,
                      child: DevProjectCard(project: project),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
