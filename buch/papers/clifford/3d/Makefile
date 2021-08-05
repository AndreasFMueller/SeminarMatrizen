#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	dq.jpg q23.jpg q31.jpg drehung.jpg

size="+W1920 +H1080"
size="+W3840 +H2160"

dq.png:	dq.pov common.inc 
	povray +A0.1 $(size) -Odq.png dq.pov
dq.jpg:	dq.png
	convert dq.png -density 300 -units PixelsPerInch dq.jpg

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

