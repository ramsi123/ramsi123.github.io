import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_routes.dart';
import '../sections/about_skills_section.dart';
import '../sections/contact_section.dart';
import '../sections/development_projects_section.dart';
import '../sections/education_section.dart';
import '../sections/experience_section.dart';
import '../sections/hero_section.dart';
import '../sections/published_apps_section.dart';
import '../widgets/footer.dart';
import '../widgets/navbar.dart';

/// Single-page portfolio shell: navigation bar above an anchored scroll view.
class HomePage extends StatefulWidget {
  const HomePage({super.key, this.initialAnchor});

  /// Anchor captured from the browser URL before go_router normalized it.
  final String? initialAnchor;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<String> _anchors = <String>[
    AppRoutes.homeAnchor,
    AppRoutes.publishedAppsAnchor,
    AppRoutes.developmentProjectsAnchor,
    AppRoutes.experienceAnchor,
    AppRoutes.aboutAnchor,
    AppRoutes.educationAnchor,
    AppRoutes.contactAnchor,
  ];

  late final Map<String, GlobalKey> _sectionKeys = {
    for (final anchor in _anchors) anchor: GlobalKey(debugLabel: anchor),
  };

  bool _handledInitialFragment = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Scroll to `/#anchor` deep links after the first layout.
    if (_handledInitialFragment) return;
    _handledInitialFragment = true;
    final fragment =
        widget.initialAnchor ?? GoRouterState.of(context).uri.fragment;
    if (fragment.isEmpty) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _scrollTo(fragment);
    });
  }

  void _scrollTo(String anchor) {
    final target = _sectionKeys[anchor]?.currentContext;
    if (target == null) return;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    Scrollable.ensureVisible(
      target,
      duration: reduceMotion
          ? Duration.zero
          : const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
      alignment: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Navbar(onNavigate: _scrollTo),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _section(
                    AppRoutes.homeAnchor,
                    HeroSection(onNavigate: _scrollTo),
                    padding: const EdgeInsets.only(top: 72, bottom: 96),
                  ),
                  _section(
                    AppRoutes.publishedAppsAnchor,
                    const PublishedAppsSection(),
                  ),
                  _section(
                    AppRoutes.developmentProjectsAnchor,
                    const DevelopmentProjectsSection(),
                  ),
                  _section(
                    AppRoutes.experienceAnchor,
                    const ExperienceSection(),
                  ),
                  _section(AppRoutes.aboutAnchor, const AboutSkillsSection()),
                  _section(AppRoutes.educationAnchor, const EducationSection()),
                  _section(
                    AppRoutes.contactAnchor,
                    const ContactSection(),
                    padding: const EdgeInsets.only(top: 72, bottom: 88),
                  ),
                  Footer(onNavigate: _scrollTo),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(
    String anchor,
    Widget child, {
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 72),
  }) {
    return Padding(key: _sectionKeys[anchor], padding: padding, child: child);
  }
}
