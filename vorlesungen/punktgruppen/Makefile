TEX=xelatex
TEXARGS=--output-directory=build --halt-on-error

all: script.pdf media

.PHONY: clean
clean:
	@rm -rfv build
	# @rm -rfv media

script.pdf: script.tex
	mkdir -p build
	$(TEX) $(TEXARGS) script.tex
	cp build/script.pdf .

media:
	poetry install
	poetry run manim -ql crystals.py
