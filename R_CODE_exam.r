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

# Carico tutti i file necessari per lo studio della situazione del 1985
files85 <- list.files(pattern="1985_")
i85 <- stack(files85)
i85

# Carico tutti i file necessari per lo studio della situazione del 2022
files22 <- list.files(pattern="2022_")
i22 <- stack(files22)
i22















