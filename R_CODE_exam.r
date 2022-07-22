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

# Vediamo ora le informazioni dell'immagine satellitare creata nel 2015
class      : RasterBrick 
dimensions : 5490, 5490, 30140100, 3  (nrow, ncol, ncell, nlayers)
resolution : 20, 20  (x, y)
extent     : 699960, 809760, 4890240, 5000040  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=32 +datum=WGS84 +units=m +no_defs 
source     : L1C_T32TQQ_A000262_20150711T100008.tif 
names      : L1C_T32TQQ_A000262_20150711T100008.1, L1C_T32TQQ_A000262_20150711T100008.2, L1C_T32TQQ_A000262_20150711T100008.3 
min values :                                    0,                                    0,                                    0 
max values :                                  255,                                  255,                                  255 

# Vediamo ora le informazioni dell'immagine satellitare creata nel 2022
class      : RasterBrick 
dimensions : 5490, 5490, 30140100, 3  (nrow, ncol, ncell, nlayers)
resolution : 20, 20  (x, y)
extent     : 699960, 809760, 4890240, 5000040  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=32 +datum=WGS84 +units=m +no_defs 
source     : L1C_T32TQQ_A028033_20220719T095747.tif 
names      : L1C_T32TQQ_A028033_20220719T095747.1, L1C_T32TQQ_A028033_20220719T095747.2, L1C_T32TQQ_A028033_20220719T095747.3 
min values :                                    0,                                    0,                                    0 
max values :                                  255,                                  255,                                  255 



















