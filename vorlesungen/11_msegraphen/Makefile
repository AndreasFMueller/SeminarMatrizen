#
# Makefile -- graphen
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	graphen-handout.pdf MathSemMSE-11-graphen.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSemMSE-11-graphen.pdf:	MathSemMSE-11-graphen.tex $(SOURCES)
	pdflatex MathSemMSE-11-graphen.tex

graphen-handout.pdf:	graphen-handout.tex $(SOURCES)
	pdflatex graphen-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSemMSE-11-graphen.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-11-graphen.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSemMSE-11-graphen.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-11-graphen.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

