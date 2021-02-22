#
# Makefile -- build the slide collection
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapeprswil
#
test:	test-handout.pdf test-presentation.pdf

slides:	slides-handout.pdf slides-presentation.pdf

include Makefile.inc

files = common.tex $(slides)

slides-handout.pdf:	slides-handout.tex slides.tex $(files)
	pdflatex slides-handout.tex

slides-presentation.pdf:	slides-presentation.tex slides.tex $(files)
	pdflatex slides-presentation.tex

test-handout.pdf:	test-handout.tex test.tex $(files)
	pdflatex test-handout.tex

test-presentation.pdf:	test-presentation.tex test.tex $(files)
	pdflatex test-presentation.tex

