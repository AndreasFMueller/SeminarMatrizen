#
# Makefile -- spektral1
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	spektral1-handout.pdf MathSem-05-spektral1.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-05-spektral1.pdf:	MathSem-05-spektral1.tex $(SOURCES)
	pdflatex MathSem-05-spektral1.tex

spektral1-handout.pdf:	spektral1-handout.tex $(SOURCES)
	pdflatex spektral1-handout.tex

thumbnail:	thumbnail.jpg fix1.jpg

thumbnail.pdf:	MathSem-05-spektral1.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-05-spektral1.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-05-spektral1.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-05-spektral1.pdf 92
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

jordan.jpg:	fix1.jpg Makefile
	convert -extract 873x873+967+199 fix1.jpg jordan.jpg
