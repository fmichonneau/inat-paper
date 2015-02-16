all: pdf

word: 2015-Michonneau+Paulay-ReefEncounters.docx

pdf: 2015-Michonneau+Paulay-ReefEncounters.pdf

2015-Michonneau+Paulay-ReefEncounters.docx: 2015-Michonneau+Paulay-ReefEncounters.tex iNaturalist-nourl.bib
	pandoc -t docx -o $@ --csl coral-reefs.csl --bibliography iNaturalist-nourl.bib $^

2015-Michonneau+Paulay-ReefEncounters.pdf: 2015-Michonneau+Paulay-ReefEncounters.tex 2015-Michonneau+Paulay-ReefEncounters.aux
	xelatex  -interaction=nonstopmode "\input" $^
	xelatex  -interaction=nonstopmode "\input" $^
	xelatex  -interaction=nonstopmode "\input" $^
	make clean-partial

2015-Michonneau+Paulay-ReefEncounters.aux: 2015-Michonneau+Paulay-ReefEncounters.tex iNaturalist-nourl.bib
	xelatex  -interaction=nonstopmode "\input" 2015-Michonneau+Paulay-ReefEncounters.tex
	bibtex $@

2015-Michonneau+Paulay-ReefEncounters.tex: 2015-Michonneau+Paulay-ReefEncounters.Rnw code/paper-code.R code/paper-functions.R
	Rscript -e "library(knitr); knit('2015-Michonneau+Paulay-ReefEncounters.Rnw')"

iNaturalist-nourl.bib: 2015-Michonneau+Paulay-ReefEncounters.tex
	cp ~/Library/iNaturalist.bib .
	Rscript parseURLs.R


clean-partial:
	-rm *~
	-rm *.bbl
	-rm *.blg
	-rm *.aux
	-rm *.log
	-rm *.out

clean: clean-partial
	-rm *.pdf
