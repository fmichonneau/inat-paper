### ---- init-map ----
library(maps)
library(ggplot2)
source("code/paper-functions.R")

## Color definition
library(wesanderson)
zissouPal <- wes_palette(name = "Zissou", type="continuous")
zissouPalDisc <- wes_palette(5, name="Zissou")
zissouPerClass <- zissouPalDisc[c(5, 1, 4, 3, 2)]

seaCol <- "#dfeff2"
landCol <- "#b0ccad"

### ---- data-prep ----
## library(rinat)
## inat <- get_inat_obs_project("echinoderms", type="observations")
## the headers are a little different, so using manual download to not have
##  to change the entire code.
inat <- read.csv(file="data/20150204.echinoderms.all.csv", stringsAsFactors=FALSE)
inatThin <- thinCoords(inat)
wrld <- map_data("world")

## Higher classification
library(taxizesoap)
uniqSpp <- unique(inat$scientific_name)

## remove the empty one
uniqSpp <- uniqSpp[nzchar(uniqSpp)]

## /Gomophia gomophia/ isn't in WoRMS, replacing with Gomophia here
uniqSpp[match("Gomophia gomophia", uniqSpp)] <- "Gomophia"

## ## Get WoRMS AphiaID for all species
## wormsClass1_ids <- lapply(uniqSpp, function(x) {
##     tmpRes <- get_wormsid(x)
##     if (is.na(tmpRes)) {
##         tmpRes <- worms_records(x, fuzzy=TRUE)
##         tmpRes <- unique(tmpRes[tmpRes$phylum == "Echinodermata"]$valid_AphiaID)
##         tmpRes
##     }
##     tmpRes
## })

## ## OK that Echinaster sepositus has more than 1
## ## Checked and 1 item is OK to use.
## testLength <- sapply(wormsClass1_ids, length)
## if (any(testLength > 1)) {
##     warning("Some taxa returned more than one AphiaID: ",
##             paste(uniqSpp[[which(testLength > 1)]], collapse=", "))
## }

## ## Using only first elements
## wormsClass1_idsx <- sapply(wormsClass1_ids, function(x) x[1])
## wormsHigherClass <- lapply(wormsClass1_idsx, taxizesoap:::classification_s.wormsid)

## wormsHigherClassDf <- do.call("rbind", lapply(wormsHigherClass, function(x) {
##     cbind(aphiaID=names(x)[1], x[[1]])
## }))

## wormsClassFamily <- split(wormsHigherClassDf, wormsHigherClassDf$aphiaID) %>%
##     lapply(., function(x) {
##         resCl <- subset(x, rank == "Class")
##         resFm <- subset(x, rank == "Family")
##         cl <- as.character(resCl[["name"]])
##         fm <- as.character(resFm[["name"]])
##         if (length(cl) != 1) cl <- NA
##         if (length(fm) != 1) fm <- NA
##         c(as.character(x[[1]][1]), cl, fm)
##     }) %>%
##         do.call("rbind", .) %>% as.data.frame(.)

## names(wormsClassFamily) <- c("aphiaID", "Class", "Family")

## taxonomyAphiaID <- cbind(scientific_name=uniqSpp, aphiaID=wormsClass1_idsx) %>%
##     merge(., wormsClassFamily, all.x=TRUE)

## saveRDS(taxonomyAphiaID, file="data/taxonomyAphiaID.rds")

taxonomyAphiaID <- readRDS(file="data/taxonomyAphiaID.rds")
addClass <- merge(inatThin, taxonomyAphiaID,  all.x=TRUE)

### Map of all observations thinned (at 200km scale), grouped by classes.
### ---- all-observations ----
uniqGPS <- paste(addClass$Class, addClass$Lat2, addClass$Long2, sep="/")
tableGPS <- table(uniqGPS)
coordsGPS <- strsplit(names(tableGPS), "/")
nbObsTable <- data.frame(class = sapply(coordsGPS, function(x) x[1]),
                         latitude=as.numeric(sapply(coordsGPS, function(x) x[2])),
                         longitude=as.numeric(sapply(coordsGPS, function(x) x[3])),
                         nbObs=tableGPS[, drop=TRUE],
                         stringsAsFactors=FALSE, row.names=NULL)
nbObsTable <- subset(nbObsTable, class != "NA")

ggplot(nbObsTable) + annotation_map(wrld, color="NA", fill=landCol) +
    geom_point(aes(x=longitude, y=latitude, size=nbObs, colour=class),
               position=position_jitter(width=2)) +
    scale_size(range=c(3,10), breaks=c(1,100,300)) +
    ylab("Latitude") + xlab("Longitude") +
    coord_map(projection="mercator") + ylim(c(-55, 55)) +
    scale_colour_manual(values = zissouPerClass) +
    theme(legend.position = "top", legend.title = element_blank(),
          legend.direction = "horizontal", legend.justification = "right",
          panel.background = element_rect(fill = seaCol)) #,
          #panel.grid.major = element_line(colour = "white", size=0.1))
