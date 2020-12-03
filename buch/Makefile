#
# Makefile zum Skript ueber Matrizen
#
# (c) 2020 Prof Dr Andreas Mueller, Hochschule Rapperswil
#
all:	buch.pdf

papers/common/Makefile.inc:	papers/common/paperlist

include common/Makefile.inc
include chapters/Makefile.inc
include papers/common/Makefile.inc
include papers/common/includes.inc

ALLTEXFILES = $(TEXFILES) $(CHAPTERFILES)

buch.pdf:	buch.tex $(TEXFILES) buch.ind $(BLXFILES)
	pdflatex buch.tex
	bibtex buch

buch.idx:	buch.tex $(TEXFILES) images
	touch buch.ind
	pdflatex buch.tex

buch.ind:	buch.idx
	makeindex buch.idx

separate:	buch.aux buch.pdf
	bash splitpapers

numerik.pdf:	
	pdfjam --outfile numerik.pdf \
		../cover/front.pdf 1,{} \
		buch.pdf 1-504 \
		../cover/back.pdf {},1
