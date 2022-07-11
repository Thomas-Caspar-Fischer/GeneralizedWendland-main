

MASTER = GeneralizedWendland

RNW = $(wildcard section*.Rnw)
R   = $(patsubst %.Rnw, %.R, $(RNW))
TEX = $(patsubst %.Rnw, %.tex, $(RNW))

.Rnw.tex:
	Rscript -e "library(knitr); knitr::knit('$<','$@')"

.Rnw.R:
	Rscript -e "library(knitr); knitr::purl('$<',documentation=0L)"

.tex.pdf:
	latexmk -bibtex -synctex=1 -pdf  -use-make -halt-on-error \
	 -pdflatex="pdflatex"  $(MASTER).tex


all: $(MASTER).pdf

$(MASTER).pdf: $(TEX) $(MASTER).tex

short: $(TEX)
	pdflatex $(MASTER).tex

clean:
	rm -f *~ *.out Rplots.pdf comment.cut *.idx *.ilg *.brf *.blg *.spl \
		$(MASTER).dvi *.backup *.toc *.fls  *fdb_latexmk *.synctex.gz

cleanall: clean
	rm -f *.aux *.log *.ind
	rm -f figures/*.pdf
	rm -f section*.tex section*.R $(MASTER).bbl
	rm -rf cache .Rhistory

# Some technical details
.SUFFIXES: .Rnw .R .tex .pdf
.SILENT: *.pdf *.tex
.PHONY: all short clean cleanall

# 2019 Reinhard Furrer, Florian Gerber
