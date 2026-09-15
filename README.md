# Centera effective dollar per GB

Revised LaTeX edition of *Storage Cost: A Formal Model for Effective $/GB and
Storage Efficiency for Centera*, version 1.00, October 25, 2005, by Robert
Primmer, Jiri Schindler, Jim Espy, and Carl D'Halluin.

## Read the paper

[**Read or download the final PDF**](centera-egb.pdf). No build tools are required.

The top-level PDF is tracked in Git. Running `make` refreshes it from the
compiled copy in `build/`; commit both source changes and the refreshed PDF.
Cleanup commands retain the top-level PDF.

## Build

Install a TeX distribution with pdfLaTeX, latexmk, and the packages listed in
[preamble.tex](preamble.tex), then run from this directory:

```sh
make                 # build and refresh centera-egb.pdf
make clean           # remove intermediates, retain the PDF
make distclean       # remove build outputs; retain top-level PDF
make overleaf        # dist/centera-egb-overleaf.zip
```

`make clean-all` aliases `make distclean`. Directly running `latexmk` or
`latexmk centera-egb.tex` uses the same [.latexmkrc](.latexmkrc). An unchanged
build does no typesetting work. No office suite, Pandoc, Ghostscript, Python,
or files from `attic/` are needed to build the converted paper.

Use [centera-egb.tex](centera-egb.tex) as the editor root document, with this
project directory as the working directory. The PDF is compiled in `build/` and copied to the top level by `make`.

## Layout

The layout follows the [RDOS paper](https://github.com/rprimmer/Relational-Distributed-Object-Store)
and the [fix-hosts algebra paper](https://github.com/rprimmer/fix-hosts-c/tree/main/algebra):
a named root document, shared configuration, numbered sections, figure assets,
and a separate build directory.

```text
Centera Effective Dollar per GB/
├── centera-egb.tex
├── preamble.tex
├── macros.tex
├── metadata.tex
├── sections/
│   ├── 00-abstract.tex
│   ├── 01-models.tex
│   ├── 02-notation.tex
│   ├── 03-equations.tex
│   ├── 04-model-considerations.tex
│   ├── 05-emc-cost-categorization.tex
│   ├── 06-references.tex
│   └── 07-acknowledgements.tex
├── fig/                     # editable TikZ sources and original PDF crops
├── Makefile
├── .latexmkrc
├── .gitignore
├── README.md
├── build/                   # generated and ignored
├── attic/                   # unchanged originals, locally retained and ignored
└── .conversion-baseline/    # local conversion and verification records, ignored
```

The root document controls section order and page divisions.
[preamble.tex](preamble.tex) controls typography and packages;
[macros.tex](macros.tex) numbers equations within their section;
[metadata.tex](metadata.tex) contains the title, authors, version, and date.
The eight references remain in [sections/06-references.tex](sections/06-references.tex)
to preserve their original numbering and the separate “Ibid.” entries.

## Source and editorial revision

The initial conversion used the Word and ODT text and the original PDF's
mathematics and diagrams. The source title, authors, and historical
date remain, with the document version identified as revised.

The nine original office and PDF files remain unchanged in [attic/](attic/).
The initial conversion is retained in the ignored
`.conversion-baseline/before-editorial-revision/` directory. The six original
diagrams remain vector PDFs in [fig/](fig/) for reference. The manuscript now
uses editable TikZ sources in the same directory. These are conceptual
illustrations, not measured plots. The object-limit diagram uses separate
CPP and CPM capacity plateaus and omits unverified numeric thresholds.
Protection overhead is labeled as the lost fraction `1-P`, consistent with
the model's definition of `P` as efficiency.

## Corrections

- Equations now use section-based numbering, (3.1)–(3.23), with generated
  cross-references throughout the paper.
- M0–M5 consistently represent cost or price per GB. Fixed overhead reduces
  capacity in the denominator; protection efficiency divides cost per GB;
  M4 follows M3, and M5 uses actual usable capacity.
- Field uplift is a fractional rate, applied as `1 + u`. Raw material cost,
  uplifted cost, and selling price have distinct symbols.
- Disk configurations are tuples rather than mathematical sets of repeated
  equal elements. Physical node counts are distinct from occupied rack-space
  units, preventing double-counting Gen 5 disk capacity.
- H includes H3. Release-specific overhead constants are separate for database,
  audit/metadata, and per-disk system reservations.
- 500 GB is approximately 465.66 GiB: a 6.87% smaller numerical value, with no
  physical capacity loss. Object sizes must use the same units as capacity.
- Capacity-per-object expressions consistently use `(m+n)/m`.
- Mixed protection uses explicit CPM/CPP parameters, cube-local node and
  capacity values, and the actual number of populated cubes. Count-based
  capacity fractions explicitly assume equal available capacity per node.
- Object-count limits apply within each modeled partition before aggregation.
  Lost logical capacity cannot be negative. Actual usable capacity subtracts
  this loss from the CDF-aware capacity, and cost per usable GB uses that actual
  capacity. The distinction between logical loss and unused raw space is explicit.
- CDF-aware and protection-only capacities converge as relative CDF size tends
  to zero; equality is no longer asserted for finite CDF size.
- Pseudocode separates data fragments, parity, and node eligibility. CPP's
  small-object threshold no longer blocks CPM fallback. Placement constraints
  are explicit implementation requirements rather than incomplete arithmetic.

## Configuration details still requiring evidence

The source describes both uniform cluster-wide regeneration reservations and
a special rule below eight nodes, without reconciling them. Equation (3.8)
therefore uses configured disk-reservation counts and the mirror-group factor,
with the ambiguity disclosed in the manuscript. It does not invent a release
policy. Reservation sizes, overhead constants, the CPP threshold and eligibility
rules must be checked against the actual historical release being modeled.

The partition object budgets in (3.20)–(3.21) are allocation inputs. They assume
balanced placement within each budget; their aggregate arithmetic is an upper
bound and does not prove feasibility on individual disks. Asymmetric nodes
require measured or explicitly modeled capacity allocations. Enclosure counts
must reflect the actual packing when it differs from the stated 32U/16U model.
The paper does not establish new empirical product behavior.

Historical reference URLs remain unverified. The original performance and
release forecasts are retained as historical statements.

## Validation

The revised formulas were checked with CPM and CPP numerical examples,
capacity-consumption identities, finite and negligible CDF sizes, mixed
partition bottlenecks, zero-capacity and zero-object-budget boundaries, and
uplift/gross-margin identities. Build and visual-review results are recorded
locally in `.conversion-baseline/`.

The editorial revision before the diagram redraw was 17 pages. Every page passed visual review; all 23
equation references resolve, and the final build has no LaTeX warnings or
box-overflow warnings. A clean build from the source and figure files passes.
The removed headings and confidentiality phrase are absent from the PDF;
checksums confirm that all nine archived originals remain unchanged.

## Editable diagrams and Overleaf

All six diagrams are native TikZ in [fig/](fig/); shared styling lives in
[fig/styles.tex](fig/styles.tex). The original PDF crops are no longer build
inputs. Diagram labels, geometry, colors, and lines can be edited in LaTeX.

Run `make overleaf` to create [dist/centera-egb-overleaf.zip](dist/centera-egb-overleaf.zip).
The package includes the manuscript, all TikZ sources, and
[OVERLEAF.md](OVERLEAF.md). It excludes archives, PDF crops, generated files,
and local validation records. Its `latexmkrc` lets Overleaf manage output
instead of using the local `build/` directory. Choose `centera-egb.tex` as the
main document and pdfLaTeX as the compiler.

The regenerated paper is 16 pages. The ZIP is also compiled after extraction
into a clean temporary directory to verify that all dependencies are included.
