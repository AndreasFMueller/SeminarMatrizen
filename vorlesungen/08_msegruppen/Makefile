#
# Makefile -- gruppen
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	gruppen-handout.pdf MathSemMSE-08-gruppen.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSemMSE-08-gruppen.pdf:	MathSemMSE-08-gruppen.tex $(SOURCES)
	pdflatex MathSemMSE-08-gruppen.tex

gruppen-handout.pdf:	gruppen-handout.tex $(SOURCES)
	pdflatex gruppen-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSemMSE-08-gruppen.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-08-gruppen.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSemMSE-08-gruppen.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-08-gruppen.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

