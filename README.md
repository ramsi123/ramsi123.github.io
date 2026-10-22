# Ahmad Ramsi — Mobile Developer Portfolio

A Flutter Web portfolio for **Dhiya' Ulhaq Ahmad Ramsi**, a mobile developer
working in Flutter and Kotlin for Android.

The site uses a dark editorial layout with maroon/crimson accents and locally
bundled **Plus Jakarta Sans** throughout. Published apps get full-width
showcases and dedicated detail pages; unpublished/GitHub projects stay in a
separate, visually distinct section.

- Published apps: **CMA Stock**, **FocusTime**
- Development project: **Agrisight**
- Detail routes: `/projects/cma-stock`, `/projects/focustime`
- Every published app has a Google Play button and a QR code that encodes the
  exact same Play Store URL

## Stack

| Area | Choice |
|---|---|
| Framework | Flutter 3.38.6 / Dart 3.10.7 (Flutter Web) |
| Routing | `go_router` 17 with path URL strategy |
| QR codes | `pretty_qr_code` (drawn locally, no external QR service) |
| External links | `url_launcher` |
| Typography | Plus Jakarta Sans, bundled from `assets/google_fonts/` |

No backend, database, authentication, analytics, or contact-form service is
included, by design.

## Run locally

```powershell
flutter pub get
flutter run -d chrome
```

`lib/main.dart` calls `usePathUrlStrategy()`, so the app uses real path URLs
(`/projects/cma-stock`) rather than hash URLs (`/#/projects/cma-stock`).

## Project structure

```text
lib/
  main.dart                  # path URL strategy + initial anchor capture
  app.dart                   # MaterialApp.router
  router/                    # route constants and router factory
  theme/                     # palette tokens and Plus Jakarta Sans theme
  data/
    models.dart              # typed models
    projects_data.dart       # published apps + development projects
    profile_data.dart        # profile, skills, experience, education, contact
  pages/                     # home, shared project detail, not found
  sections/                  # hero, apps, projects, experience, skills, ...
  widgets/                   # navbar, showcase card, QR tile, mockup, ...
assets/
  google_fonts/              # Plus Jakarta Sans + SIL OFL license
  icons/                     # authentic owner-supplied app icons
  screenshots/<slug>/        # authentic owner-supplied screenshots
web/
  favicon.png                # AR monogram
  icons/                     # PWA icons (any + maskable)
  index.html, manifest.json
test/                        # data, routing, widgets, responsive checks
```

## Content is data-driven

`lib/data/projects_data.dart` is the single source of truth. The showcase and
detail page are shared widgets; adding a published app does **not** require
new layout code.

### Add a published app

1. Add a `PublishedApp` entry with `name`, `slug`, `tagline`, `summary`,
   `tags`, `features`, `screenshots`, and `playStoreUrl`.
2. Drop screenshots in `assets/screenshots/<slug>/` and add **that folder** to
   the `assets:` list in `pubspec.yaml` (Flutter only bundles files directly
   inside a listed directory, so nested folders need their own entry).
3. Optionally add an icon at `assets/icons/<slug>.png` and set `iconPath` on
   the entry. `assets/icons/` is already registered in `pubspec.yaml`.
4. The detail route `/projects/<slug>`, the Google Play button, and the QR
   payload are all derived from that entry. No extra wiring is needed.

Development projects live in `developmentProjects`. A GitHub button appears
only when `githubUrl` is a real, owner-supplied URL.

### QR codes

`PublishedApp.qrPayload` returns `playStoreUrl`, and both the showcase and the
detail page pass the same value to the Play button and the QR tile. The check
is enforced by `test/data_integrity_test.dart`; there is no way for the two to
drift apart without a failing test.

## Routing and deep links

- Detail pages use path URLs. A direct load or refresh requires the host to
  serve `index.html` for unknown paths.
- Home anchor links (`/#experience`) are read from `Uri.base.fragment` in
  `main()` before the path strategy normalizes the URL, then scrolled to after
  the first layout.
- Keyboard focus, visible focus rings, and reduced-motion preferences are
  handled in the theme and section scroll logic.

## Deploy to GitHub Pages

The repository is configured for a **project site** at
`https://<user>.github.io/<repo>/`.

1. Build with the repository name as the base path:

   ```powershell
   flutter build web --release --base-href "/<repo>/"
   ```

2. Copy `index.html` to `404.html` in the build output. GitHub Pages serves
   this file for unknown paths, letting Flutter boot and `go_router` resolve
   the deep link instead of returning a 404 page:

   ```powershell
   Copy-Item build\web\index.html build\web\404.html
   ```

3. Publish the contents of `build/web` to the `gh-pages` branch, for example
   with the `gh-pages` npm package or a Pages deployment action.
4. In **Settings → Pages**, choose **Deploy from a branch → `gh-pages` → `/`
   (root)**.

For a user/org site (`https://<user>.github.io/`), build with
`--base-href "/"` instead. Do not open `build/web/index.html` through
`file://`; browser module restrictions prevent the app from booting.

### Verify the built site locally

A plain static server returns 404 for `/projects/...` on refresh, so use an SPA
fallback (or the copied `404.html` on GitHub Pages):

```powershell
npx serve build/web -l 8080 --single
```

Then open <http://127.0.0.1:8080/> and confirm that refreshing
`/projects/cma-stock` still loads the detail page.

## Validation

```powershell
dart format lib test
flutter analyze
flutter test
flutter build web --release
```

The test suite covers:

- project data integrity, exact Play Store URLs, and QR/Play URL equality
- slug routing, direct detail loads, and anchor scrolling
- showcase/detail widgets, empty-feature handling, and placeholders
- responsive layouts at 390, 768, 1024, and 1280 px
- navbar behavior at mobile and desktop widths

## Owner-supplied content status

- **CMA Stock** — official app icon and 3 authentic screenshots included.
- **FocusTime** — official app icon and 4 authentic screenshots included;
  stack (Flutter, Riverpod) and feature list confirmed by the owner.
- **Agrisight** — public repository linked. By owner choice, the card shows
  only its title, description, and technology stack — no icon or screenshots.
- A downloadable resume is intentionally omitted (owner opted out). If a PDF
  is added at `web/resume.pdf`, the Download Resume CTA can be restored in
  `lib/sections/hero_section.dart`.

## Font license

Plus Jakarta Sans is licensed under the **SIL Open Font License, Version 1.1**.
The license text is included at `assets/google_fonts/OFL.txt`, and the fonts
are bundled locally so the site does not depend on a font CDN.
