#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	wuerfel2.png wuerfel.png

wuerfel.png:	wuerfel.pov common.inc
	povray +A0.1 -W1080 -H1080 -Owuerfel.png wuerfel.pov

wuerfel2.png:	wuerfel2.pov common.inc
	povray +A0.1 -W1080 -H1080 -Owuerfel2.png wuerfel2.pov
