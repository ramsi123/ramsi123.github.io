import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:ahmad_ramsi_portfolio/data/profile_data.dart';
import 'package:ahmad_ramsi_portfolio/data/projects_data.dart';

void main() {
  group('published apps', () {
    test('slugs are unique', () {
      final slugs = publishedApps.map((app) => app.slug).toList();
      expect(slugs.toSet().length, slugs.length);
    });

    test('every app has required content and an https Play Store URL', () {
      for (final app in publishedApps) {
        expect(app.name, isNotEmpty, reason: app.slug);
        expect(app.slug, isNotEmpty);
        expect(app.tagline, isNotEmpty, reason: app.slug);
        expect(app.summary, isNotEmpty, reason: app.slug);
        expect(app.playStoreUrl, startsWith('https://'), reason: app.slug);
      }
    });

    test('detail paths follow /projects/<slug>', () {
      for (final app in publishedApps) {
        expect(app.detailPath, '/projects/${app.slug}');
      }
    });

    test('QR payload matches the Google Play URL exactly', () {
      for (final app in publishedApps) {
        expect(app.qrPayload, app.playStoreUrl, reason: app.slug);
      }
    });

    test('uses the exact owner-provided Play Store URLs', () {
      final urls = {
        for (final app in publishedApps) app.slug: app.playStoreUrl,
      };
      expect(urls['cma-stock'], 'https://bit.ly/CMAStockApp');
      expect(
        urls['focustime'],
        'https://play.google.com/store/apps/details?id=com.ahmadramsi.focustime',
      );
    });

    test('FocusTime records the owner-confirmed stack and features', () {
      final focusTime = publishedAppBySlug('focustime');
      expect(focusTime, isNotNull);
      expect(focusTime!.tags, containsAll(<String>['Flutter', 'Riverpod']));
      expect(focusTime.features, isNotEmpty);
    });

    test('lookup by slug finds each app and rejects unknown slugs', () {
      for (final app in publishedApps) {
        expect(publishedAppBySlug(app.slug), same(app));
      }
      expect(publishedAppBySlug('does-not-exist'), isNull);
    });

    test('screenshot paths live under assets/screenshots/ and exist', () {
      for (final app in publishedApps) {
        for (final path in app.screenshots) {
          expect(path, startsWith('assets/screenshots/'), reason: app.slug);
          expect(File(path).existsSync(), isTrue, reason: '$path is missing');
        }
      }
    });

    test('icon paths live under assets/icons/ and exist', () {
      for (final app in publishedApps) {
        final path = app.iconPath;
        if (path == null) continue;
        expect(path, startsWith('assets/icons/'), reason: app.slug);
        expect(File(path).existsSync(), isTrue, reason: '$path is missing');
      }
      expect(
        publishedAppBySlug('cma-stock')?.iconPath,
        'assets/icons/cma-stock.png',
      );
      expect(
        publishedAppBySlug('focustime')?.iconPath,
        'assets/icons/focustime.png',
      );
    });
  });

  group('profile', () {
    test('contact details use the confirmed values', () {
      expect(profile.email, 'dhiyaulhaqahmadramsi@gmail.com');
      expect(profile.githubUrl, 'https://github.com/ramsi123');
      expect(
        profile.linkedinUrl,
        'https://www.linkedin.com/in/dhiya-ulhaq-ahmad-ramsi-884641222',
      );
      expect(profile.intro, isNotEmpty);
      expect(profile.about, isNotEmpty);
    });

    test('experience entries are complete enough to render', () {
      expect(experience, isNotEmpty);
      for (final item in experience) {
        expect(item.role, isNotEmpty);
        expect(item.organization, isNotEmpty);
        expect(item.period, isNotEmpty, reason: item.role);
        expect(item.highlights, isNotEmpty, reason: item.role);
      }
    });

    test('education and certification details are confirmed', () {
      expect(education, isNotEmpty);
      for (final item in education) {
        expect(item.title, isNotEmpty);
        expect(item.institution, isNotEmpty);
      }
      for (final item in certifications) {
        expect(item.title, isNotEmpty);
        final url = item.verifyUrl;
        if (url != null) {
          expect(url, startsWith('https://'), reason: item.title);
        }
      }
    });

    test('skill groups have titles and skills', () {
      expect(skillGroups, isNotEmpty);
      for (final group in skillGroups) {
        expect(group.title, isNotEmpty);
        expect(group.skills, isNotEmpty, reason: group.title);
      }
    });
  });

  group('development projects', () {
    test('Agrisight is a development project, not a published app', () {
      expect(developmentProjects.map((p) => p.name), contains('Agrisight'));
      expect(
        publishedApps.map((app) => app.name),
        isNot(contains('Agrisight')),
      );
    });

    test('project names are unique', () {
      final names = developmentProjects.map((p) => p.name).toList();
      expect(names.toSet().length, names.length);
    });

    test('Agrisight uses the owner-provided repository URL', () {
      final agrisight = developmentProjects.singleWhere(
        (project) => project.name == 'Agrisight',
      );
      expect(agrisight.githubUrl, 'https://github.com/ramsi123/Agrisight');
    });

    test('GitHub URLs, when present, are valid https URLs', () {
      for (final project in developmentProjects) {
        final url = project.githubUrl;
        if (url != null) {
          expect(url, startsWith('https://'), reason: project.name);
          expect(Uri.tryParse(url)?.hasAuthority, isTrue);
        }
      }
    });
  });
}
