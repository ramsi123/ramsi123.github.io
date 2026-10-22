import '../router/app_routes.dart';

/// A published app showcased on the portfolio and on its own detail page.
class PublishedApp {
  const PublishedApp({
    required this.name,
    required this.slug,
    required this.tagline,
    required this.summary,
    required this.playStoreUrl,
    this.tags = const <String>[],
    this.features = const <String>[],
    this.screenshots = const <String>[],
    this.iconPath,
  });

  final String name;
  final String slug;

  /// Short category label, e.g. "Inventory management".
  final String tagline;

  final String summary;

  /// Confirmed technologies. May stay empty while awaiting owner confirmation;
  /// the UI never renders an "unknown" placeholder.
  final List<String> tags;

  /// Detail-page feature bullets. May stay empty; the UI omits the section.
  final List<String> features;

  /// Asset paths under `assets/screenshots/<slug>/`.
  final List<String> screenshots;

  /// Owner-supplied app icon under `assets/icons/`, when available.
  final String? iconPath;

  /// The exact Google Play listing URL.
  final String playStoreUrl;

  /// Internal route of this app's detail page.
  String get detailPath => AppRoutes.projectDetail(slug);

  /// The QR code must encode exactly the same URL as the Google Play button.
  String get qrPayload => playStoreUrl;
}

/// An unpublished/GitHub project. Never rendered in the published showcase.
class DevelopmentProject {
  const DevelopmentProject({
    required this.name,
    required this.summary,
    this.tags = const <String>[],
    this.githubUrl,
  });

  final String name;
  final String summary;
  final List<String> tags;

  /// Only set once the owner provides a real repository URL; the GitHub
  /// button stays hidden while this is null.
  final String? githubUrl;
}

/// A professional experience entry. Only confirmed resume facts are stored.
class ExperienceItem {
  const ExperienceItem({
    required this.role,
    required this.organization,
    this.period = '',
    this.location = '',
    this.description = '',
    this.highlights = const <String>[],
  });

  final String role;
  final String organization;
  final String period;
  final String location;
  final String description;
  final List<String> highlights;
}

/// An education entry. Only confirmed resume facts are stored.
class EducationItem {
  const EducationItem({
    required this.title,
    required this.institution,
    this.period = '',
    this.description = '',
  });

  final String title;
  final String institution;
  final String period;
  final String description;
}

/// A certification entry. Only confirmed resume facts are stored.
class CertificationItem {
  const CertificationItem({
    required this.title,
    this.issuer = '',
    this.verifyUrl,
  });

  final String title;
  final String issuer;

  /// Public verification link, when supplied.
  final String? verifyUrl;
}

/// A named group of related skills.
class SkillGroup {
  const SkillGroup({required this.title, required this.skills});

  final String title;
  final List<String> skills;
}

/// Public profile and contact details.
class Profile {
  const Profile({
    required this.name,
    required this.role,
    required this.focus,
    required this.intro,
    required this.about,
    required this.email,
    required this.githubUrl,
    required this.linkedinUrl,
    required this.resumePath,
  });

  final String name;
  final String role;
  final String focus;

  /// Short introduction built only from confirmed information.
  final String intro;

  /// Professional summary shown in the About section.
  final String about;

  final String email;
  final String githubUrl;
  final String linkedinUrl;

  /// File served from `web/` (outside the asset bundle) for the resume CTA.
  final String resumePath;
}
