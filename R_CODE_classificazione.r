library(raster)
library(RStoolbox)
setwd("C:/Users/Lorenzo/Desktop/lab")

# importo i dati
canyon <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")

# Info: canyon
class      : RasterBrick 
dimensions : 6222, 9334, 58076148, 3  (nrow, ncol, ncell, nlayers)
resolution : 1, 1  (x, y)
extent     : 0, 9334, 0, 6222  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : dolansprings_oli_2013088_canyon_lrg.jpg 
names      : dolansprings_oli_2013088_canyon_lrg.1, dolansprings_oli_2013088_canyon_lrg.2, dolansprings_oli_2013088_canyon_lrg.3 
min values :                                     0,                                     0,                                     0 
max values :                                   255,                                   255,                                   255 

plot(canyon)

# Si vanno a fare le classificazioni dell'immagine

plotRGB(canyon, r=1, g=2, b=3, stretch="lin")

# Esercizio: cambiare lo Stretch da lineare a istogrammi
plotRGB(canyon, r=1, g=2, b=3, stretch="hist")
# aumenta il contrasto delle immagini

#si vanno a creare le classi
canyon2 <- unsuperClass(canyon, nClasses=2)
# 2 classi per semplificare

# creo l'immagine
plot(canyon2$map)

# Esercizio: classificazione della mappa con 4 classi
canyon4 <- unsuperClass(canyon, nClasses=4)
plot(canyon4$map)

# posso andare a cambiare i colori della legenda con la funzione colorRampPalette

# attenzione perchè ombre, acqua e altre cose strane possono andare a unirsi in una unica classe!
# per essere certi bisognerebbe andare sul campo e capire se ci sono differenziazioni tra vegetazioni/tra minerali diversi, ecc.















