#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	kern bild kb kombiniert.jpg

kern:	kern1.jpg kern2.jpg
bild:	bild1.jpg bild2.jpg
kb:	kernbild1.jpg kernbild2.jpg

JK1.inc:	kernbild.m
	octave kernbild.m

kernbild1.png:	JK1.inc common.inc kernbild1.pov
kernbild2.png:	JK1.inc common.inc kernbild2.pov
bild1.png:	JK1.inc common.inc bild1.pov
bild2.png:	JK1.inc common.inc bild2.pov
kern1.png:	JK1.inc common.inc kern1.pov
kern2.png:	JK1.inc common.inc kern2.pov
kombiniert.png:	JK1.inc common.inc kombiniert.pov

%.png:	%.pov 
	povray +A0.1 -W1920 -H1080 -O$@ $<

%.jpg:	%.png
	convert -extract 1080x1080+420+0 $< $@ 

clean:
	rm -f *.png *.jpg
