import 'package:flutter/material.dart';

/// Section heading: small crimson label, large title, optional description.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.description,
  });

  final String label;
  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: textTheme.labelSmall),
        const SizedBox(height: 12),
        Text(title, style: textTheme.headlineLarge),
        if (description != null) ...[
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(description!, style: textTheme.bodyMedium),
          ),
        ],
      ],
    );
  }
}
