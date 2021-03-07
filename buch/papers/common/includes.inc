include papers/verkehr/Makefile.inc
include papers/multiplikation/Makefile.inc
include papers/punktgruppen/Makefile.inc
include papers/reedsolomon/Makefile.inc
include papers/ifs/Makefile.inc
include papers/mceliece/Makefile.inc
include papers/clifford/Makefile.inc
include papers/spannung/Makefile.inc
include papers/erdbeben/Makefile.inc

TEXFILES = \
	$(dependencies-verkehr) \
	$(dependencies-multiplikation) \
	$(dependencies-punktgruppen) \
	$(dependencies-reedsolomon) \
	$(dependencies-ifs) \
	$(dependencies-mceliece) \
	$(dependencies-clifford) \
	$(dependencies-spannung) \
	$(dependencies-erdbeben) \

