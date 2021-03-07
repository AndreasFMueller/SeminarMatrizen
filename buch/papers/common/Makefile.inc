#
# Makefile.inc -- Makefile Targets und Variablen für Papers
#
# Achtung: dieses File wird erzeugt vom Skript scripts/mkmakefile
#
# (c) 2020 Prof Dr Andreas Müller, Hochschule Rapperswil
#
PAPERFILES = \
	papers/part2.tex \
	papers/uebersicht.tex \
	papers/verkehr/main.tex \
	papers/multiplikation/main.tex \
	papers/punktgruppen/main.tex \
	papers/reedsolomon/main.tex \
	papers/ifs/main.tex \
	papers/mceliece/main.tex \
	papers/clifford/main.tex \
	papers/spannung/main.tex \
	papers/erdbeben/main.tex \
	
buch1-blx.bbl:	buch1-blx.aux
	bibtex buch1-blx

buch2-blx.bbl:	buch2-blx.aux
	bibtex buch2-blx

buch3-blx.bbl:	buch3-blx.aux
	bibtex buch3-blx

buch4-blx.bbl:	buch4-blx.aux
	bibtex buch4-blx

buch5-blx.bbl:	buch5-blx.aux
	bibtex buch5-blx

buch6-blx.bbl:	buch6-blx.aux
	bibtex buch6-blx

buch7-blx.bbl:	buch7-blx.aux
	bibtex buch7-blx

buch8-blx.bbl:	buch8-blx.aux
	bibtex buch8-blx

buch9-blx.bbl:	buch9-blx.aux
	bibtex buch9-blx

buch10-blx.bbl:	buch10-blx.aux
	bibtex buch10-blx

BLXFILES = buch.bbl \
	buch1-blx.bbl \
	buch2-blx.bbl \
	buch3-blx.bbl \
	buch4-blx.bbl \
	buch5-blx.bbl \
	buch6-blx.bbl \
	buch7-blx.bbl \
	buch8-blx.bbl \
	buch9-blx.bbl \
	buch10-blx.bbl \

PAPER_DIRECTORIES = \
	verkehr \
	multiplikation \
	punktgruppen \
	reedsolomon \
	ifs \
	mceliece \
	clifford \
	spannung \
	erdbeben \
	
PAPER_MAKEFILEINC = \
	papers/verkehr/Makefile.inc \
	papers/multiplikation/Makefile.inc \
	papers/punktgruppen/Makefile.inc \
	papers/reedsolomon/Makefile.inc \
	papers/ifs/Makefile.inc \
	papers/mceliece/Makefile.inc \
	papers/clifford/Makefile.inc \
	papers/spannung/Makefile.inc \
	papers/erdbeben/Makefile.inc \
	
