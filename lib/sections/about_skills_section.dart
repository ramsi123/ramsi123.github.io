import 'package:flutter/material.dart';

import '../data/models.dart';
import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import '../widgets/content_width.dart';
import '../widgets/section_header.dart';
import '../widgets/tech_tag.dart';

/// About summary and grouped skills, driven by [skillGroups].
class AboutSkillsSection extends StatelessWidget {
  const AboutSkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            label: 'About & skills',
            title: 'Skills and focus',
            description: profile.about,
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
                  for (final group in skillGroups)
                    SizedBox(
                      width: cardWidth,
                      child: _SkillCard(group: group),
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

class _SkillCard extends StatelessWidget {
  const _SkillCard({required this.group});

  final SkillGroup group;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
          Text(group.title, style: textTheme.titleMedium),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [for (final skill in group.skills) TechTag(label: skill)],
          ),
        ],
      ),
    );
  }
}
