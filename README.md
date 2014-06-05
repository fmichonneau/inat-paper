
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

- a functional LaTeX installation;
- [R](http://www.r-project.org) with the following packages:
  * [knitr](http://cran.r-project.org/package=knitr)
  * [ggplot2](http://cran.r-project.org/package=ggplot2)
  * [wesanderson](https://github.com/karthik/wesanderson)
  * [taxize](http://f1000research.com/articles/2-191/v2)

In R, after pulling the content of the repository, you should be able to just
do:

    library(knitr)
    knit("iNaturalist-paper.Rnw")

and then compile with your favorite TeX engine the file generated
`iNaturalist-paper.tex`.

I used Ubuntu 14.04 to generate the files included in this repository.

# License

The content of this repository is under a Creative Commons Attribution License
[CC-BY](http://creativecommons.org/licenses/by/4.0)

> Michonneau F. & Paulay G., 2014. Using iNaturalist to engage the public and
> learn more about echinoderms.
