#
# Makefile zum Skript ueber Matrizen
#
# (c) 2020 Prof Dr Andreas Mueller, Hochschule Rapperswil
#
all:	buch.pdf errata.pdf

DIFF =	diffs/1.diff							\
	diffs/2.diff
errata.pdf:	errata.tex $(DIFF)
	pdflatex errata.tex

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
	pdflatex buch.tex

buch.ind:	buch.idx
	makeindex buch.idx

separate:	buch.aux buch.pdf
	bash splitpapers

matrizen.pdf:	
	pdfjam --outfile matrizen.pdf \
		../cover/front.pdf 1,{} \
		buch.pdf 1-504 \
		../cover/back.pdf {},1

tests:	test1.pdf test2.pdf test3.pdf

test1.pdf:	common/test-common.tex common/test1.tex aufgaben1.tex
	pdflatex common/test1.tex

test2.pdf:	common/test-common.tex common/test1.tex aufgaben2.tex
	pdflatex common/test2.tex

test3.pdf:	common/test-common.tex common/test1.tex aufgaben3.tex
	pdflatex common/test3.tex
