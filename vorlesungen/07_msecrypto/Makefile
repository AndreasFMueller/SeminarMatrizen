#
# Makefile -- crypto
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	crypto-handout.pdf MathSemMSE-07-crypto.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSemMSE-07-crypto.pdf:	MathSemMSE-07-crypto.tex $(SOURCES)
	pdflatex MathSemMSE-07-crypto.tex

crypto-handout.pdf:	crypto-handout.tex $(SOURCES)
	pdflatex crypto-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSemMSE-07-crypto.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-07-crypto.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSemMSE-07-crypto.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-07-crypto.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

