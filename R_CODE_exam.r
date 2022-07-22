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

# Attraverso l'oggetto i15 vado a leggerne le caratteristiche
class      : RasterBrick 
dimensions : 5490, 5490, 30140100, 3  (nrow, ncol, ncell, nlayers)
resolution : 20, 20  (x, y)
extent     : 699960, 809760, 4890240, 5000040  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=32 +datum=WGS84 +units=m +no_defs 
source     : L1C_T32TQQ_A000262_20150711T100008.tif 
names      : L1C_T32TQQ_A000262_20150711T100008.1, L1C_T32TQQ_A000262_20150711T100008.2, L1C_T32TQQ_A000262_20150711T100008.3 
min values :                                    0,                                    0,                                    0 
max values :                                  255,                                  255,                                  255 

# Attraverso l'oggetto i22 vado a leggerne le caratteristiche
class      : RasterBrick 
dimensions : 5490, 5490, 30140100, 3  (nrow, ncol, ncell, nlayers)
resolution : 20, 20  (x, y)
extent     : 699960, 809760, 4890240, 5000040  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=32 +datum=WGS84 +units=m +no_defs 
source     : L1C_T32TQQ_A028033_20220719T095747.tif 
names      : L1C_T32TQQ_A028033_20220719T095747.1, L1C_T32TQQ_A028033_20220719T095747.2, L1C_T32TQQ_A028033_20220719T095747.3 
min values :                                    0,                                    0,                                    0 
max values :                                  255,                                  255,                                  255 

# Vado a plottare attraverso la funzione plot RGB
r15 <- plotRGB(i15, r=1, g=2, b=3, stretch="lin")
r22 <- plotRGB(i22, r=1, g=2, b=3, stretch="lin")

# Creo un plot con un singolo multiframe con la funzione ggRGB
a15 <- ggRGB(i15, r=1, g=2, b=3, stretch="lin")
a22 <- ggRGB(i22, r=1, g=2, b=3, stretch="lin")
a15 + a22
# in questo modo si vedono a confronto le due situazioni, nel 2015 e nel 2022

# Effettuo ora la classificazione dell'area di interesse
c15 <- unsuperClass(i15, nClasses=2)
c22 <- unsuperClass(i22, nClasses=2)
# si decide di dividere in 2 classi per: acqua, suolo

# Vado a plottare l'immagine di rappresentazione delle classi del 2015
cl <- colorRampPalette(c("blue", "green"))(2)
plot(c15$map, col=cl)

# Vado a plottare l'immagine di rappresentazione delle classi del 2022
cl <- colorRampPalette(c("blue", "green"))(2)
plot(c22$map, col=cl)

# Classe 1 = acqua
# Classe 2 = suolo

# Calcolo le frequenze
freq(c15$map)
# Risultati:
     value    count
[1,]     1 12729006
[2,]     2  6531615
[3,]    NA 10879479
# NA rappresenta la parte di immagine satellitare in cui non è presente l'area

freq(c22$map)
# Risultati:
     value    count
[1,]     1 12731285
[2,]     2  6821291
[3,]    NA 10587524

# Vado a calcolare le percentuali delle due classi nelle due annate;
# il calcolo viene fatto escludendo NA

perc_Acqua_15 <- (12729006*100)/19260621
# perc_Acqua_15 = 60.08%
perc_Suolo_15 <- 100 - perc_Acqua_15
# perc_Suolo_15 = 39.92%

perc_Acqua_22 <- (12731285*100)/19552576
# perc_Acqua_22 = 65.11%
perc_Suolo_22 <- 100 - perc_Acqua_22
# perc_Suolo_22 = 34.89%

# Creo un Dataframe con i dati a confronto
Class <- c("Acqua", "Suolo")
Perc_2015 <- c(60.08, 39.92)
Perc_2022 <- c(65.11, 34.89)
Data <- data.frame(Class, Perc_2015, Perc_2022)
# Risultato di Data
  Class Perc_2015 Perc_2022
1 Acqua     60.08     65.11
2 Suolo     39.92     34.89

# Dai dati risulta che la quantità di area ricoperta da acqua
# sia aumentata negli ultimi anni.











