TEX=xelatex
TEXARGS=--output-directory=build --halt-on-error

all: slides.pdf script.pdf media

.PHONY: clean
clean:
	@rm -rfv build
	# @rm -rfv media

slides.pdf: slides.tex
	mkdir -p build
	$(TEX) $(TEXARGS) slides.tex
	cp build/slides.pdf .

script.pdf: script.tex
	mkdir -p build
	$(TEX) $(TEXARGS) script.tex
	cp build/script.pdf .

media:
	poetry install
	poetry run manim -ql crystals.py
