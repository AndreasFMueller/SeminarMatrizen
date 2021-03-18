#
# Makefile -- build images
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	hauptideal.jpg nichthauptideal.jpg hauptideal2.jpg hauptidealX.jpg \
	hauptidealR.jpg hauptidealXR.jpg ring.jpg

ring.png:	ring.pov common.inc
	povray +A0.1 +W1920 +H1080 -Oring.png ring.pov
ring.jpg:	ring.png
	convert ring.png -density 300 -units PixelsPerInch ring.jpg

hauptideal.png:	hauptideal.pov common.inc
	povray +A0.1 +W1920 +H1080 -Ohauptideal.png hauptideal.pov
hauptideal.jpg:	hauptideal.png
	convert hauptideal.png -density 300 -units PixelsPerInch \
		hauptideal.jpg

hauptidealR.png:	hauptidealR.pov common.inc
	povray +A0.1 +W1920 +H1080 -OhauptidealR.png hauptidealR.pov
hauptidealR.jpg:	hauptidealR.png
	convert hauptidealR.png -density 300 -units PixelsPerInch \
		hauptidealR.jpg

hauptideal2.png:	hauptideal2.pov common.inc
	povray +A0.1 +W1920 +H1080 -Ohauptideal2.png hauptideal2.pov
hauptideal2.jpg:	hauptideal2.png
	convert hauptideal2.png -density 300 -units PixelsPerInch \
		hauptideal2.jpg

hauptidealX.png:	hauptidealX.pov common.inc
	povray +A0.1 +W1920 +H1080 -OhauptidealX.png hauptidealX.pov
hauptidealX.jpg:	hauptidealX.png
	convert hauptidealX.png -density 300 -units PixelsPerInch \
		hauptidealX.jpg

hauptidealXR.png:	hauptidealXR.pov common.inc
	povray +A0.1 +W1920 +H1080 -OhauptidealXR.png hauptidealXR.pov
hauptidealXR.jpg:	hauptidealXR.png
	convert hauptidealXR.png -density 300 -units PixelsPerInch \
		hauptidealXR.jpg

nichthauptideal.png:	nichthauptideal.pov common.inc
	povray +A0.1 +W1920 +H1080 -Onichthauptideal.png nichthauptideal.pov
nichthauptideal.jpg:	nichthauptideal.png
	convert nichthauptideal.png -density 300 -units PixelsPerInch \
		nichthauptideal.jpg

ideal:	ideal.pov ideal.ini common.inc
	rm -rf ideal
	mkdir ideal
	povray +A0.1 +W1920 +H1080 -Oideal/i.png ideal.ini


