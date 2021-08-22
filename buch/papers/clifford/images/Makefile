#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	spiegelung.pdf

spiegelung.pdf:	spiegelung.tex punkte.tex
	pdflatex spiegelung.tex

punkte.tex:	spiegelung.m	
	octave spiegelung.m

