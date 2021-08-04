#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	dq.jpg

dq.png:	dq.pov common.inc
	povray +A0.1 +W1920 +H1080 -Odq.png dq.pov

dq.jpg:	dq.png
	convert dq.png -density 300 -units PixelsPerInch dq.jpg

