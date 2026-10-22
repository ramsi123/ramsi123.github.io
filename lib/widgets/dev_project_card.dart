import 'package:flutter/material.dart';

import '../data/models.dart';
import '../theme/app_theme.dart';
import 'external_launcher.dart';
import 'tech_tag.dart';

/// Compact card for an unpublished/GitHub project.
///
/// Intentionally smaller and flatter than the published-app showcase so the
/// two groups stay visually distinct. A GitHub button only appears when the
/// owner has supplied a real repository URL.
class DevProjectCard extends StatelessWidget {
  const DevProjectCard({super.key, required this.project});

  final DevelopmentProject project;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final githubUrl = project.githubUrl;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Development project', style: textTheme.labelSmall),
          const SizedBox(height: 12),
          Text(project.name, style: textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(project.summary, style: textTheme.bodyMedium),
          if (project.tags.isNotEmpty) ...[
            const SizedBox(height: 18),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [for (final tag in project.tags) TechTag(label: tag)],
            ),
          ],
          if (githubUrl != null) ...[
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () => openExternalUrl(context, githubUrl),
              icon: const Icon(Icons.code, size: 18),
              label: const Text('GitHub'),
            ),
          ],
        ],
      ),
    );
  }
}
