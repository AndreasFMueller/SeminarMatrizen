#
# Makefile -- galois
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	galois-handout.pdf MathSemMSE-06-galois.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSemMSE-06-galois.pdf:	MathSemMSE-06-galois.tex $(SOURCES)
	pdflatex MathSemMSE-06-galois.tex

galois-handout.pdf:	galois-handout.tex $(SOURCES)
	pdflatex galois-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSemMSE-06-galois.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-06-galois.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSemMSE-06-galois.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-06-galois.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

