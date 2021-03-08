#
# Makefile -- analysis
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	analysis-handout.pdf MathSemMSE-03-analysis.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSemMSE-03-analysis.pdf:	MathSemMSE-03-analysis.tex $(SOURCES)
	pdflatex MathSemMSE-03-analysis.tex

analysis-handout.pdf:	analysis-handout.tex $(SOURCES)
	pdflatex analysis-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSemMSE-03-analysis.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-03-analysis.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSemMSE-03-analysis.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-03-analysis.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

