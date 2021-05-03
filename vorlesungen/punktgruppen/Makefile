TEX=xelatex
TEXARGS=--output-directory=build --halt-on-error

all: slides.pdf script.pdf media

.PHONY: clean
clean:
	@rm -rfv build
	# @rm -rfv media

%.pdf: %.tex
	mkdir -p build
	$(TEX) $(TEXARGS) $<
	$(TEX) $(TEXARGS) $<
	cp build/$@ .

media:
	poetry install
	poetry run manim -ql crystals.py
