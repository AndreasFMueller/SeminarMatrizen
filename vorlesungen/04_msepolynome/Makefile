#
# Makefile -- polynome
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	polynome-handout.pdf MathSemMSE-04-polynome.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSemMSE-04-polynome.pdf:	MathSemMSE-04-polynome.tex $(SOURCES)
	pdflatex MathSemMSE-04-polynome.tex

polynome-handout.pdf:	polynome-handout.tex $(SOURCES)
	pdflatex polynome-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSemMSE-04-polynome.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-04-polynome.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSemMSE-04-polynome.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-04-polynome.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

