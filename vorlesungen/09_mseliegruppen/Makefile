#
# Makefile -- liegruppen
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	liegruppen-handout.pdf MathSemMSE-09-liegruppen.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSemMSE-09-liegruppen.pdf:	MathSemMSE-09-liegruppen.tex $(SOURCES)
	pdflatex MathSemMSE-09-liegruppen.tex

liegruppen-handout.pdf:	liegruppen-handout.tex $(SOURCES)
	pdflatex liegruppen-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSemMSE-09-liegruppen.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-09-liegruppen.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSemMSE-09-liegruppen.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-09-liegruppen.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

