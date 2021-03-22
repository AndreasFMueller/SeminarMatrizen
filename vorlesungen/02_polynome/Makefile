#
# Makefile -- polynome
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	polynome-handout.pdf MathSem-02-polynome.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-02-polynome.pdf:	MathSem-02-polynome.tex $(SOURCES)
	pdflatex MathSem-02-polynome.tex

polynome-handout.pdf:	polynome-handout.tex $(SOURCES)
	pdflatex polynome-handout.tex

thumbnail:	thumbnail.jpg

thumbnail.pdf:	MathSem-02-polynome.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-02-polynome.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

