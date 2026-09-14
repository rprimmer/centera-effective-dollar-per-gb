LATEXMK ?= latexmk

.PHONY: all pdf clean clean-all distclean overleaf help

all: pdf

# latexmk discovers dependencies (including figures) and resolves references.
pdf:
	$(LATEXMK) centera-egb.tex

# Restrict cleanup to generated files in build/; retain the finished PDF.
clean:
	$(LATEXMK) -c centera-egb.tex

clean-all: distclean

distclean:
	$(LATEXMK) -C centera-egb.tex

overleaf:
	python3 scripts/package-overleaf.py

help:
	@echo 'make            Build build/centera-egb.pdf with pdfLaTeX'
	@echo 'make clean      Remove build intermediates; keep the PDF'
	@echo 'make distclean  Remove build intermediates and the generated PDF'
	@echo 'make overleaf   Package editable sources in dist/centera-egb-overleaf.zip'
