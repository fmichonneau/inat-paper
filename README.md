
# The echinoderm project on iNaturalist

This repository contains the code and data to generate the papers submitted
about the echinoderm project on iNaturalist.

# About the project

We started a project on
[Echinoderms](http://inaturalist.org/projects/echinoderms) at iNaturalist to
gather observations worldwide, and across taxa. Our goal is to improve our
knowledge of species distributions, variation, and biology, and to educate the
public about the diversity of Echinoderms.

# How to run the code?

You need:

- a functional LaTeX installation (here I use XeTeX)
- [R](http://www.r-project.org) with the following packages:
  * [knitr](http://cran.r-project.org/package=knitr)
  * [ggplot2](http://cran.r-project.org/package=ggplot2)
  * [wesanderson](https://github.com/karthik/wesanderson)
  * [taxizesoap](http://github.coom/ropensci/taxizesoap)

The project includes a `Makefile`, so if you have `make` installed, typing `make
all` inside the folder will generate the manuscript in PDF format.

If you don't have `make`, you can first generate the `tex` file in R:

    library(knitr)
    knit("2015-Michonneau+Paulay-ReefEncounters.Rnw")

and then compile the file generated (`iNaturalist-paper.tex`) using
`XeTeX`.

(I used Ubuntu 14.10 to generate the files included in this repository.)

# Citation & License

The content of this repository is under a Creative Commons Attribution License
[CC-BY 4.0](http://creativecommons.org/licenses/by/4.0).

> Michonneau F. & Paulay G., 2015. Using iNaturalist to learn more about
> echinoderms. Available from figshare
> (doi:[10.6084/m9.figshare.1309937](http://dx.doi.org/10.6084/m9.figshare.1309937))

The initial version of this manuscript has been submitted to Reef Encounter on
June 6<sup>th</sup>, 2014. It has been tagged `v20140606.0+reefencounter`. The
full repository for this version can be downloaded
[here](https://github.com/fmichonneau/inat-paper/tree/v20140606.0%2Breefencounter),
and the submitted version of the PDF can be downloaded
[here](https://github.com/fmichonneau/inat-paper/blob/7feac355c923ace136220123d926e18556414876/iNaturalist-paper.pdf?raw=true)


The revised version of the manuscripted has been submitted on February
16<sup>th</sup>, 2015 and has been tagged `v20150216.1+reefencounter`. The full
repository for this version can be downloaded
[here](https://github.com/fmichonneau/inat-paper/tree/v20150216.1%2Breefencounter),
and the submitted version of the PDF can be downloaded
[here](https://github.com/fmichonneau/inat-paper/blob/ecc44d93b638cfeb144c26288c81d5015f729d3e/2015-Michonneau%2BPaulay-ReefEncounters.pdf)
