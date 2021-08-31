#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	complexbasis.pdf homocycles.pdf homoboundaries.pdf homoclasses.pdf \
	gausshomoex.pdf gausshomobasis.pdf dreieck.pdf polyeder.pdf \
	approximation.pdf tetraeder.pdf

dreieck.pdf:	dreieck.tex
	pdflatex dreieck.tex

polyeder.pdf:	polyeder.tex
	pdflatex polyeder.tex

gausshomobasis.pdf:	gausshomobasis.tex
	pdflatex gausshomobasis.tex

gausshomoex.pdf:	gausshomoex.tex
	pdflatex gausshomoex.tex

homocycles.pdf:	homocycles.tex
	pdflatex homocycles.tex

homoboundaries.pdf:	homoboundaries.tex
	pdflatex homoboundaries.tex

homoclasses.pdf:	homoclasses.tex
	pdflatex homoclasses.tex

complexbasis.pdf:	complexbasis.tex
	pdflatex complexbasis.tex

approximation.pdf:	approximation.tex approx.tex
	pdflatex approximation.tex

approx.tex:	approx.m
	octave approx.m

tetraeder.png:	tetraeder.pov
	povray +A0.1 -W1920 -H1080 -O$@ $<
tetraeder.jpg:	tetraeder.png Makefile
	convert -extract 1080x1080+520 tetraeder.png tetraeder.jpg
tetraeder.pdf:	tetraeder.tex tetraeder.jpg
	pdflatex tetraeder.tex

