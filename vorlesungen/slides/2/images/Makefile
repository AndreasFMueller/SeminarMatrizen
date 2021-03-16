#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	quotient1.jpg quotient2.jpg quotient1.pdf quotient2.pdf

quotient1.png:	quotient1.pov quotient.inc
	povray +A0.1 +W1920 +H1080 -Oquotient1.png quotient1.pov

quotient1.jpg:	quotient1.png Makefile
	convert -extract 1360x1040+330+20 quotient1.png \
		-density 300 -units PixelsPerInch quotient1.jpg

quotient2.png:	quotient2.pov quotient.inc
	povray +A0.1 +W1920 +H1080 -Oquotient2.png quotient2.pov

quotient2.jpg:	quotient2.png Makefile
	convert -extract 1360x1040+330+20 quotient2.png \
		-density 300 -units PixelsPerInch quotient2.jpg

quotient:	quotient.ini quotient.inc quotient.pov
	rm -rf quotient
	mkdir quotient
	povray +A0.1 -Oquotient/0.png -W1920 -H1080 quotient.ini

quotient1.pdf:	quotient1.tex quotient1.jpg
	pdflatex quotient1.tex

quotient2.pdf:	quotient2.tex quotient2.jpg
	pdflatex quotient2.tex

