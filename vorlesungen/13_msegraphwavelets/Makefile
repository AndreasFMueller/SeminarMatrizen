#
# Makefile -- graphwavelets
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	graphwavelets-handout.pdf MathSemMSE-13-graphwavelets.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSemMSE-13-graphwavelets.pdf:	MathSemMSE-13-graphwavelets.tex $(SOURCES)
	pdflatex MathSemMSE-13-graphwavelets.tex

graphwavelets-handout.pdf:	graphwavelets-handout.tex $(SOURCES)
	pdflatex graphwavelets-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSemMSE-13-graphwavelets.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-13-graphwavelets.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSemMSE-13-graphwavelets.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-13-graphwavelets.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

