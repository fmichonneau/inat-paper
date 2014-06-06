### ---- init-map ----
library(maps)
library(ggplot2)
source("code/paper-functions.R")

## Color definition
library(wesanderson)
zissouPal <- wes.palette(name = "Zissou", type="continuous")
zissouPalDisc <- wes.palette(5, name="Zissou")
zissouPerClass <- zissouPalDisc[c(5, 1, 4, 3, 2)]

seaCol <- "#dfeff2" 
landCol <- "#b0ccad"

### ---- data-prep ---- 
inat <- read.csv(file="data/echinoderms.all.csv", stringsAsFactors=FALSE)
inatThin <- thinCoords(inat)
wrld <- map_data("world")

## Higher classification
uniqSpp <- unique(inat$scientific_name)
## library(taxize)
## ## higherClass <- classification(uniqSpp, db="itis") ## very incomplete
## higherClassNCBI <- classification(uniqSpp, db="ncbi") # much better
## save(higherClassNCBI, file="data/higherClassNBCI.RData")

load("data/higherClassNBCI.RData")
higherClass <- rbind(higherClassNCBI)
classTaxa <- subset(higherClass, rank == "class")

## dealing manually with species not in NCBI
## write.csv(uniqSpp[! uniqSpp %in% classTaxa$taxonid], file="/tmp/missingTaxa.csv",
##          row.names=FALSE)
## after manual editing
missingTaxa <- read.csv(file="data/missingTaxa-classes.csv", stringsAsFactors=FALSE)

## after updating data, will need to check that all data is included

classTaxa <- rbind(classTaxa, missingTaxa)
addClass <- merge(inatThin, classTaxa, by.x="scientific_name", by.y="taxonid", all.x=TRUE)
names(addClass)[match("name", names(addClass))] <- "class"

## Fix error in NCBI database
addClass[addClass$class == "Gymnolaemata" & !is.na(addClass$class), "class"] <- "Echinoidea"

## sum(is.na(addClass$class)) ## currenly only 2 missing

### Map of all observations thinned (at 200km scale), grouped by classes.
### ---- all-observations ----
uniqGPS <- paste(addClass$class, addClass$Lat2, addClass$Long2, sep="/")
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
               position=position_jitter(width=1)) +
    scale_size(range=c(4, 15)) + ylab("Latitude") + xlab("Longitude") +
    coord_map(projection="mercator") + ylim(c(-35, 58)) +
    scale_colour_manual(values = zissouPerClass) +    
    theme(legend.position = c(.97,.9), legend.title = element_blank(),
          legend.direction = "horizontal", legend.justification = "right",
          panel.background = element_rect(fill = seaCol),
          panel.grid.major = element_line(colour = "white", size=0.1))
