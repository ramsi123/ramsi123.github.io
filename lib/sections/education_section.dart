import 'package:flutter/material.dart';

import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import '../widgets/content_width.dart';
import '../widgets/external_launcher.dart';
import '../widgets/section_header.dart';

/// Education and certification, driven by [education] and [certifications].
class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'Education & certification',
            title: 'Education and certification',
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 860;
              final educationColumn = const _EducationList();
              final certificationColumn = const _CertificationCard();

              if (!isWide) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    educationColumn,
                    const SizedBox(height: 32),
                    certificationColumn,
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: educationColumn),
                  const SizedBox(width: 40),
                  Expanded(flex: 2, child: certificationColumn),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _EducationList extends StatelessWidget {
  const _EducationList();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var index = 0; index < education.length; index++) ...[
          if (index > 0) const SizedBox(height: 28),
          Text(
            education[index].period,
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(education[index].title, style: textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(education[index].institution, style: textTheme.bodyMedium),
          if (education[index].description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(education[index].description, style: textTheme.bodyMedium),
          ],
        ],
      ],
    );
  }
}

class _CertificationCard extends StatelessWidget {
  const _CertificationCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (certifications.isEmpty) {
      return const SizedBox.shrink();
    }

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
          Text('Certification', style: textTheme.labelSmall),
          const SizedBox(height: 12),
          for (var index = 0; index < certifications.length; index++) ...[
            if (index > 0) const SizedBox(height: 24),
            Text(certifications[index].title, style: textTheme.titleMedium),
            if (certifications[index].issuer.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(certifications[index].issuer, style: textTheme.bodyMedium),
            ],
            if (certifications[index].verifyUrl != null) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () =>
                    openExternalUrl(context, certifications[index].verifyUrl!),
                icon: const Icon(Icons.open_in_new, size: 18),
                label: const Text('Verify certificate'),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
