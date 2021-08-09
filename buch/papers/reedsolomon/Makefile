#
# Makefile -- make file for the paper reedsolomon
#
# (c) 2020 Prof Dr Andreas Mueller
#

SOURCES := \
	anwendungen.tex \
	codebsp.tex \
	decmitfehler.tex \
	decohnefehler.tex \
	dtf.tex \
	einleitung.tex \
	endlichekoerper.tex \
	hilfstabellen.tex \
	idee.tex \
	main.tex \
	packages.tex \
	rekonstruktion.tex \
	restetabelle1.tex \
	restetabelle2.tex \
	standalone.tex \
	zusammenfassung.tex

TIKZFIGURES := \
	tikz/polynom2.tex \
	tikz/fourier.tex

FIGURES := $(patsubst tikz/%.tex, figures/%.pdf, $(TIKZFIGURES))


all: images standalone


.PHONY: images
images: $(FIGURES)

figures/%.pdf: tikz/%.tex
	mkdir -p figures
	pdflatex --output-directory=figures $<

.PHONY: standalone
standalone: standalone.tex $(SOURCES) $(FIGURES)
	mkdir -p standalone
	cd ../..; \
		pdflatex \
			--halt-on-error \
			--shell-escape \
			--output-directory=papers/reedsolomon/standalone \
			papers/reedsolomon/standalone.tex;
	cd standalone; \
		bibtex standalone; \
		makeindex standalone;


