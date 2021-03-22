#
# Makefile -- spektral
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	spektral-handout.pdf MathSemMSE-02-spektral.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSemMSE-02-spektral.pdf:	MathSemMSE-02-spektral.tex $(SOURCES)
	pdflatex MathSemMSE-02-spektral.tex

spektral-handout.pdf:	spektral-handout.tex $(SOURCES)
	pdflatex spektral-handout.tex

thumbnail:	thumbnail.jpg

thumbnail.pdf:	MathSem-02-spektral.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-02-spektral.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

