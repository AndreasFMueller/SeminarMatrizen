#
# Makefile
#
# (c) 2020 Prof Dr Andreas Müller, Hochschule Rappersil
#
all:	sp.pdf 

sp.pdf:	sp.tex sppaths.tex
	pdflatex sp.tex

sppaths.tex:	spbeispiel.m
	octave spbeispiel.m

