#
# Makefile -- vortraege
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	vortraege-handout.pdf MathSem-99-vortraege.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-99-vortraege.pdf:	MathSem-99-vortraege.tex $(SOURCES)
	pdflatex MathSem-99-vortraege.tex

vortraege-handout.pdf:	vortraege-handout.tex $(SOURCES)
	pdflatex vortraege-handout.tex

thumbnail:	thumbnail1.jpg thumbnail2.jpg thumbnail3.jpg thumbnail4.jpg 

thumbnail1.pdf:	MathSem-99-vortraege.pdf
	pdfjam --outfile thumbnail1.pdf --papersize '{16cm,9cm}' \
		MathSem-99-vortraege.pdf 1
thumbnail1.jpg:	thumbnail1.pdf
	convert -density 300 thumbnail1.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail1.jpg

thumbnail2.pdf:	MathSem-99-vortraege.pdf
	pdfjam --outfile thumbnail2.pdf --papersize '{16cm,9cm}' \
		MathSem-99-vortraege.pdf 2
thumbnail2.jpg:	thumbnail2.pdf
	convert -density 300 thumbnail2.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail2.jpg

thumbnail3.pdf:	MathSem-99-vortraege.pdf
	pdfjam --outfile thumbnail3.pdf --papersize '{16cm,9cm}' \
		MathSem-99-vortraege.pdf 3
thumbnail3.jpg:	thumbnail3.pdf
	convert -density 300 thumbnail3.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail3.jpg

thumbnail4.pdf:	MathSem-99-vortraege.pdf
	pdfjam --outfile thumbnail4.pdf --papersize '{16cm,9cm}' \
		MathSem-99-vortraege.pdf 4
thumbnail4.jpg:	thumbnail4.pdf
	convert -density 300 thumbnail4.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail4.jpg

fix1.pdf:	MathSem-99-vortraege.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-99-vortraege.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

