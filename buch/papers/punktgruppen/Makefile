#
# Makefile -- make file for the paper punktgruppen
#
# (c) 2020 Prof Dr Andreas Mueller
#

TIKZFIGURES := \
	tikz/combine-symmetries.tex \
	tikz/lattice.tex \
	tikz/piezo-atoms.tex \
	tikz/piezo.tex \
	tikz/projections.tex

FIGURES := $(patsubst tikz/%.tex, figures/%.pdf, $(TIKZFIGURES))

.PHONY: images
images: $(FIGURES)

figures/%.pdf: tikz/%.tex
	mkdir -p figures
	pdflatex --output-directory=figures $<

