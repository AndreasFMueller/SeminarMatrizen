#
# Makefile -- dgl
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	dgl-handout.pdf MathSem-08-dgl.pdf

# SHELL = /bin/bash

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)
IMAGES = vektorfelder-1.pdf


MathSem-08-dgl.pdf:	MathSem-08-dgl.tex $(SOURCES) $(IMAGES)
	pdflatex --synctex=1 MathSem-08-dgl.tex > /dev/null

dgl-handout.pdf:	dgl-handout.tex $(SOURCES) $(IMAGES)
	pdflatex dgl-handout.tex > /dev/null

vektorfelder-1.pdf: ../slides/10/vektorfelder.mp
	cd ../slides/10/; \
	TEX=latex mpost vektorfelder.mp; \
	for f in vektorfelder.[0-9]*; \
	do \
	  mptopdf $${f} > /dev/null; \
	done; \
	rm -f vektorfelder.[0-9]* vektorfelder.log vektorfelder.mpx

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSem-08-dgl.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-08-dgl.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-08-dgl.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-08-dgl.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

