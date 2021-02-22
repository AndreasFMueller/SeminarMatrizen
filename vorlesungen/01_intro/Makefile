#
# Makefile -- intro
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	intro-handout.pdf MathSem-01-intro.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-01-intro.pdf:	MathSem-01-intro.tex $(SOURCES)
	pdflatex MathSem-01-intro.tex

intro-handout.pdf:	intro-handout.tex $(SOURCES)
	pdflatex intro-handout.tex

thumbnail:	thumbnail.jpg

thumbnail.pdf:	MathSem-01-intro.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-01-intro.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

