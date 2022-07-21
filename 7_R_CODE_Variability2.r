library(raster)
library(RStoolbox)
library(ggplot2)

setwd("C:/Users/Lorenzo/Desktop/lab")

brick("sentinel.png")

sen <- brick("sentinel.png")

# banda 1 = nir
# banda 2 = red
# banda 3 = green

ggRGB(sen, 1, 2, 3)

# Esercizio: Immagine con la vegetazione che diventi verde, e il suolo viola

ggRGB(sen, 2, 1, 3)

# Per fare la 
