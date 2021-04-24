#
# Makefile -- liealgebra
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	liealgebra-handout.pdf MathSemMSE-10-liealgebra.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSemMSE-10-liealgebra.pdf:	MathSemMSE-10-liealgebra.tex $(SOURCES)
	pdflatex MathSemMSE-10-liealgebra.tex

liealgebra-handout.pdf:	liealgebra-handout.tex $(SOURCES)
	pdflatex liealgebra-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSemMSE-10-liealgebra.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-10-liealgebra.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSemMSE-10-liealgebra.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-10-liealgebra.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

