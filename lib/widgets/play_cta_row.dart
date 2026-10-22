import 'package:flutter/material.dart';

import '../data/models.dart';
import 'play_store_button.dart';
import 'qr_code_tile.dart';

/// Google Play button plus matching QR code.
///
/// Both widgets receive [PublishedApp.playStoreUrl] from a single place, so
/// the QR code always encodes exactly the URL the button opens.
class PlayCtaRow extends StatelessWidget {
  const PlayCtaRow({super.key, required this.app});

  final PublishedApp app;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        PlayStoreButton(url: app.playStoreUrl, appName: app.name),
        QrCodeTile(url: app.playStoreUrl, appName: app.name),
      ],
    );
  }
}
