import 'package:flutter/material.dart';

import '../data/profile_data.dart';
import '../router/app_routes.dart';
import '../theme/app_theme.dart';
import 'content_width.dart';
import 'external_launcher.dart';

/// Page footer with copyright and professional links.
class Footer extends StatelessWidget {
  const Footer({super.key, required this.onNavigate});

  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final year = DateTime.now().year;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: ContentWidth(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Wrap(
            spacing: 24,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text('© $year ${profile.name}', style: textTheme.bodySmall),
              TextButton(
                onPressed: () => onNavigate(AppRoutes.homeAnchor),
                child: const Text('Back to top'),
              ),
              TextButton(
                onPressed: () => openExternalUrl(context, profile.githubUrl),
                child: const Text('GitHub'),
              ),
              TextButton(
                onPressed: () => openExternalUrl(context, profile.linkedinUrl),
                child: const Text('LinkedIn'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
