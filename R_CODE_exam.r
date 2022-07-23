# Progetto volto allo studio dell'area est della regione emiliano-romagnola, con particolar
# riguardo all'area appartenente al Parco Interregionale del Delta del Po dell'Emilia-Romagna.
# Lo studio verte sulla classificazione e la variabilità legate al territorio e sulla copertura del suolo.

# Informazioni sulle immagini: sviluppate da Sentinel-2, il giorno 17/07/2022

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

# Carico la lista dei file necessari
ilist <- list.files(pattern="T32TQQ_")

# Info ilist
[1] "T32TQQ_20220717T100611_B01_20m.jp2"
[2] "T32TQQ_20220717T100611_B02_20m.jp2"
[3] "T32TQQ_20220717T100611_B03_20m.jp2"
[4] "T32TQQ_20220717T100611_B04_20m.jp2"
[5] "T32TQQ_20220717T100611_B05_20m.jp2"
[6] "T32TQQ_20220717T100611_B06_20m.jp2"
[7] "T32TQQ_20220717T100611_B07_20m.jp2"
[8] "T32TQQ_20220717T100611_B11_20m.jp2"
[9] "T32TQQ_20220717T100611_B12_20m.jp2"

# Vado ad importare la lista di file, conferendo come oggetto "podelta"
podelta <- lapply(ilist, raster)

# li inserisco tutti in un unico stack
delta <- stack(podelta)

# Info "delta"
class      : RasterStack 
dimensions : 5490, 5490, 30140100, 9  (nrow, ncol, ncell, nlayers)
resolution : 20, 20  (x, y)
extent     : 699960, 809760, 4890240, 5000040  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=32 +datum=WGS84 +units=m +no_defs 
names      : T32TQQ_20//11_B01_20m, T32TQQ_20//11_B02_20m, T32TQQ_20//11_B03_20m, T32TQQ_20//11_B04_20m, T32TQQ_20//11_B05_20m, T32TQQ_20//11_B06_20m, T32TQQ_20//11_B07_20m, T32TQQ_20//11_B11_20m, T32TQQ_20//11_B12_20m 
min values :                     0,                     0,                     0,                     0,                     0,                     0,                     0,                     0,                     0 
max values :                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535  

# In questo modo i 9 file sono diventati un'unica immagine.

# Effettuo il plot dell'immagine satellitare che ne deriva.
plotRGB(delta, r=4, g=2, b=1, stretch="lin")

# Con questa modalità si vede l'immagine nel visibile (come la vedremmo con i nostri occhi).
# Layer 1 = Red
# Layer 2 = Green
# Layer 3 = Blue

# Creo le classi di suddivisione dell'area, e la verifico nel plot
delta3 <- unsuperClass(delta, nClasses=3)
cl <- colorRampPalette(c("blue", "green", "yellow"))(100)
plot(delta3$map, col=cl)

# Creo un unico Multiframe con la visione in spettro visibile e la classificazione.
par(mfrow=c(1,2))
plotRGB(delta, r=4, g=2, b=1, stretch="lin")
plot(delta3$map, col=cl)

# Salvo l'immagine creata
pdf("multi_VIS_class.pdf")
par(mfrow=c(1,2))
plotRGB(delta, r=4, g=2, b=1, stretch="lin")
plot(delta3$map, col=cl)

png("multi_VIS_class.png")
par(mfrow=c(1,2))
plotRGB(delta, r=4, g=2, b=1, stretch="lin")
plot(delta3$map, col=cl)

# Vado a calcolare le Frequenze delle classi
freq(delta3$map)
     value    count
[1,]     1 13223471
[2,]     2  9878369
[3,]     3  7038260

# Dalle frequenze si nota come l'area considerata è prevalentemente coperta da acqua,
# in particolar modo a causa della presenza dell'Adriatico. Per quanto riguarda suolo incolto e aree
# vegetate (agricoltura e pinete) hanno una frequenza abbastanza simile fra loro.

# Per visionare la percentuale occupata dalle varie classi:
totdelta <- 30140100
perc_acq <- (13223471*100)/totdelta
perc_veg <- (9878369*100)/totdelta
perc_suo <- 100 - (perc_acq + perc_veg)

# Credo un Dataframe per sistemare i risultati
Class <- c("Water", "Vegetation", "Soil")
Percent <- c(43.87, 32.78, 23.35)
data <- data.frame(Class, Percent)

# Risultato
       Class Percent
1      Water   43.87
2 Vegetation   32.78
3       Soil   23.35

# Vado ora a verificare la variabilità dell'area di interesse.

# Inizio dall'effettuare l'analisi multivariata delle bande, per decidere quale variabile utilizzare.
delPCA <- rasterPCA(delta)


















