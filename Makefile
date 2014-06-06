all: iNaturalist-paper.aux iNaturalist-paper.tex
	xelatex  -interaction=nonstopmode "\input" iNaturalist-paper.tex
	xelatex  -interaction=nonstopmode "\input" iNaturalist-paper.tex
	make clean-partial

iNaturalist-paper.tex: iNaturalist-paper.Rnw
	Rscript -e "library(knitr); knit('iNaturalist-paper.Rnw')"

iNaturalist-nourl.bib: iNaturalist-paper.tex
	cp ~/Library/iNaturalist.bib .
	Rscript parseURLs.R

iNaturalist-paper.aux: iNaturalist-paper.tex iNaturalist-nourl.bib
	xelatex  -interaction=nonstopmode "\input" iNaturalist-paper.tex
	bibtex iNaturalist-paper

clean-partial:
	-rm *~
	-rm *.bbl
	-rm *.blg
	-rm *.aux
	-rm *.log
	-rm *.out

clean: clean-partial
	-rm *.pdf
