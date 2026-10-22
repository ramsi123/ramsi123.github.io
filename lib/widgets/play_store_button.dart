import 'package:flutter/material.dart';

import 'external_launcher.dart';

/// Opens the app's Google Play listing in a new browser tab.
class PlayStoreButton extends StatelessWidget {
  const PlayStoreButton({super.key, required this.url, required this.appName});

  final String url;
  final String appName;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Open $appName on Google Play',
      child: OutlinedButton.icon(
        onPressed: () => openExternalUrl(context, url),
        icon: const Icon(Icons.play_arrow_rounded, size: 20),
        label: const Text('Google Play'),
      ),
    );
  }
}
