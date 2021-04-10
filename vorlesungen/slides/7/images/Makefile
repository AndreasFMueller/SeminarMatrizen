#
# Makefile -- Illustrationen zu 
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
# 
all:	rodriguez.jpg

rodriguez.png:	rodriguez.pov
	povray +A0.1 -W1920 -H1080 -Orodriguez.png rodriguez.pov

rodriguez.jpg:	rodriguez.png 
	convert -extract 1740x1070+135+10 rodriguez.png rodriguez.jpg
