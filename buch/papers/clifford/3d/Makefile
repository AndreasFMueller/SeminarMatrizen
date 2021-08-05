#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	dq.jpg q23.jpg q31.jpg drehung.jpg dq.pdf

size="+W1920 +H1080"
size="+W3840 +H2160"

dq.png:	dq.pov common.inc 
	povray +A0.1 $(size) -Odq.png dq.pov
dq.jpg:	dq.png Makefile
	convert -extract 1600x1400+1500+60 dq.png -density 300 -units PixelsPerInch dq.jpg
dq.pdf:	dq.jpg dq.tex
	pdflatex dq.tex

q23.png:	q23.pov common.inc 
	povray +A0.1 $(size) -Oq23.png q23.pov
q23.jpg:	q23.png
	convert q23.png -density 300 -units PixelsPerInch q23.jpg

q31.png:	q31.pov common.inc 
	povray +A0.1 $(size) -Oq31.png q31.pov
q31.jpg:	q31.png
	convert q31.png -density 300 -units PixelsPerInch q31.jpg

drehung.png:	drehung.pov common.inc 
	povray +A0.1 $(size) -Odrehung.png drehung.pov
drehung.jpg:	drehung.png
	convert drehung.png -density 300 -units PixelsPerInch drehung.jpg

