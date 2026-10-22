# Product Requirements Document (PRD)
## Personal Mobile Developer Portfolio — Flutter Web

**Document purpose:** Implementation-ready specification for an AI coding agent (Claude Code).  
**Product owner:** Dhiya' Ulhaq Ahmad Ramsi  
**Primary implementation:** Flutter Web  
**Design direction:** Professional, minimal, modern dark UI with maroon/crimson accents  
**Typography:** Plus Jakarta Sans for all website text

---

## 1. Product overview

Build a responsive personal portfolio website that presents the owner as a mobile developer specializing in Flutter and Kotlin. The website should make published apps easy to discover and install, while separately showcasing unpublished/GitHub projects and professional experience.

The visual reference is an editorial-style portfolio with large project numbers, prominent project titles, concise descriptions, technology tags, and phone mockups/screenshots aligned beside the text. Each published app receives its own full-width showcase section and a dedicated detail page. Unpublished projects belong in a separate development-projects section and must not be mixed into the published-app showcase.

The site should be easy to extend: adding a new published app should primarily require adding a project data entry and assets, not creating another custom layout.

## 2. Goals

1. Communicate the owner's mobile development focus quickly.
2. Feature published applications with clear routes to their detail pages and Google Play listings.
3. Provide a QR code beside each Google Play link so visitors can scan it and open the corresponding listing on their phone.
4. Keep unpublished/GitHub projects in a separate section.
5. Present experience, skills, education, and contact information professionally.
6. Use responsive layouts and accessible interactions.
7. Make future project additions data-driven and maintainable.

## 3. Non-goals

- Do not recreate or publish source code/assets from professional projects without authorization.
- Do not imply that the owner built an entire product if their role was limited to specific contributions.
- Do not add a backend, database, authentication, CMS, analytics, or contact-form service unless requested.
- Do not fabricate project screenshots, user counts, ratings, performance metrics, testimonials, or achievements.
- Do not claim a project is published unless its listing is provided and verified by the owner.
- Do not make the portfolio depend on externally hosted app screenshots or fonts when local assets are practical.

## 4. Audience

- Recruiters and hiring managers assessing mobile-development skills.
- Developers looking at the owner's engineering approach and GitHub projects.
- Potential users who want to install the published apps.

## 5. Information architecture

Implement a responsive single-page portfolio with navigation anchors and dedicated detail routes for published apps.

### Main navigation
- Home
- Published Apps (or Projects)
- Development Projects
- Experience
- About / Skills
- Contact

Navigation should collapse appropriately on smaller screens and support keyboard interaction.

### Main-page sections
1. **Hero**
   - Name: Dhiya' Ulhaq Ahmad Ramsi
   - Role: Mobile Developer
   - Focus: Flutter and Kotlin / Android
   - Short, professional introduction based only on verified resume/project information.
   - CTA links: View Published Apps, Contact Me, GitHub, LinkedIn; include Download Resume only if a resume asset is supplied.
2. **Published Apps**
   - Full-width, editorial showcase section per published app.
   - Each section has an ordinal number, category/technology label, title, short description, technology tags, app imagery, a primary “Visit [App Name]” button, a Google Play button, and a QR code adjacent to the Google Play button.
   - Layout should resemble the provided visual reference: content on one side, phone mockups/screenshots on the other; alternate alignment only if it improves readability and consistency.
3. **Development Projects**
   - Separate section for unpublished/GitHub projects, using more compact cards than the published-app showcases.
   - Each card includes title, description, tech stack, and GitHub link if a valid repository URL is provided.
   - Do not show a Google Play button or Play Store QR for unpublished projects.
4. **Experience**
   - Present relevant professional experience as a readable timeline or structured list.
   - InterActive Technologies Corp experience may be described in text, but do not include unauthorized source code, private screenshots, logos, or confidential assets.
   - Describe the owner's responsibilities accurately and avoid claiming ownership of the entire product.
5. **About / Skills**
   - Short professional summary.
   - Group skills into sensible categories (mobile, architecture/state management, backend/data, tools/testing).
6. **Education / Certification**
   - Include only confirmed details from the supplied resume or verified project information.
7. **Contact**
   - Email and professional links, using supplied real URLs only.

### Dedicated published-app detail pages
Create a route/page for each published app, initially:
- `/projects/cma-stock`
- `/projects/focustime`

Each page should reuse a shared project-detail template and include:
- App name and summary
- Screenshots/gallery using real supplied assets
- Key features
- Technology stack
- A Google Play CTA and QR code linking to the exact same Play Store URL
- Back/navigation link to the portfolio
- Optional implementation details only where known and authorized

A shared route such as `/projects/:slug` is preferred if compatible with the existing project architecture. Do not create a bespoke layout per app unless necessary.

## 6. Initial project data

Use a single source of truth, e.g. `lib/data/projects_data.dart`, with a typed project model. Separate published apps from development projects via a project type/status field or separate typed lists. Avoid duplicating app metadata between the main showcase and detail page.

### Published app: CMA Stock
- Name: CMA Stock
- Slug: `cma-stock`
- Type: Published app
- Play Store URL: `https://play.google.com/store/apps/details?id=com.ahmadramsi.cahaya_mulya_abadi`
- Known technologies: Flutter, Firebase, Supabase, Lottie, Local Notifications, Flutter Background Service
- Known summary: Inventory management application for CV Cahaya Mulya Abadi, including stock management, notifications, and background tasks.
- Main actions:
  - `Visit CMA Stock` -> `/projects/cma-stock`
  - `Google Play` -> `https://play.google.com/store/apps/details?id=com.ahmadramsi.cahaya_mulya_abadi`
  - QR code -> same URL as Google Play
- Note: Use the provided URL unless the owner supplies the canonical Play Store URL. Do not invent a different link.

### Published app: FocusTime
- Name: FocusTime
- Slug: `focustime`
- Type: Published app
- Play Store URL: `https://play.google.com/store/apps/details?id=com.ahmadramsi.focustime`
- Known description: A focus/productivity app. Confirm detailed feature claims from the listing or the owner before adding specifics.
- Known technologies: **not yet confirmed**. Do not assume Flutter, Kotlin, Dart, or any particular state-management package. Keep technology tags omitted or mark them as needing owner confirmation in implementation notes; do not display “unknown” to website visitors.
- Main actions:
  - `Visit FocusTime` -> `/projects/focustime`
  - `Google Play` -> provided URL
  - QR code -> same URL as Google Play

### Development project: Agrisight
- Name: Agrisight
- Type: Development/GitHub project, not part of published-app showcase
- Known technologies: Kotlin, Jetpack Compose, MVVM, Firebase, Retrofit, OkHttp, Coil, CameraX, TensorFlow Lite
- Known summary: Android project for soil identification and crop recommendations using image-based analysis.
- GitHub URL: Not provided in the current requirements. Add a GitHub button only after locating a real repository URL in the existing project files or receiving it from the owner. Never invent the URL.
- Mark as prototype/academic project only if supported by the repository or owner.

### Future additions
The architecture must allow additional published apps to be added via project data, assets, and optionally detail-page content, without copying the entire showcase widget. New entries must be able to provide:
- name, slug, description, category/label
- technology tags (optional until confirmed)
- screenshots/assets
- Google Play URL
- optional detail content/features
- generated QR code from the same Google Play URL

## 7. Visual design system

### Color palette
Use these values as the design tokens unless the existing codebase has a compelling established theme that must be preserved and reconciled:
- Background: `#101012`
- Surface: `#1A1719`
- Deep maroon: `#64152D`
- Primary maroon: `#8B1E3F`
- Soft crimson: `#D06A85`
- Primary text: `#F5F3F4`
- Secondary text: `#B7AEB2`
- Border: `#30272B`

Use dark surfaces as the majority of the page; reserve maroon/crimson for primary actions, numbering, active navigation, focus states, and small highlights. Avoid green as the primary accent.

### Typography
- Use **Plus Jakarta Sans** for all text: headings, body copy, labels, buttons, navigation, tags, and metadata.
- Use a locally bundled font if font files are available and licensed for use; otherwise load it using the project's established font-asset strategy or a reliable Google Fonts package appropriate for Flutter Web.
- Configure font weights used by the design (at least 400, 500, 600, 700; include 800 only if actually needed).
- Do not mix in a serif display font: the user's final typography preference is Plus Jakarta Sans throughout.
- Ensure typography remains legible and responsive.

### Layout and components
- Maximum content width approximately 1120–1200 px, centered.
- Desktop project showcase: large number/label/title/summary/tags/actions on one side; phone mockups or screenshots on the other.
- Mobile: stack text and media, avoid horizontal overflow, keep buttons tappable, and place QR codes so they remain usable. On small screens, a QR code may be reduced or hidden only if an equivalent visible Google Play link remains; prefer displaying the QR code when practical.
- Consistent section spacing, restrained borders, subtle hover/focus feedback, rounded corners used sparingly.
- Sticky or fixed navigation is optional, but navigation must remain usable and not cover anchor targets.
- Honor reduced-motion preferences; no required animations.
- Use actual app screenshots/assets when provided. Do not use generated mock screenshots as if they were authentic product screenshots. If no screenshots exist, create clean placeholders or use existing repository assets and clearly avoid fabricated UI claims.

## 8. Published-app action and QR behavior

For every published app showcase and detail page:
- Button 1 label: `Visit [App Name]`; route internally to that app's dedicated portfolio detail page.
- Button 2 label: `Google Play`; open the app's Play Store URL in the browser.
- QR code must encode exactly the same URL as the Google Play button.
- QR code should be generated from data at runtime/build time with a maintained Flutter-compatible package, or generated assets with clear instructions. Prefer a package if compatible with the current Flutter version.
- Give QR code an accessible label, e.g. “Scan to open FocusTime on Google Play”.
- Keep a clickable Google Play link available for users who cannot scan a QR code.
- Test the encoded URL, link destination, internal route, and mobile layout.
- Use a clear external-link behavior appropriate to Flutter Web; avoid opening unsafe or unvalidated URLs.

## 9. Technical and implementation constraints

- First inspect the existing repository before changing code. Preserve the current framework, conventions, package versions, and working structure wherever reasonable.
- The target is Flutter Web. Do not replace Flutter with HTML/React or introduce a second frontend framework.
- Avoid large dependencies unless they solve a concrete requirement.
- Use semantic, reusable widgets and typed models.
- Keep project content/data separate from presentation.
- Use responsive breakpoints rather than fixed desktop-only dimensions.
- Ensure external links work on web and internal routes support direct loading/refresh when deployed.
- Keep the project compatible with GitHub Pages deployment if the current repository uses GitHub Pages. Inspect current deployment setup before selecting routing strategy; use path URLs with proper hosting support or a hash-based route if needed to ensure detail pages survive refresh.
- Do not overwrite or delete existing files blindly. Review and explain any structural changes.
- Do not commit secrets, private company materials, or unlicensed assets.
- If a required URL, asset, or detail is missing, leave a clear TODO and continue with the rest of the implementation rather than inventing it.

## 10. Acceptance criteria

### Design and content
- [ ] Plus Jakarta Sans is used throughout the website.
- [ ] Dark background and maroon/crimson accent system is applied consistently.
- [ ] Published apps have their own full-width showcase sections.
- [ ] Published apps are visually distinct from unpublished/GitHub projects.
- [ ] Actual project content is accurate and does not contain invented claims.
- [ ] Professional project experience is described without unauthorized assets or code.

### Published-app experience
- [ ] CMA Stock has a `Visit CMA Stock` button linking to `/projects/cma-stock`.
- [ ] FocusTime has a `Visit FocusTime` button linking to `/projects/focustime`.
- [ ] Each has a Google Play button using its supplied URL.
- [ ] Each has a QR code encoding exactly the same URL as its Google Play button.
- [ ] Each has a dedicated detail page using a reusable template.
- [ ] The data model supports adding a future published app without duplicating widget code.

### Development projects
- [ ] Agrisight appears in a separate Development Projects section.
- [ ] It does not appear in the published-app showcase.
- [ ] GitHub CTA appears only if a valid repository URL is available.
- [ ] Missing details are marked as TODO in code or reported, not invented.

### Responsive, accessibility, and quality
- [ ] Layout works at mobile, tablet, and desktop widths without horizontal overflow.
- [ ] Buttons and links are keyboard accessible and have visible focus states.
- [ ] Text/background contrast is readable.
- [ ] Reduced-motion preferences are respected if animation is implemented.
- [ ] `flutter analyze` passes, or remaining pre-existing/new issues are documented.
- [ ] Relevant tests pass, including tests for project data/routes/QR URL mapping where practical.
- [ ] GitHub Pages refresh/deep-link behavior is tested against the repository's actual deployment setup.

## 11. Suggested task plan for the coding agent

Claude Code should execute these tasks in order. First inspect the repository and report a short plan before making broad changes.

### Phase 1 — Repository reconnaissance
1. Inspect repository tree, `pubspec.yaml`, current routing, theme, assets, tests, and GitHub Pages workflow.
2. Identify existing reusable components and decide what to preserve.
3. Check whether Plus Jakarta Sans files or an appropriate font setup already exists.
4. Report missing assets/URLs (especially authentic app screenshots and the Agrisight repository URL).
5. Write a brief implementation plan; then proceed unless a blocking ambiguity or destructive change requires approval.

### Phase 2 — Theme and typography
6. Add/adjust color tokens for the specified dark/maroon palette.
7. Configure Plus Jakarta Sans across all text styles and weights.
8. Verify typography on headings, body text, buttons, navigation, and tags.

### Phase 3 — Data model and reusable project components
9. Create or update the typed project model and project data source.
10. Separate published apps from development projects in data.
11. Implement reusable published-app showcase section.
12. Implement reusable development-project card.
13. Add responsive phone screenshot/gallery layout using available real assets; add placeholders if assets are missing.

### Phase 4 — Published app detail pages and QR
14. Implement routes for `/projects/cma-stock` and `/projects/focustime`, using a shared detail-page template.
15. Ensure routing works with current GitHub Pages deployment strategy, including direct loading and refresh.
16. Add Google Play buttons with the exact supplied URLs.
17. Add QR generation using the exact same URL values as the Google Play buttons.
18. Add accessible QR labels and maintain a clickable Play Store alternative.

### Phase 5 — Portfolio sections
19. Implement/update the hero and navigation.
20. Build the Published Apps section with CMA Stock and FocusTime only.
21. Build a separate Development Projects section containing Agrisight.
22. Add/update Experience, About/Skills, Education/Certification, and Contact sections using verified resume details only.
23. Ensure the professional project is represented only as experience text, with no unauthorized screenshots, logos, source code, or private assets.

### Phase 6 — Quality and validation
24. Run formatter and `flutter analyze`.
25. Run existing tests and add practical tests for project metadata, routes, and Play Store URL/QR consistency.
26. Check responsive layout at mobile/tablet/desktop widths.
27. Check keyboard navigation, visible focus, semantics, contrast, and reduced motion.
28. Verify all external links and QR destinations.
29. Verify GitHub Pages deployment and deep-link refresh behavior.
30. Summarize changed files, validation results, any remaining TODOs, and exactly what the owner must provide (e.g. real screenshots or Agrisight repo URL).

## 12. Assets and owner-provided inputs

Prefer assets already in the repository. If missing, request or leave TODOs for:
- CMA Stock screenshots/app icon
- FocusTime screenshots/app icon
- Agrisight screenshots
- Agrisight GitHub repository URL
- Resume PDF or a downloadable resume asset (only if desired)
- FocusTime technology stack and detailed features, if these should be shown
- Confirmation of the preferred final routing format if the current GitHub Pages setup imposes a constraint

Do not block the entire site on missing assets. Build the layout so assets can be dropped into documented paths later.

## 13. Definition of done

The work is done when the portfolio meets the acceptance criteria, uses Plus Jakarta Sans consistently, has data-driven published-app sections and dedicated detail pages, provides functional Google Play links and matching QR codes, keeps development projects separate, remains responsive, and passes available static analysis/tests. The final response from the coding agent must include a concise implementation summary, test results, and a list of unresolved owner inputs.
