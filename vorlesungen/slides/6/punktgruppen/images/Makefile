#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all: 	cn.jpg cnv.jpg cnh.jpg dn.jpg dnd.jpg dnh.jpg

cn.png:	common.inc cn.pov
	povray +A0.1 -W1920 -H1080 -Ocn.png cn.pov
cn.jpg:	cn.png
	convert -extract 1050x1050+450+4 cn.png cn.jpg

cnv.png:	common.inc cnv.pov
	povray +A0.1 -W1920 -H1080 -Ocnv.png cnv.pov
cnv.jpg:	cnv.png 
	convert -extract 1050x1050+450+4 cnv.png cnv.jpg

cnh.png:	common.inc cnh.pov
	povray +A0.1 -W1920 -H1080 -Ocnh.png cnh.pov
cnh.jpg:	cnh.png 
	convert -extract 1050x1050+450+4 cnh.png cnh.jpg

dn.png:	common.inc dn.pov
	povray +A0.1 -W1920 -H1080 -Odn.png dn.pov
dn.jpg:	dn.png 
	convert -extract 1050x1050+450+4 dn.png dn.jpg

dnd.png:	common.inc dnd.pov
	povray +A0.1 -W1920 -H1080 -Odnd.png dnd.pov
dnd.jpg:	dnd.png 
	convert -extract 1050x1050+450+4 dnd.png dnd.jpg

dnh.png:	common.inc dnh.pov
	povray +A0.1 -W1920 -H1080 -Odnh.png dnh.pov
dnh.jpg:	dnh.png 
	convert -extract 1050x1050+450+4 dnh.png dnh.jpg




