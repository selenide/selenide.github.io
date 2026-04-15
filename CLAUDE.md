# CLAUDE.md — selenide-web

## Project overview

Official website for **Selenide** — a Java UI test automation framework built on Selenium WebDriver.
This single multilingual Hugo project powers both:
- `selenide.org` (English) — hosted on `selenide/selenide.github.io`
- `ru.selenide.org` (Russian) — hosted on `selenide/selenide-ru` (gh-pages branch)

## Tech stack

- **Hugo** static site generator (multilingual)
- **Goldmark** for Markdown rendering (with `unsafe: true` for raw HTML in content)
- **Go templates** for layouts
- **jQuery 3.6.0** + jQuery UI 1.13.1 (from CDN)
- Custom theme "Ingmar" (inlined in `layouts/` and `assets/themes/ingmar/`)

## Directory structure

```
hugo.toml            Main Hugo config (both languages)
hugo-en.toml         Override for EN-only production build
hugo-ru.toml         Override for RU-only production build
i18n/
  en.toml            English UI strings
  ru.toml            Russian UI strings
content/
  en/                English content (homepage, blog, docs, etc.)
  ru/                Russian content
layouts/
  _default/          baseof.html, single.html, list.html, users.html
  blog/              single.html (post), list.html (blog index)
  partials/          donate.html, main-menu.html, quicklinks.html, title.html, analytics.html
  shortcodes/        selenide-version.html, selenium-changelog.html, documentation-menu.html
  index.html         Homepage template (uses i18n)
  404.html           Custom 404
assets/
  themes/ingmar/css/ CSS files (processed via Hugo Pipes for fingerprinting)
static/
  images/            Logos, screenshots — year-based subdirs
  assets/themes/ingmar/js/  JavaScript
  CNAME, favicon.ico, robots.txt
data/
  users.json         Companies using Selenide
  user_tags.json     Tags for users page
```

## Local development

```bash
brew install hugo
./start.sh   # serves both languages: EN at /, RU at /ru/
```

## Production builds (each language at root)

```bash
# EN site (selenide.org)
hugo --config hugo.toml,hugo-en.toml --destination public-en

# RU site (ru.selenide.org)
hugo --config hugo.toml,hugo-ru.toml --destination public-ru
```

Each override toml sets `disableLanguages` and `defaultContentLanguage` so the chosen language sits at the site root.

## Creating content

### New blog post

Create under `content/en/blog/` or `content/ru/blog/` as `YYYY-MM-DD-slug.md`:

```yaml
---
date: YYYY-MM-DD
title: "Post Title"
description: ""
category:
headerText: "Short tagline"
tags: []
---
```

### New page

Create under `content/en/` or `content/ru/` with `url:` for the path:

```yaml
---
title: "Page Title"
url: /page-name.html
---
```

## Shortcodes

- `{{</* selenide-version */>}}` — current Selenide version from `hugo.toml`
- `{{</* selenium-changelog */>}}` — Selenium changelog URL
- `{{</* documentation-menu */>}}` — renders docs sidebar menu (localized)

## Internationalization

- UI strings live in `i18n/en.toml` and `i18n/ru.toml`, accessed via `{{ T "key" }}`
- Page content lives in language-specific `content/en/` and `content/ru/` trees
- Layouts branch on `.Site.Language.Lang` only when the structure itself differs (e.g. docs menu has extra links in RU)

## Conventions

- Blog posts are mostly release announcements: "Released Selenide X.Y.Z" / "Вышла Selenide X.Y.Z"
- Release posts should be added in BOTH `content/en/blog/` and `content/ru/blog/`
- Images go in `static/images/` — use year-based subdirectories
- When releasing a new Selenide version: update `params.selenideVersion` in `hugo.toml`, create release blog posts in both languages
- JavaScript lives in `static/assets/themes/ingmar/js/selenide.org.js` (single IIFE). Add new logic as a function and call it from the init block at the bottom. Avoid inline `<script>` tags in `layouts/` — keep partials markup-only. Bump the `?NNN` cache buster on the `<script src>` in `layouts/_default/baseof.html` when you change this file.

## Deployment

GitHub Actions (`.github/workflows/hugo.yml`):
1. **EN job** — builds EN site and deploys via `actions/deploy-pages` to this repo's Pages (selenide.org)
2. **RU job** — builds RU site and pushes via `peaceiris/actions-gh-pages` to `selenide/selenide-ru` repo's `gh-pages` branch (ru.selenide.org)

The RU cross-repo push requires a `RU_SELENIDE_ORG_DEPLOY_TOKEN` secret (PAT with push access to `selenide/selenide-ru`).
