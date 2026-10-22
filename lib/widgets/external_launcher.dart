import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens [url] in a new browser tab.
///
/// Only http(s) and mailto URLs are allowed. The messenger is captured before
/// the asynchronous launch so the build context is never used after an await.
Future<bool> openExternalUrl(BuildContext context, String url) async {
  final messenger = ScaffoldMessenger.maybeOf(context);
  final uri = Uri.tryParse(url);

  if (uri == null || !_isAllowedScheme(uri)) {
    messenger?.showSnackBar(
      const SnackBar(content: Text('This link is not available.')),
    );
    return false;
  }

  try {
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.platformDefault,
      webOnlyWindowName: '_blank',
    );
    if (!launched) {
      messenger?.showSnackBar(SnackBar(content: Text('Could not open $url')));
    }
    return launched;
  } catch (_) {
    messenger?.showSnackBar(SnackBar(content: Text('Could not open $url')));
    return false;
  }
}

bool _isAllowedScheme(Uri uri) =>
    uri.scheme == 'https' || uri.scheme == 'http' || uri.scheme == 'mailto';
