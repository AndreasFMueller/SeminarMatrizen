#
# Makefile -- endlichekoerper
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	endlichekoerper-handout.pdf MathSemMSE-05-endlichekoerper.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSemMSE-05-endlichekoerper.pdf:	MathSemMSE-05-endlichekoerper.tex $(SOURCES)
	pdflatex MathSemMSE-05-endlichekoerper.tex

endlichekoerper-handout.pdf:	endlichekoerper-handout.tex $(SOURCES)
	pdflatex endlichekoerper-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSemMSE-05-endlichekoerper.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-05-endlichekoerper.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSemMSE-05-endlichekoerper.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-05-endlichekoerper.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

