install.packages("viridis")

library(raster)
library(viridis)
library(RStoolbox)
library(rasterdiv)
library(ggplot2)
library(patchwork)
setwd("C:/Users/Lorenzo/Destkop/lab")

# Esercizio: importare l'immagine del ghiacciaio
sentinel <- brick("sentinel.png")

sentinel # info che escono
class      : RasterBrick 
dimensions : 794, 798, 633612, 4  (nrow, ncol, ncell, nlayers)
resolution : 1, 1  (x, y)
extent     : 0, 798, 0, 794  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : sentinel.png 
names      : sentinel.1, sentinel.2, sentinel.3, sentinel.4 
min values :          0,          0,          0,          0 
max values :        255,        255,        255,        255 

# Esercizio: plottare la mappa con ggRGB
ggRGB(sentinel, r=1, g=2, b=3, stretch="lin")

# cambio composizione
ggRGB(sentinel, r=2, g=1, b=3, stretch="lin")

# Esercizio: plottare le due mappe in una unica
sen1 <- ggRGB(sentinel, r=1, g=2, b=3, stretch="lin")
sen2 <- ggRGB(sentinel, r=2, g=1, b=3, stretch="lin")
sen1+sen2

# CALCOLARE LA VARIABILITA'

nir <- sentinel[[1]]

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
#matrix -- matrice di 3x3 pixel; fun= function=sd deviazione standard
clsd <- colorRampPalette(c("blue", "green", "pink", "magenta")
plot(sd3, col=clsd)

# l'immagine che si crea fa vedere la variabilità: rocca dura, acqua, neve sono meno variabili, il resto è molto a più alta variabilità
# creiamo il plot con viridis (ggplot)

ggplot() + 
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer))

# viridis permette di inserire vari colori; ad esempio:
ggplot() + 
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis()+
ggtitle("Standard deviation by viridis")

# si cambia ancora legenda:
ggplot() + 
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "cividis")+
ggtitle("Standard deviation by viridis")

ggplot() + 
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "magma")+
ggtitle("Standard deviation by viridis")

#Esercizio: aumentare la finestra da 3x3 a 7x7
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)






