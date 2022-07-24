# Progetto volto allo studio dell'area est della regione emiliano-romagnola, con particolar
# riguardo all'area appartenente al Parco Interregionale del Delta del Po dell'Emilia-Romagna.
# Lo studio verte sulla classificazione e la variabilità legate al territorio e sulla copertura del suolo.

# Informazioni sulle immagini: sviluppate da Sentinel-2, il giorno 17/07/2022 tra le ore 16:00 e le ore 18:00

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

# Creo un pdf del plot
pdf("delta.pdf")
plotRGB(delta, r=4, g=2, b=1, stretch="lin")

# Con questa modalità si vede l'immagine nel visibile (come la vedremmo con i nostri occhi).
# Layer 1 = Blue
# Layer 2 = Green
# Layer 3 = NIR
# Layer 4 = Red

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
# Per iniziare, importo un'immagine che pesi di meno
del3 <- brick("delta.pdf")
# Si tratta dell'immagine satellitare creata all'inizio attraverso le varie bande in uso.

# Vado ora ad effettuare lo studio della variabilità, partendo dal metodo di Analisi Multivariata.
delPCA <- rasterPCA(del3)

# Info delPCA:
$call
rasterPCA(img = del3)

$model
Call:
princomp(cor = spca, covmat = covMat[[1]])

Standard deviations:
   Comp.1    Comp.2    Comp.3 
75.189163 33.288869  6.865298 

 3  variables and  1102500 observations.

$map
class      : RasterBrick 
dimensions : 1050, 1050, 1102500, 3  (nrow, ncol, ncell, nlayers)
resolution : 1, 1  (x, y)
extent     : 0, 1050, 0, 1050  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : memory
names      :        PC1,        PC2,        PC3 
min values : -159.26929, -116.80498,  -91.97826 
max values :   279.3643,   179.6011,   122.1632 


attr(,"class")
[1] "rasterPCA" "RStoolbox"

# Si nota come l'immagine caricata sia composta solo da 3 variabili, e da 1.102.500 osservazioni.
# Vado ora a vedere quanto pesano le 3 variabili sulla costruzione della variabilità dell'immagine.
summary(delPCA$model)

# Info delPCA$model:
Importance of components:
                           Comp.1     Comp.2      Comp.3
Standard deviation     75.1891634 33.2888691 6.865297918
Proportion of Variance  0.8303226  0.1627550 0.006922375
Cumulative Proportion   0.8303226  0.9930776 1.000000000

# Come indicato dal Dataframe in uscita, si nota che:
# - la componente 1 riesce a spiegare ben l'83.02% della variabilità dell'immagine;
# - la componente 2 spiega il 16.28% della variabilità;
# - la componente 3 spiega lo 0.7%

# Di conseguenza, scelgo la componente n.1 per spiegare la variabilità dell'immagine.

# Controllo graficamente che i dati ottenuti dall'analisi multivariata siano rappresentativi.
comp1 <- (delPCA$map$PC1)
comp2 <- (delPCA$map$PC2)
comp3 <- (delPCA$map$PC3)

# Creo un Multiframe con ggplot per la verifica grafica.
c1 <- ggplot() +
geom_raster(comp1, mapping=aes(x=x, y=y, fill=PC1))

c2 <- ggplot() +
geom_raster(comp2, mapping=aes(x=x, y=y, fill=PC2))

c3 <- ggplot() +
geom_raster(comp3, mapping=aes(x=x, y=y, fill=PC3))

c1+ c2+ c3

# Creo il PDF
pdf("rappr_analisi_multi.pdf")
c1+ c2+ c3

# Calcolo infine la Deviazione Standard sulla componente 1.
sd3 <- focal(comp1, matrix(1/9, 3, 3), fun=sd)

# Info sd3
class      : RasterLayer 
dimensions : 1050, 1050, 1102500  (nrow, ncol, ncell)
resolution : 1, 1  (x, y)
extent     : 0, 1050, 0, 1050  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : memory
names      : layer 
values     : 0, 21.27449  (min, max)

# Creo il plot della deviazione standard con ggplot.
ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis (option="magma")

# Creo un Multiframe per mettere a confronto Visibile, Componente 1 e Variabilità
a1 <- ggRGB(del3, 1, 2, 3)

a2 <- ggplot() +
geom_raster(comp1, mapping=aes(x=x, y=y, fill=PC1))

a3 <- ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis (option="inferno")

a1 + a2 + a3















