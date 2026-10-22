import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_routes.dart';
import '../widgets/content_width.dart';

/// Shown for unknown paths and unknown project slugs.
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: ContentWidth(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('404', style: textTheme.labelSmall),
                const SizedBox(height: 12),
                Text(
                  'Page not found',
                  style: textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  "The page you're looking for doesn't exist or may have moved.",
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                FilledButton(
                  onPressed: () => context.go(AppRoutes.home),
                  child: const Text('Back to portfolio'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
