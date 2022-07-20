# richiamo le librerie
library(raster)
library(RStoolbox)

# importo il primo file, attribuendolo ad un oggetto per semplificare i prossimi passaggi
l1992 <- brick("defor1_.jpg")
l1992 <- brick("C:/Users/Lorenzo/Desktop/lab/defor1_.jpg")

#guardo le info
l1992
class      : RasterBrick 
dimensions : 478, 714, 341292, 3  (nrow, ncol, ncell, nlayers)
resolution : 1, 1  (x, y)
extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : defor1_.jpg 
names      : defor1_.1, defor1_.2, defor1_.3 
min values :         0,         0,         0 
max values :       255,       255,       255 

# 255 sta per le informazioni totali che abbiamo (8 bit, quindi 256 informazioni)

#vado a creare i plot per vedere cosa mi indica graficamente l'immagine
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
# l'immagine è diventata rossa, quindi 1=NIR.
# layer 1 - NIR
# layer 2 - red
# layer 3 - green

#importo la seconda immagine
l2006 <- brick("C:/Users/Lorenzo/Desktop/lab/defor2_.jpg")

l2006
class      : RasterBrick 
dimensions : 478, 717, 342726, 3  (nrow, ncol, ncell, nlayers)
resolution : 1, 1  (x, y)
extent     : 0, 717, 0, 478  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : defor2_.jpg 
names      : defor2_.1, defor2_.2, defor2_.3 
min values :         0,         0,         0 
max values :       255,       255,       255 

plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# Esercizio: fare un multiframe con le due immagini una sopra l'altra
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# andiamo ora a fare il calcolo dell'Indice Spettrale, per misurare la salute della vegetazione
# DVI: Difference Vegetation Index
# il max DVI è 255 (NIR-red)
dvil1992 = l1992[[1]] - l1992[[2]]
dvil2006 = l2006[[1]] - l2006[[2]]
dvil1992
dvil2006


# creiamo il plot del DVI con una palette di colori
cl <- colorRampPalette(c("dark blue", "yellow", "red", "black")) (100)
plot(dvil1992, col=cl)
# quello che è giallo è suolo nudo
cl <- colorRampPalette(c("dark blue", "yellow", "red", "black")) (100)
plot(dvil2006, col=cl)
# il giallo rappresenta la deforestazione

# al posto degli elementi in dvi posso usare i nomi
dvil1992 = l1992$defor1_.1 - l1992$defor1_.2

#possiamo ora creare la differenza del DVI tra il 1992 e il 2006
dvi_dif = dvil1992 - dvil2006
cld <- colorRampPalette(c("blue", "red", "yellow")) (100)
# Messaggio di avvertimento:
# In dvil1992 - dvil2006 :
#  Raster objects have different extents. Result for their intersection is returned
# è un messaggio di avvertimento perchè c'è una stringa di pixel che non si ripete in emtrambe le immagini

plot(dvi_dif, col=cl)
#la zona rossa indica una variazione notevole, il giallo meno





