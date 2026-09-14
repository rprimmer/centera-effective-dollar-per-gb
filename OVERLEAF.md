# Overleaf source package

Upload `dist/centera-egb-overleaf.zip` as a new Overleaf project.
Set the main document to `centera-egb.tex` and the compiler to pdfLaTeX.
No shell escape, external conversion tools, or archived office files are needed.

## Editing

- `sections/*.tex`: manuscript text and equations.
- `metadata.tex`: title, authors, date, and version.
- `fig/*.tex`: six diagrams, drawn directly in TikZ.
- `fig/styles.tex`: shared colors, line styles, and label typography.
- `preamble.tex`: packages and page layout.

Each diagram has its own source file. Edit labels in `\node` commands and
coordinates in `\draw` commands. The enclosing `\resizebox` in the manuscript
controls its displayed width. No exported figure PDF needs to be regenerated.

The capacity illustrations are schematic, not measured data. The object-limit
figure uses separate capacity plateaus for CPP and CPM and intentionally omits
unverified numeric thresholds. The mixed-protection figure shows the historical
8-to-12-node illustration. Historical configuration uncertainties remain
identified in the manuscript.

Sections 8 and 9 and the confidentiality footer phrase have been removed.
The original author names, 2005 date, and revised-edition designation remain.

This ZIP uses `latexmkrc` without a custom output directory, because Overleaf
manages build output. For a clean local check after extracting the ZIP, run:

```sh
latexmk -pdf -interaction=nonstopmode -halt-on-error centera-egb.tex
```

The full local project retains its usual `build/`, `attic/`, and source layout.
Run `make overleaf` there to regenerate this source-only package.
