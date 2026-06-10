# template.tex

LaTeX template for physics papers in APS/PRB style, with a full CI/CD pipeline on GitHub Actions.

## Features

- **revtex4-2** with PRB two-column layout
- **LuaLaTeX** engine via latexmk
- **Automated release pipeline**: compile paper, latexdiff against previous version, and supplementary material on every semver tag
- **arXiv bundle**: auto-packaged `.tex` + `.bbl` + figures zip ready for submission
- **DOI verification**: every reference in `references.bib` is validated against Crossref/arXiv via [doiget](https://github.com/sotashimozono/doiget)
- **Dependabot**: GitHub Actions versions updated monthly

## Quick start

Click **Use this template** on GitHub, then clone your new repository.

## Local build

Requirements: TeX Live (with LuaLaTeX, latexmk, bibtex), Zed or any editor with texlab LSP.

```sh
latexmk main.tex        # compile → out/main.pdf
latexmk -c              # clean auxiliaries
latexmk -C              # clean including out/
```

The local build reads `.latexmkrc` and outputs to `out/`.

## File structure

```
main.tex            # paper source (single file)
supplemental.tex    # supplementary material (optional, create when needed)
references.bib      # bibliography (BibTeX format)
figures/            # figures in PDF format only
notes/              # scratch notes, not compiled
.latexmkrc          # build recipe (LuaLaTeX + BibTeX, out/ dir)
```

## Revision markup

Four commands are defined in `main.tex` for tracking changes during review:

| Command | Color | Purpose |
|---|---|---|
| `\sh{text}` | green | author edit |
| `\ch{text}` | blue | collaborator edit |
| `\rev{text}` | red | response to reviewer |
| `\remove{text}` | strikethrough | deletion |

Comment out the `xcolor`/`ulem` block before final submission.

## Versioning

The current version is stored in `VERSION` (e.g. `1.2.0`). The git tag `v{VERSION}` is the release identifier. `Release.yml` verifies they match before building.

### Auto-bump on PR merge

Add `[patch]`, `[minor]`, or `[major]` anywhere in a PR title or body. When the PR is merged to `main`, `AutoBump.yml` increments `VERSION`, commits it, creates the tag, and pushes — triggering the full release pipeline automatically.

| Keyword | Example: 1.2.3 → |
|---|---|
| `[patch]` | 1.2.4 |
| `[minor]` | 1.3.0 |
| `[major]` | 2.0.0 |

PRs without a keyword are merged without triggering a release.

### Manual release

From the Actions tab, run **Release** with the target version (without `v`):

```sh
gh workflow run Release.yml --field version=1.0.0
```

The pipeline builds in parallel and attaches to the GitHub Release:

| File | Contents |
|---|---|
| `paper-v1.0.0.pdf` | compiled paper |
| `diff-v1.0.0.pdf` | latexdiff against previous tag (skipped on first tag) |
| `supplemental-v1.0.0.pdf` | supplementary (only if `supplemental.tex` exists) |
| `arxiv-bundle-v1.0.0.zip` | `main.tex` + `main.bbl` + `figures/*.pdf` for arXiv submission |

## Supplementary material

Create `supplemental.tex` in the repository root. It is compiled independently and included in the release automatically.

## DOI verification

Runs automatically when `references.bib` changes. Can also be triggered manually from the Actions tab. Currently non-strict (unresolvable DOIs warn but do not fail the build).

## License

MIT
