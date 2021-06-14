#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	phasenraum.pdf kartenkreis.pdf karten.pdf sl2.pdf scherungen.pdf

phasenraum.pdf:	phasenraum.tex
	pdflatex phasenraum.tex

kartenkreis.pdf:	kartenkreis.tex
	pdflatex kartenkreis.tex

torus.png:	torus.pov
	povray +A0.1 -W1920 -H1080 -Otorus.png torus.pov

karten.pdf:	karten.tex torus.png
	pdflatex karten.tex

sl2.pdf:	sl2.tex 
	pdflatex sl2.tex

scherungen.pdf:	scherungen.tex 
	pdflatex scherungen.tex

