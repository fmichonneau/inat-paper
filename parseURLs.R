#!/usr/bin/Rscript
bib <- readLines("iNaturalist.bib")

allUrl <- grep("^url", bib, value=TRUE)
allTitle <- grep("^title", bib, value=TRUE)

toKeep <- grep("github|r-project", allUrl)

newTitle <- character(length(allTitle))
for (i in 1:length(allTitle)) {
    tmpUrl <- allUrl[i]
    if (length(grep("github|r-project", tmpUrl))) {
        tmpTitle <- allTitle[i]
        tmpUrl <- gsub("\\s+=\\s+", "", tmpUrl)
        tmpUrl <- gsub(",$", "", tmpUrl)
        tmpUrl <- gsub("^url", "url", tmpUrl)
        newTitle[i] <- gsub("(}},)$", paste("  \\\\", tmpUrl, "\\1", sep=""), tmpTitle)
    }
    else newTitle[i] <- allTitle[i]
}

bib[match(allTitle, bib)] <- newTitle

cat(bib, sep="\n", file="iNaturalist-nourl.bib")
