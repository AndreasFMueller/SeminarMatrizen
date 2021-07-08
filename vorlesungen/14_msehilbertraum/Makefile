#
# Makefile -- hilbertraum
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	hilbertraum-handout.pdf MathSemMSE-14-hilbertraum.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSemMSE-14-hilbertraum.pdf:	MathSemMSE-14-hilbertraum.tex $(SOURCES)
	pdflatex MathSemMSE-14-hilbertraum.tex

hilbertraum-handout.pdf:	hilbertraum-handout.tex $(SOURCES)
	pdflatex hilbertraum-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSemMSE-14-hilbertraum.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-14-hilbertraum.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSemMSE-14-hilbertraum.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSemMSE-14-hilbertraum.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

