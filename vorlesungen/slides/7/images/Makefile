#
# Makefile -- Illustrationen zu 
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
# 
all:	rodriguez.jpg  test.png

rodriguez.png:	rodriguez.pov
	povray +A0.1 -W1920 -H1080 -Orodriguez.png rodriguez.pov

rodriguez.jpg:	rodriguez.png 
	convert -extract 1740x1070+135+10 rodriguez.png rodriguez.jpg

commutator:	commutator.ini commutator.pov common.inc
	povray +A0.1 -W1920 -H1080 -Oc/c.png commutator.ini
jpg:
	for f in c/c*.png; do convert $${f} c/`basename $${f} .png`.jpg; done

dreibein/timestamp:	interpolation.m
	octave interpolation.m
	touch dreibein/timestamp

test.png:	test.pov drehung.inc dreibein/d025.inc dreibein/timestamp
	povray +A0.1 -W1080 -H1080 -Otest.png test.pov

dreibein/d025.inc:	dreibein/timestamp

animation:
	povray +A0.1 -W1080 -H1080 -Ointerpolation/i.png interpolation.ini
