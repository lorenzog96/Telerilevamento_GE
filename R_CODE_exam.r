# Carico tutti i pacchetti necessari per le varie funzioni che andrò ad effettuare
library(raster)
library(RStoolbox)
library(rasterdiv)
library(ggplot2)
library(patchwork)
library(viridis)
library(sdm)

# Carico la cartella da cui verranno prelevati i file
setwd("C:/Users/Lorenzo/Desktop/exam")

# Carico il file necessari per lo studio della situazione del 2015
i15 <- brick("L1C_T32TQQ_A000262_20150711T100008.tif")

# Carico il file necessari per lo studio della situazione del 2022
i22 <- brick("L1C_T32TQQ_A028033_20220719T095747.tif")

# Vado a plottare attraverso la funzione plot RGB
r15 <- plotRGB(i15, r=1, g=2, b=3, stretch="lin")
r22 <- plotRGB(i22, r=1, g=2, b=3, stretch="lin")

# Creo un plot con un singolo multiframe con la funzione ggRGB
a15 <- ggRGB(i15, r=1, g=2, b=3, stretch="lin")
a22 <- ggRGB(i22, r=1, g=2, b=3, stretch="lin")
a15 + a22

# in questo modo si vedono a confronto le due situazioni, nel 2015 e nel 2022

# Effettuo ora la classificazione dell'area di interesse
c15 <- unsuperClass(a15, nClasses=3)
c22 <- unsuperClass(a22, nClasses=3)














