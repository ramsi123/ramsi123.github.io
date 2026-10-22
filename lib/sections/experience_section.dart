import 'package:flutter/material.dart';

import '../data/models.dart';
import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import '../widgets/bullet_list.dart';
import '../widgets/content_width.dart';
import '../widgets/section_header.dart';

/// Professional experience timeline, driven by [experience].
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ContentWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'Experience',
            title: 'Professional experience',
            description:
                'Roles and programs where I have built and shipped mobile '
                'applications.',
          ),
          const SizedBox(height: 40),
          if (experience.isEmpty)
            Text('Experience details coming soon.', style: textTheme.bodyMedium)
          else
            for (var index = 0; index < experience.length; index++) ...[
              if (index > 0) const Divider(height: 48),
              _ExperienceTile(item: experience[index]),
            ],
        ],
      ),
    );
  }
}

class _ExperienceTile extends StatelessWidget {
  const _ExperienceTile({required this.item});

  final ExperienceItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final meta = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.period,
          style: textTheme.labelMedium?.copyWith(color: AppColors.textPrimary),
        ),
        if (item.location.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(item.location, style: textTheme.bodySmall),
        ],
      ],
    );

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.role, style: textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(
          item.organization,
          style: textTheme.labelLarge?.copyWith(color: AppColors.crimson),
        ),
        if (item.description.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(item.description, style: textTheme.bodyMedium),
        ],
        if (item.highlights.isNotEmpty) ...[
          const SizedBox(height: 16),
          BulletList(items: item.highlights),
        ],
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 760) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [meta, const SizedBox(height: 12), body],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 200, child: meta),
            const SizedBox(width: 40),
            Expanded(child: body),
          ],
        );
      },
    );
  }
}
