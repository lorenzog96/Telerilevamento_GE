#analisi della temperatura della Groenlandia nel tempo

#richiamo di tutti i dati
library(raster)
setwd("C:/Users/Lorenzo/Desktop/lab")

# dobbiamo richiamare 4 dati differenti; lo si può fare importanto un singolo dato:
lst2000 <- raster("lst_2000.tif")

# informazioni di lst2000
class      : RasterLayer 
dimensions : 1913, 2315, 4428595  (nrow, ncol, ncell)
resolution : 1546.869, 1546.898  (x, y)
extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
crs        : +proj=stere +lat_0=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs 
source     : lst_2000.tif 
names      : lst_2000 
values     : 0, 65535  (min, max)

#vediamo ora il plot
plot(lst2000)

#Esercizio: importo tutti i dati in singolo
lst2005 <- raster("lst_2005.tif")
lst2010 <- raster("lst_2010.tif")
lst2015 <- raster("lst_2015.tif")

# creo una color palette per un multiframe
cl <- colorRampPalette(c("blue", "light blue", "pink", "red"))(100)

par(mfrow=c(2,2))
plot(lst2000)
plot(lst2005)
plot(lst2010)
plot(lst2015)

# Vediamo Come importare questo set di immagini tutto insieme
# Inizialmente va creata una lista
rlist <- list.files(pattern="lst")

rlist
[1] "lst_2000.tif" "lst_2005.tif" "lst_2010.tif" "lst_2015.tif"

# importo ora la lista
import <- lapply(rlist, raster)

# con import ora sono presenti tutti e 4 i file in R
# si può fare anche uno stack, così i singoli lst si mettono in un solo stack
 
 tgr <- stack(import)

# si crea un solo file
tgr
class      : RasterStack 
dimensions : 1913, 2315, 4428595, 4  (nrow, ncol, ncell, nlayers)
resolution : 1546.869, 1546.898  (x, y)
extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
crs        : +proj=stere +lat_0=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs 
names      : lst_2000, lst_2005, lst_2010, lst_2015 
min values :        0,        0,        0,        0 
max values :    65535,    65535,    65535,    65535 

plot(tgr)
# permette di creare il plot senza fare tutti i passaggi precedenti

plotRGB(tgr, r=1, g=2, b=3, stretch="lin")













