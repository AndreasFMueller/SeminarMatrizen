#
# Makefile -- wkeitsmatrizen
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	wkeitsmatrizen-handout.pdf MathSemMSE-12-wkeitsmatrizen.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSemMSE-12-wkeitsmatrizen.pdf:	MathSemMSE-12-wkeitsmatrizen.tex $(SOURCES)
	pdflatex MathSemMSE-12-wkeitsmatrizen.tex

wkeitsmatrizen-handout.pdf:	wkeitsmatrizen-handout.tex $(SOURCES)
	pdflatex wkeitsmatrizen-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSemMSE-12-wkeitsmatrizen.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-12-wkeitsmatrizen.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSemMSE-12-wkeitsmatrizen.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-12-wkeitsmatrizen.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

