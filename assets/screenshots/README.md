# App screenshots

Authentic screenshots supplied by the owner, one folder per published app slug:

```
assets/screenshots/
  cma-stock/     → dashboard, stock list, stock request (720×1600 JPG)
  focustime/     → timer, tasks, analytics, break (1080×~1950 PNG)
```

They are referenced from `lib/data/projects_data.dart` in each app's
`screenshots` list. The order matters: the first screenshot is shown in the
home-page showcase, and all of them appear in the detail-page gallery.

When adding new images, prefer PNG or JPG at a portrait phone aspect ratio
(roughly 1080×2340 or larger), one screen per image, and add their paths to the
matching app entry.
