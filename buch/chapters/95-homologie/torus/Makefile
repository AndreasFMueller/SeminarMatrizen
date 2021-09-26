#
# Makefile -- torus homology
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	torus.jpg

torus.inc:	torus.m
	octave torus.m

torus.png:	torus.pov torus.inc
	povray +A0.1 -W1920 -H1080 -Otorus.png torus.pov

torus.jpg:	torus.png Makefile
	convert -extract 1624x978+147+75 torus.png torus.jpg
