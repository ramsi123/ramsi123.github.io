import 'package:flutter/material.dart';

import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import '../widgets/content_width.dart';
import '../widgets/external_launcher.dart';
import '../widgets/section_header.dart';

/// Contact details and professional links.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'Contact',
            title: 'Get in touch',
            description:
                'Open to mobile development opportunities and collaboration. '
                'Email is the fastest way to reach me.',
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = constraints.maxWidth >= 700
                  ? 320.0
                  : constraints.maxWidth;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: cardWidth,
                    child: _ContactButton(
                      icon: Icons.mail_outline,
                      label: 'Email',
                      value: profile.email,
                      url: 'mailto:${profile.email}',
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: _ContactButton(
                      icon: Icons.code,
                      label: 'GitHub',
                      value: 'github.com/ramsi123',
                      url: profile.githubUrl,
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: _ContactButton(
                      icon: Icons.work_outline,
                      label: 'LinkedIn',
                      value: 'linkedin.com/in/dhiya-ulhaq-ahmad-ramsi',
                      url: profile.linkedinUrl,
                    ),
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

class _ContactButton extends StatelessWidget {
  const _ContactButton({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
  });

  final IconData icon;
  final String label;
  final String value;
  final String url;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return OutlinedButton(
      onPressed: () => openExternalUrl(context, url),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        alignment: Alignment.centerLeft,
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: textTheme.labelSmall),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.open_in_new,
            size: 16,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}
