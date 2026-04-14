# CLAUDE.md — selenide-web

## Project overview

Official website for **Selenide** (selenide.org) — a Java UI test automation framework built on Selenium WebDriver. This is a Hugo static site hosted on GitHub Pages from the `selenide/selenide.github.io` repository.

## Tech stack

- **Hugo** static site generator
- **Goldmark** for Markdown rendering (with `unsafe: true` for raw HTML in content)
- **Go templates** for layouts
- **jQuery 3.6.0** + jQuery UI 1.13.1 (from CDN)
- Custom theme "Ingmar" (inlined in `layouts/` and `assets/themes/ingmar/`)

## Directory structure

```
hugo.toml            Main Hugo config
content/
  _index.md          Homepage (content in layouts/index.html)
  blog/              Blog posts (185+ files), _index.md is the blog list
  documentation/     _index.md + sub-pages (page-objects, screenshots, reports, clouds, selenide-vs-selenium)
  quick-start.md, faq.md, users.md, quotes.md, contacts.md, javadoc.md, thanks.md
layouts/
  _default/          baseof.html, single.html, list.html, users.html
  blog/              single.html (post), list.html (blog index with year/month grouping)
  partials/          donate.html, main-menu.html, documentation-menu.html, quicklinks.html, title.html, analytics.html
  shortcodes/        selenide-version.html, selenium-changelog.html, documentation-menu.html
  index.html         Homepage template
  404.html           Custom 404
assets/
  themes/ingmar/css/ CSS files (processed via Hugo Pipes for fingerprinting)
static/
  images/            Logos, screenshots — year-based subdirs (images/2024/, etc.)
  assets/themes/ingmar/js/  JavaScript files
  test-page/         HTML test pages for Selenide demos
  CNAME, favicon.ico, robots.txt
data/
  users.json         Companies using Selenide
  user_tags.json     Tags for filtering users page
```

## Key config (hugo.toml)

- `params.selenideVersion = "7.16.0"` — used via `{{</* selenide-version */>}}` shortcode in content
- `params.seleniumChangelog` — Selenium changelog URL, used via `{{</* selenium-changelog */>}}` shortcode
- Blog permalinks: `/:year/:month/:day/:title/`
- Pages use `url:` in front matter for explicit URLs (e.g., `/quick-start.html`)
- `buildFuture = true` — builds future-dated posts
- `markup.goldmark.renderer.unsafe = true` — allows raw HTML in Markdown

## Local development

```bash
# Install Hugo (macOS)
brew install hugo

# Serve locally
./start.sh
# or manually:
hugo server --buildFuture --port 4001
```

Output goes to `public/` directory.

## Creating content

### New blog post

Create `content/blog/YYYY-MM-DD-slug-name.md`:

```yaml
---
date: YYYY-MM-DD
title: "Post Title"
description: ""
category:
headerText: "Short tagline"
tags: []
---

Content here...
```

### New page

Create in `content/` with `url:` for the desired path:

```yaml
---
title: "Page Title"
header: "Display Header"
cssClass: my-class
url: /page-name.html
headerText: "Subtitle"
---
```

## Shortcodes

- `{{</* selenide-version */>}}` — outputs current Selenide version from `hugo.toml`
- `{{</* selenium-changelog */>}}` — outputs Selenium changelog URL
- `{{</* documentation-menu */>}}` — renders docs sidebar menu

## Conventions

- Blog posts are mostly Selenide release announcements, following the pattern "Released Selenide X.Y.Z"
- Posts use anchor-linked table of contents at the top for sections
- Images go in `static/images/` — use year-based subdirectories (e.g., `images/2026/`)
- Company logos for the users page go in `static/images/`
- Pages that use `layout: users` get the custom users template with data-driven content
- When releasing a new Selenide version: update `params.selenideVersion` in `hugo.toml`, create a release blog post

## Layout hierarchy

```
baseof.html (HTML shell, head, header, footer)
  └── block "main" filled by:
      ├── index.html (homepage)
      ├── blog/single.html (blog posts)
      ├── blog/list.html (blog index)
      ├── _default/single.html (regular pages)
      ├── _default/users.html (users page)
      └── 404.html
```

## Deployment

The site deploys to GitHub Pages. The `static/CNAME` file sets the custom domain `selenide.org`.
A GitHub Actions workflow runs `hugo` and deploys the `public/` directory.
