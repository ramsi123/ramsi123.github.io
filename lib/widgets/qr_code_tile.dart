import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../theme/app_theme.dart';

/// A QR code encoding [url], rendered on a white card so it stays scannable
/// against the dark theme.
class QrCodeTile extends StatelessWidget {
  const QrCodeTile({
    super.key,
    required this.url,
    required this.appName,
    this.qrSize = 112,
  });

  final String url;
  final String appName;
  final double qrSize;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Semantics(
      image: true,
      label: 'Scan with your phone to open $appName on Google Play',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: SizedBox.square(
              dimension: qrSize,
              child: PrettyQrView.data(
                data: url,
                decoration: const PrettyQrDecoration(
                  shape: PrettyQrSmoothSymbol(color: Color(0xFF101012)),
                  quietZone: PrettyQrQuietZone.standard,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          ExcludeSemantics(
            child: Text(
              'Scan with your phone to open $appName on Google Play',
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
