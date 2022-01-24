#
# Makefile -- build the book cover
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	matrix.pdf front back

matrix.pdf:	matrix.tex
	pdflatex matrix.tex
#matrix2.pdf:	matrix2.tex
#	pdflatex matrix2.tex

buchcover:	buchcover.pdf buchcover-black.pdf
buchcover.pdf:	buchcover.tex matrix-blue.png
	pdflatex buchcover.tex
buchcover-black.pdf:	buchcover-black.tex matrix-black.png
	pdflatex buchcover-black.tex

front:	front.pdf front-black.pdf
front.pdf:	front.tex buchcover.pdf
	pdflatex front.tex
front.png:	front.pdf
	convert front.pdf -density 300 -units PixelsPerInch front.png
front-black.pdf:	front-black.tex buchcover-black.pdf
	pdflatex front-black.tex
front-black.png:	front-black.pdf
	convert front-black.pdf -density 300 -units PixelsPerInch front-black.png

back:	back.pdf back-black.pdf
back.pdf:	back.tex buchcover.pdf
	pdflatex back.tex
back-black.pdf:	back-black.tex buchcover-black.pdf
	pdflatex back-black.tex

matrix:	matrix.cpp
	g++ -Wall -O2 -g -o matrix `pkg-config --cflags Magick++` \
		matrix.cpp `pkg-config --libs Magick++`
test:	matrix
	./matrix -w 500 -h 1080  blubb.png && open blubb.png
matrix-blue.png:	matrix
	./matrix -f white -b blue -w 3840 -h 2160 -s 2 matrix-blue.png
matrix-black.png:	matrix
	./matrix -b black -w 3840 -h 2160 -s 2 matrix-black.png

buchcover.png:  buchcover-black.pdf  Makefile
	convert -density 300 -extract 2054x2900+2630+190 buchcover-black.pdf \
		buchcover.png
buchcover.jpg:  buchcover.png
	convert buchcover.png buchcover.jpg
backcover.png:  buchcover-black.pdf Makefile
	convert -density 300 -extract 2054x2900+192+190 buchcover-black.pdf \
		backcover.png
backcover.jpg:  backcover.png
	convert backcover.png backcover.jpg
