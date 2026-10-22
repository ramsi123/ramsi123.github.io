# Claude Code Task Checklist
## Flutter Web Mobile Developer Portfolio

Use this checklist alongside `PORTFOLIO_PRD.md`. Follow the order below, inspect before editing, and do not invent missing details or assets.

## Phase 1 — Inspect first
- [x] Inspect the project structure, `pubspec.yaml`, app entry point, routing, theme, assets, tests, and GitHub Pages workflow.
- [x] Identify current architecture and preserve conventions where practical.
- [x] Check existing font setup and available app screenshots/icons.
- [x] Check whether Agrisight's real GitHub repository URL exists in the repo or project documentation.
- [x] Report a concise plan and any risky structural changes before proceeding.

## Phase 2 — Design system
- [x] Apply palette tokens from the PRD: `#101012`, `#1A1719`, `#64152D`, `#8B1E3F`, `#D06A85`, `#F5F3F4`, `#B7AEB2`, `#30272B`.
- [x] Use Plus Jakarta Sans for every text style, including navigation, headings, body, tags, metadata, and buttons.
- [x] Ensure responsive text sizes and readable contrast.
- [x] Add visible keyboard focus states and restrained hover states.

## Phase 3 — Project data and reusable widgets
- [x] Define a typed project model.
- [x] Store project metadata in one source of truth.
- [x] Add CMA Stock and FocusTime to the published-app data.
- [x] Add Agrisight to the separate development-project data.
- [x] Build a reusable full-width published-app showcase widget.
- [x] Build a reusable development-project card/widget.
- [x] Make project sections data-driven so future apps can be added by adding data/assets.
- [x] Use authentic assets from the repo; use clearly neutral placeholders if absent.

## Phase 4 — Published-app detail pages and links
- [x] Implement `/projects/cma-stock`.
- [x] Implement `/projects/focustime`.
- [x] Use a shared detail-page template.
- [x] Add `Visit CMA Stock` and `Visit FocusTime` internal links.
- [x] Add Google Play buttons using exact URLs in the PRD.
- [x] Generate a QR code for each app from the exact same URL used by its Google Play button.
- [x] Give each QR an accessible label.
- [x] Keep Google Play links available for users who cannot scan QR codes.
- [x] Confirm links open correctly on Flutter Web.

## Phase 5 — Main portfolio
- [x] Build/update the hero section.
- [x] Build/update navigation and responsive mobile navigation.
- [x] Add Published Apps showcase for CMA Stock and FocusTime only.
- [x] Add a separate Development Projects section for Agrisight.
- [x] Add/update Experience, About/Skills, Education/Certification, and Contact using verified information.
- [x] Mention professional experience only as accurate text; do not use unauthorized project assets or code.
- [x] Add a resume download only if a real resume asset is present (owner opted out; CTA intentionally omitted).

## Phase 6 — Responsive and accessible behavior
- [x] Check phone, tablet, and desktop layouts.
- [x] Ensure no horizontal overflow.
- [x] Ensure controls have practical touch targets.
- [x] Ensure navigation anchors are not hidden under sticky headers.
- [x] Verify semantic labels and keyboard navigation.
- [x] Respect reduced-motion preferences if animation is used.
- [x] Confirm QR code placement remains useful on narrow screens.

## Phase 7 — Validation and deployment
- [x] Format Dart code.
- [x] Run `flutter analyze`.
- [x] Run the existing test suite.
- [x] Add tests for project data, routes, and QR URL mapping where practical.
- [x] Verify all Play Store URLs and generated QR codes.
- [x] Verify direct route/refresh behavior for the documented GitHub Pages strategy (verified locally with an SPA fallback; `404.html` copy documented in the README).
- [x] Review for fabricated claims, fake screenshots, dead links, secrets, or confidential assets.
- [x] Provide a final summary of files changed, tests run/results, missing owner inputs, and deployment notes.

## Known values
- CMA Stock Play Store URL: `https://play.google.com/store/apps/details?id=com.ahmadramsi.cahaya_mulya_abadi`
- FocusTime Play Store URL: `https://play.google.com/store/apps/details?id=com.ahmadramsi.focustime`
- GitHub: `https://github.com/ramsi123`
- LinkedIn: `https://www.linkedin.com/in/dhiya-ulhaq-ahmad-ramsi-884641222`
- Email: `dhiyaulhaqahmadramsi@gmail.com`

## Owner inputs that may still be needed
- [x] Authentic CMA Stock screenshots and app icon.
- [x] Authentic FocusTime screenshots and app icon.
- [x] Agrisight visuals — owner opted to show only title, description, and tech stack (no icon or screenshots).
- [x] Agrisight GitHub repository URL.
- [x] Confirmed FocusTime technology stack and any detailed features to display.
