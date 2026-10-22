import 'package:flutter/material.dart';

import '../router/app_routes.dart';
import '../theme/app_theme.dart';
import 'content_width.dart';

/// Sticky top navigation.
///
/// Desktop shows inline links; below 960 px the links collapse into an
/// expandable panel. The bar sits above the scroll view in the home page
/// layout, so it never covers anchor targets.
class Navbar extends StatefulWidget {
  const Navbar({super.key, required this.onNavigate});

  /// Called with the anchor id to scroll to.
  final ValueChanged<String> onNavigate;

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  static const List<({String label, String anchor})> _items = [
    (label: 'Home', anchor: AppRoutes.homeAnchor),
    (label: 'Published Apps', anchor: AppRoutes.publishedAppsAnchor),
    (
      label: 'Development Projects',
      anchor: AppRoutes.developmentProjectsAnchor,
    ),
    (label: 'Experience', anchor: AppRoutes.experienceAnchor),
    (label: 'About / Skills', anchor: AppRoutes.aboutAnchor),
    (label: 'Contact', anchor: AppRoutes.contactAnchor),
  ];

  bool _menuOpen = false;

  void _navigate(String anchor) {
    setState(() => _menuOpen = false);
    widget.onNavigate(anchor);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ContentWidth(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 68),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isDesktop = constraints.maxWidth >= 960;
                    return Row(
                      children: [
                        TextButton(
                          onPressed: () => _navigate(AppRoutes.homeAnchor),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.textPrimary,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            textStyle: textTheme.titleMedium,
                          ),
                          child: const Text('Ahmad Ramsi'),
                        ),
                        if (isDesktop)
                          Expanded(
                            // Wraps onto a second line if the labels do not fit,
                            // so the bar never overflows horizontally.
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                for (final item in _items)
                                  TextButton(
                                    onPressed: () => _navigate(item.anchor),
                                    child: Text(item.label),
                                  ),
                              ],
                            ),
                          )
                        else ...[
                          const Spacer(),
                          IconButton(
                            tooltip: _menuOpen
                                ? 'Close navigation'
                                : 'Open navigation',
                            onPressed: () =>
                                setState(() => _menuOpen = !_menuOpen),
                            icon: Icon(_menuOpen ? Icons.close : Icons.menu),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ),
            AnimatedSize(
              duration: reduceMotion
                  ? Duration.zero
                  : const Duration(milliseconds: 200),
              alignment: Alignment.topCenter,
              child: _menuOpen
                  ? Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: AppColors.border),
                        ),
                      ),
                      child: ContentWidth(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (final item in _items)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                    onPressed: () => _navigate(item.anchor),
                                    child: Text(item.label),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
