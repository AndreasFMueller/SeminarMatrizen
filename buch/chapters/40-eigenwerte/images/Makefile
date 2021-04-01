#
# Makefile
#
# (c) 2020 Prof Dr Andreas Müller, Hochschule Rappersil
#
all:	sp.pdf nilpotent.pdf kernbild.pdf kombiniert.pdf \
	wurzelapprox.pdf wurzel.pdf dimjk.pdf jknilp.pdf \
	normalform.pdf

sp.pdf:	sp.tex sppaths.tex
	pdflatex sp.tex

sppaths.tex:	spbeispiel.m
	octave spbeispiel.m

nilpotent.pdf:	nilpotent.tex
	pdflatex nilpotent.tex

kernbild.pdf:	kernbild.tex bild2.jpg kern2.jpg
	pdflatex kernbild.tex

kombiniert.pdf:	kombiniert.tex kombiniert.jpg
	pdflatex kombiniert.tex

wurzelapprox.pdf:	wurzelapprox.tex wa.tex
	pdflatex wurzelapprox.tex

wa.tex:	wa.m
	octave wa.m

wurzel.pdf:	wurzel.tex
	pdflatex wurzel.tex

dimjk.pdf:	dimjk.tex
	pdflatex dimjk.tex

jknilp.pdf:	jknilp.tex
	pdflatex jknilp.tex

normalform.pdf:	normalform.tex
	pdflatex normalform.tex

