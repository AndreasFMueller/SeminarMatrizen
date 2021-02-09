#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschulen
#
all:	dreieck.pdf trenn.pdf vergleich.pdf vergleich.jpg \
	positiv.pdf positiv.jpg diffusion.png diffusion.pdf \
	konvex.pdf internet.pdf markov.pdf markov2.pdf markov3.pdf \
	spielB.pdf spielBtilde.pdf

# Visualisierung diffusion in einer primitiven Matrix
diffusion.pdf:	diffusion.tex diffusion.jpg
	pdflatex diffusion.tex

diffusion.png:	diffusion.pov vektoren.inc
	povray +A0.1 +W1920 +H1080 -Odiffusion.png diffusion.pov

diffusion.jpg:	diffusion.png
	convert diffusion.png -density 300 -units PixelsPerInch diffusion.jpg

vektoren.inc:	diffusion.m
	octave diffusion.m

# Visualizierung positive Matrix
positiv.pdf:	positiv.tex positiv.jpg
	pdflatex positiv.tex

positiv.png:	positiv.pov  quadrant.inc
	povray +A0.1 +W1920 +H1080 -Opositiv.png positiv.pov

positiv.jpg:	positiv.png
	convert positiv.png -density 300 -units PixelsPerInch positiv.jpg

quadrant.inc:	positiv.m
	octave positiv.m

# Visualiziserung Vergleichstrick
vergleich.png:	vergleich.pov
	povray +A0.1 +W1920 +H1080 -Overgleich.png vergleich.pov

vergleich.jpg:	vergleich.png Makefile
	convert -extract 1110x1080+180+0 vergleich.png \
		-density 300 -units PixelsPerInch vergleich.jpg

vergleich.pdf:	vergleich.tex vergleich.jpg
	pdflatex vergleich.tex

# Darstellung zum Trenntrick
trenn.pdf:	trenn.tex
	pdflatex trenn.tex

# Darstellung zur Dreiecksungleichung
dreieck.pdf:	dreieck.tex drei.inc
	pdflatex dreieck.tex

drei.inc:	dreieck.m
	octave dreieck.m

# Konvex
konvex.pdf:	konvex.tex
	pdflatex konvex.tex

internet.pdf:	internet.tex
	pdflatex internet.tex

markov.pdf:	markov.tex
	pdflatex markov.tex

markov2.pdf:	markov2.tex
	pdflatex markov2.tex

markov3.pdf:	markov3.tex
	pdflatex markov3.tex

spielB.pdf:	spielB.tex
	pdflatex spielB.tex

spielBtilde.pdf:	spielBtilde.tex
	pdflatex spielBtilde.tex
