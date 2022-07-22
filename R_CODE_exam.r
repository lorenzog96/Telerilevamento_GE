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

b5 <- brick("1985_B1.TIF")
g5 <- brick("1985_B2.TIF")
r5 <- brick("1985_B3.TIF")
i5 <- brick("1985_B4.TIF")
l5 <- brick("1985_B5.TIF")
t5 <- brick("1985_B6.TIF")
m5 <- brick("1985_B7.TIF")




