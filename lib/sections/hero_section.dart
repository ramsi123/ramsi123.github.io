import 'package:flutter/material.dart';

import '../data/profile_data.dart';
import '../router/app_routes.dart';
import '../widgets/content_width.dart';
import '../widgets/external_launcher.dart';

/// Landing section: name, role, short introduction, and primary links.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onNavigate});

  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isWide = MediaQuery.sizeOf(context).width >= 900;

    return ContentWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${profile.role} · ${profile.focus}'.toUpperCase(),
            style: textTheme.labelSmall,
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Text(
              profile.name,
              style: textTheme.displayLarge?.copyWith(
                fontSize: isWide ? 64 : 40,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(profile.intro, style: textTheme.bodyLarge),
          ),
          const SizedBox(height: 36),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FilledButton(
                onPressed: () => onNavigate(AppRoutes.publishedAppsAnchor),
                child: const Text('View Published Apps'),
              ),
              OutlinedButton(
                onPressed: () => onNavigate(AppRoutes.contactAnchor),
                child: const Text('Contact Me'),
              ),
              TextButton.icon(
                onPressed: () => openExternalUrl(context, profile.githubUrl),
                icon: const Icon(Icons.code, size: 18),
                label: const Text('GitHub'),
              ),
              TextButton.icon(
                onPressed: () => openExternalUrl(context, profile.linkedinUrl),
                icon: const Icon(Icons.work_outline, size: 18),
                label: const Text('LinkedIn'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
