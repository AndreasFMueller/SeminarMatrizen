#
# Makefile -- make file for the paper punktgruppen
#
# (c) 2020 Prof Dr Andreas Mueller
#
SOURCES := \
	crystals.tex \
	intro.tex \
	main.tex \
	piezo.tex \
	symmetry.tex

TIKZFIGURES := \
	tikz/combine-symmetries.tex \
	tikz/lattice.tex \
	tikz/piezo-atoms.tex \
	tikz/piezo.tex \
	tikz/projections.tex \
	tikz/symmetric-shapes.tex

FIGURES := $(patsubst tikz/%.tex, figures/%.pdf, $(TIKZFIGURES))

.PHONY: images
images: $(FIGURES)

figures/%.pdf: tikz/%.tex
	mkdir -p figures
	pdflatex --output-directory=figures $<

.PHONY: standalone
standalone: standalone.tex $(SOURCES)
	mkdir -p standalone
	cd ../..; \
		pdflatex \
			--halt-on-error \
			--shell-escape \
			--output-directory=papers/punktgruppen/standalone \
			papers/punktgruppen/standalone.tex;
	cd standalone; \
		bibtex standalone; \
		makeindex standalone;
