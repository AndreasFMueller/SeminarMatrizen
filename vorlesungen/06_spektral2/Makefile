#
# Makefile -- spektral2
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	spektral2-handout.pdf MathSem-06-spektral2.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-06-spektral2.pdf:	MathSem-06-spektral2.tex $(SOURCES)
	pdflatex MathSem-06-spektral2.tex

spektral2-handout.pdf:	spektral2-handout.tex $(SOURCES)
	pdflatex spektral2-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSem-06-spektral2.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-06-spektral2.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-06-spektral2.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-06-spektral2.pdf 65
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

spektralradius.jpg:	fix1.jpg Makefile
	convert -extract 660x620+300+400 fix1.jpg spektralradius.jpg
