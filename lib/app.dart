import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Root widget of the portfolio site.
class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key, this.initialAnchor});

  /// Section anchor captured from the browser URL before the router
  /// normalizes it, e.g. `experience` from `/#experience`.
  final String? initialAnchor;

  static const String title = "Dhiya' Ulhaq Ahmad Ramsi — Mobile Developer";

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  late final GoRouter _router = buildRouter(
    initialAnchor: widget.initialAnchor,
  );

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: PortfolioApp.title,
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: _router,
    );
  }
}
