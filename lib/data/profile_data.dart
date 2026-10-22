import 'models.dart';

/// Public profile details. All values come from the owner-supplied resume.
const Profile profile = Profile(
  name: "Dhiya' Ulhaq Ahmad Ramsi",
  role: 'Mobile Developer',
  focus: 'Flutter and Kotlin / Android',
  intro:
      'Mobile developer specializing in Flutter and Kotlin for Android. My '
      'published work includes CMA Stock, an inventory management app for CV '
      'Cahaya Mulya Abadi, and FocusTime, a focus and productivity app — both '
      'available on Google Play.',
  about:
      'Mobile developer with experience across Flutter and native Android, '
      'from production feature work and legacy refactors to apps published on '
      'Google Play. I care about clean architecture, maintainable state '
      'management, and testable code.',
  email: 'dhiyaulhaqahmadramsi@gmail.com',
  githubUrl: 'https://github.com/ramsi123',
  linkedinUrl: 'https://www.linkedin.com/in/dhiya-ulhaq-ahmad-ramsi-884641222',
  // The owner opted out of a downloadable resume, so the Download Resume CTA
  // is intentionally omitted. If a PDF is added at `web/resume.pdf` later,
  // re-add the CTA in `lib/sections/hero_section.dart` using
  // `Uri.base.resolve(profile.resumePath)`.
  resumePath: 'resume.pdf',
);

/// Skill groups from the owner-supplied resume.
const List<SkillGroup> skillGroups = <SkillGroup>[
  SkillGroup(
    title: 'Mobile development',
    skills: <String>[
      'Flutter',
      'Dart',
      'Kotlin',
      'Android',
      'Jetpack Compose',
      'XML',
    ],
  ),
  SkillGroup(
    title: 'Architecture and state management',
    skills: <String>[
      'MVVM',
      'Clean Architecture',
      'Riverpod',
      'Provider',
      'BLoC',
      'GetX',
    ],
  ),
  SkillGroup(
    title: 'Backend and data',
    skills: <String>[
      'RESTful APIs',
      'Firebase',
      'Supabase',
      'Retrofit',
      'OkHttp',
      'SQL',
      'NoSQL',
    ],
  ),
  SkillGroup(
    title: 'Tools and practices',
    skills: <String>[
      'Git',
      'Testing and debugging',
      'Lottie',
      'Local Notifications',
      'Flutter Background Service',
      'Coil',
      'CameraX',
      'TensorFlow Lite',
    ],
  ),
];

/// Professional experience from the owner-supplied resume.
const List<ExperienceItem> experience = <ExperienceItem>[
  ExperienceItem(
    role: 'Mobile Developer',
    organization: 'InterActive Technologies Corp',
    period: 'Dec 2025 – Jun 2026',
    location: 'Surabaya — Hybrid',
    highlights: <String>[
      'Collaborated on feature development and bug resolution in Flutter for '
          'the Infinite QRIS platform, ensuring a seamless user experience.',
      'Migrated state management to Riverpod, reducing code redundancy and '
          'optimizing the application’s reactivity grid.',
      'Refactored legacy code across the UI, business logic, and data '
          'services, ensuring strict adherence to Clean Architecture and '
          'robust testability.',
    ],
  ),
  ExperienceItem(
    role: 'Android Jetpack Developer',
    organization: 'Betr Beta',
    period: 'Dec 2023 – Mar 2024',
    location: 'Singapore — Remote',
    highlights: <String>[
      'Developed and optimized mobile UI components using Jetpack Compose and '
          'XML, improving load performance and responsiveness.',
      'Implemented features such as enhanced user flow, dynamic UI elements, '
          'and progressive web app (PWA) improvements for Android.',
      'Added automated tests and improved the debugging workflow to reduce '
          'regressions and strengthen delivery quality.',
      'Fixed key bugs and UI/UX inconsistencies, reducing error reports and '
          'improving the overall user experience.',
    ],
  ),
  ExperienceItem(
    role: 'Mobile Development Cohort',
    organization: 'Bangkit Academy',
    period: 'Aug 2023 – Jan 2024',
    location: 'Jakarta — Remote',
    highlights: <String>[
      'Developed mobile application features using native Kotlin, aligned '
          'with industry-level best practices.',
      'Collaborated with machine learning and cloud computing cohorts to '
          'build a capstone project from ideation to deployment.',
      'Applied the MVVM pattern and organized screen-level structure to '
          'support maintainable feature development.',
    ],
  ),
];

/// Education from the owner-supplied resume.
const List<EducationItem> education = <EducationItem>[
  EducationItem(
    title: 'Bachelor of Computer Science — Information System',
    institution: 'Universitas Pembangunan Nasional “Veteran” Jawa Timur',
    period: '2021 – 2025',
  ),
  EducationItem(
    title: 'High School',
    institution: 'SMA Muhammadiyah 1 Taman',
    period: '2018 – 2021',
  ),
];

/// Certifications from the owner-supplied resume.
const List<CertificationItem> certifications = <CertificationItem>[
  CertificationItem(
    title: 'Android Developer Certification',
    verifyUrl: 'https://dev.id/certificate/verify/Y5VEK45V91',
  ),
];
