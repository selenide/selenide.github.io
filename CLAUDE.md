# CLAUDE.md — selenide-web

## Project overview

Official website for **Selenide** (selenide.org) — a Java UI test automation framework built on Selenium WebDriver. This is a Jekyll-based static site hosted on GitHub Pages from the `selenide/selenide.github.io` repository.

## Tech stack

- **Jekyll 3.9.x** via the `github-pages` gem
- **Kramdown** for Markdown rendering
- **Liquid** templating
- **jQuery 3.6.0** + jQuery UI 1.13.1 (from CDN)
- Theme: **Ingmar** (custom, in `_includes/themes/ingmar/` and `assets/themes/ingmar/`)

## Directory structure

```
_posts/          Blog posts (release notes, tutorials) — 184+ files
_layouts/        Layout templates: default.html, post.html, page.html
_includes/       Partials: main_menu.md, documentation-menu.md, JB/ helpers, themes/ingmar/
_data/           users.json (companies using Selenide), user-tags.json
assets/          Theme CSS/JS/fonts under themes/ingmar/
documentation/   Sub-pages: page-objects, screenshots, reports, clouds, selenide-vs-selenium
images/          Logos, screenshots — organized by year (images/2024/, etc.)
test-page/       HTML test pages for Selenide demos (dropdown, draggable, clipboard, etc.)
ru/              Russian language content (minimal)
```

## Key config

- `_config.yml` — main Jekyll config
  - `SELENIDE_VERSION: "7.16.0"` — referenced in quick-start.md for Maven/Gradle snippets
  - `SELENIUM_CHANGELOG` — URL to Selenium's changelog
  - Permalink: `/:categories/:year/:month/:day/:title/`
  - Pages permalink: `/:path/:basename.html`
  - `keep_files: ["javadoc"]` — javadoc is preserved in `_site/`

## Local development

```bash
# Install dependencies
bundle install

# Serve locally (port 4001, livereload on 40001)
./start.sh
# Or manually:
bundle exec jekyll serve --future --incremental --safe --strict_front_matter \
  --host=0.0.0.0 --port=4001 \
  --livereload --livereload-port=40001 --watch --open-url
```

Requires Ruby (RVM with Ruby 2.7 per start.sh).

## Creating content

### New blog post

Use Rake: `rake post title="Released Selenide X.Y.Z"`

Or create manually in `_posts/` with filename `YYYY-MM-DD-slug-name.md`:

```yaml
---
layout: post
title: "Post Title"
description: ""
category:
header-text: "Short tagline"
tags: []
---
{% include JB/setup %}

Content here...
```

### New page

Use Rake: `rake page name="page-name.md"`

```yaml
---
layout: page
title: "Page Title"
header: "Display Header"
group: navigation        # optional, adds to nav
cssClass: my-class       # optional
header-text: "Subtitle"  # optional
---
{% include JB/setup %}
```

## Conventions

- Blog posts are mostly Selenide release announcements, following the pattern "Released Selenide X.Y.Z"
- Posts use anchor-linked table of contents at the top for sections
- `{% include JB/setup %}` is required after front matter in all posts and pages
- Images go in `images/` — use year-based subdirectories for blog post images (e.g., `images/2026/`)
- Company logos for the users page go directly in `images/`
- When releasing a new Selenide version: update `SELENIDE_VERSION` in `_config.yml`, create a release blog post, and publish javadoc

## Data files

- `_data/users.json` — array of companies using Selenide. Each entry: `name`, `id`, `link`, `logo`, `logoWidth`, `description`, `source`, `tags`
- `_data/user-tags.json` — tag strings for filtering users page (geographic, industry)

## Layout hierarchy

```
post.html / page.html
  └── default.html
        └── _includes/themes/ingmar/default.html  (actual HTML shell)
```

## Important paths

- `_includes/main_menu.md` — site-wide navigation menu
- `_includes/documentation-menu.md` — docs sidebar
- `assets/themes/ingmar/css/styles.css` — main stylesheet
- `assets/themes/ingmar/js/selenide.org.js` — main JS (news ticker, menu toggle, language switch)
- `CNAME` — custom domain: selenide.org

## Things to ignore

- `_site/` — generated output, not in version control (except `_site/javadoc`)
- `.jekyll-metadata` — Jekyll incremental build cache
