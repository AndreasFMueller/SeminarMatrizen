#
# Makefile.inc
#
# (c) 2020 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

CHAPTERFILES = 								\
	chapters/part1.tex						\
	chapters/vorwort.tex

include chapters/00-einleitung/Makefile.inc
include chapters/10-vektorenmatrizen/Makefile.inc
include chapters/20-polynome/Makefile.inc
include chapters/30-endlichekoerper/Makefile.inc
include chapters/40-eigenwerte/Makefile.inc
