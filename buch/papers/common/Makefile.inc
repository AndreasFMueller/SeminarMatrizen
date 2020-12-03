#
# Makefile.inc -- Makefile Targets und Variablen für Papers
#
# Achtung: dieses File wird erzeugt vom Skript scripts/mkmakefile
#
# (c) 2020 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
PAPERFILES = \
	papers/part2.tex \
	papers/uebersicht.tex \
	papers/000template/main.tex \
	
buch1-blx.bbl:	buch1-blx.aux
	bibtex buch1-blx


BLXFILES = buch.bbl \
	buch1-blx.bbl \


PAPER_DIRECTORIES = \
	000template \
	
PAPER_MAKEFILEINC = \
	papers/000template/Makefile.inc \


