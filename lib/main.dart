import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app.dart';

void main() {
  // go_router's path strategy normalizes the URL during startup, which drops
  // the fragment, so capture `/#anchor` links from the browser first.
  final initialAnchor = Uri.base.fragment;
  // Use real path URLs (`/projects/<slug>`) instead of hash URLs on the web.
  usePathUrlStrategy();
  runApp(PortfolioApp(initialAnchor: initialAnchor));
}
