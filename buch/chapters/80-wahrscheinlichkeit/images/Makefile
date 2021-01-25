#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschulen
#
all:	diffusion.png diffusion.pdf

diffusion.pdf:	diffusion.tex diffusion.jpg
	pdflatex diffusion.tex

diffusion.png:	diffusion.pov vektoren.inc
	povray +A0.1 +W1920 +H1080 -Odiffusion.png diffusion.pov

diffusion.jpg:	diffusion.png
	convert diffusion.png -density 300 -units PixelsPerInch diffusion.jpg

vektoren.inc:	diffusion.m
	octave diffusion.m

