# Critical Coding – Code Samples

Jekyll site listing the coding examples of the [ZHdK-Critical-Coding](https://github.com/ZHdK-Critical-Coding) organisation.
Published with GitHub Pages at https://zhdk-critical-coding.github.io/.

- **Start page text:** `index.md` (Code Samples), `utilities.md` (Utilities)
- **Main categories and their columns:** `main_categories` in `_config.yml`; the header dropdown switches between them.
  A page shows one column per category that has examples, in equal widths.
- **Layout / design:** `_layouts/`, `assets/css/style.css`
- **Detail pages:** generated into `_examples/` by `scripts/update.rb` – don't edit them by hand

## Adding an example

Put an `example.yaml` in the root of the example repository:

```yaml
name: "Joystick"            # title on the page
date: 2026-09-16
author: Urs Hofer
technology: "P5.js"         # shown right of the title
maincategory: code-samples  # page: code-samples | utilities
category: input             # column on that page – code-samples: input | transformation | output
                            #                       utilities: servers | arduino
readme: "sub/readme.md"     # optional, if the README is not in the repo root
readme_de: "sub/README_DE.md" # optional, if the German README is not next to the README
related: Servers_Pusher     # optional, repo name or list of names, linked above the README
                            # (examples that need a server relate to its repository)
```

A `screenshot.png` (640 px wide) in the repository root is shown in the sidebar below the details.

Repositories without `example.yaml` are ignored. The README becomes the detail page;
images referenced in it are copied into the site, other relative links point to GitHub.

### README structure

Every example has an English `README.md` and a German `README_DE.md` next to it.
If both exist, the detail page shows an EN / DE switch (the choice is remembered).

```markdown
# P5.js: Joystick               <- "technology: name" from example.yaml

[Deutsch](README_DE.md)          <- in README_DE.md: [English](README.md); hidden on the site

Short abstract, 2–4 sentences.

## Installation                  <- requirements, setup, libraries

## Server                        <- only if the sketch needs a server: which one, port, address in the sketch

## How to Run                    <- DE: "Ausführen"; starting it and using it

## Coding Help                   <- DE: "Coding-Hilfe"; what happens in which part of the code
```

## Updating

```sh
bundle exec ruby scripts/update.rb                  # pull all repos of the organisation from GitHub
bundle exec ruby scripts/update.rb --local ../Examples  # or read existing local clones
bundle exec jekyll serve                    # preview on http://127.0.0.1:4000/
```

The script prints which repositories have no `example.yaml`, no or an empty README, or an invalid main category / category.
Private repositories need a token: `GITHUB_TOKEN`/`GH_TOKEN`, otherwise git's stored github.com credentials are used.

Commit and push the result – or let GitHub do it (see below).

## Automatic updates

`.github/workflows/pages.yml` runs the update script and deploys the site on every push, nightly, manually, and on a `repository_dispatch` of type `example-updated`.

One-time setup:

1. *Settings → Pages → Source:* **GitHub Actions**.
2. *Settings → Secrets → Actions:* add `EXAMPLES_TOKEN`, a fine-grained token for the ZHdK-Critical-Coding organisation with read-only access to *Contents* and *Metadata* of all repositories.
3. Optional, rebuild immediately when an example is pushed: add `docs/notify-site.yml` to the example repos (or as an organisation workflow template) and an organisation secret `SITE_DISPATCH_TOKEN` that can write to this repository. Without it, new examples show up after the nightly build.
