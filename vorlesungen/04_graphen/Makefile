#
# Makefile -- graphen
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	graphen-handout.pdf MathSem-04-graphen.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-04-graphen.pdf:	MathSem-04-graphen.tex $(SOURCES)
	pdflatex MathSem-04-graphen.tex

graphen-handout.pdf:	graphen-handout.tex $(SOURCES)
	pdflatex graphen-handout.tex

thumbnail:	thumbnail.jpg fix1.jpg title.jpg

thumbnail.pdf:	MathSem-04-graphen.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-04-graphen.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-04-graphen.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-04-graphen.pdf 187
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

title.jpg:	fix1.jpg 
	convert -extract 1620x620+340+150 fix1.jpg title.jpg
