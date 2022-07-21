library(raster)
library(RStoolbox)
library(ggplot2)
library(patchwork)
library(viridis)

setwd("C:/Users/Lorenzo/Desktop/lab")

brick("sentinel.png")

sen <- brick("sentinel.png")

# banda 1 = nir
# banda 2 = red
# banda 3 = green

ggRGB(sen, 1, 2, 3)

# Esercizio: Immagine con la vegetazione che diventi verde, e il suolo viola

ggRGB(sen, 2, 1, 3)

# Per fare la Misura della Variabilità, abbiamo le 3 strade alternative.
# Usiamo la funzione rasterPCA (Analisi Multivariata)

senPCA <- rasterPCA(sen)

# Info che escono con senPCA
$call #funzione che abbiamo usato
rasterPCA(img = sen)

$model #modello che abbiamo usato
Call:
princomp(cor = spca, covmat = covMat[[1]])

Standard deviations:
  Comp.1   Comp.2   Comp.3   Comp.4 
77.33628 53.51455  5.76560  0.00000 

 4  variables and  633612 observations.

$map #ciò che useremo
class      : RasterBrick 
dimensions : 794, 798, 633612, 4  (nrow, ncol, ncell, nlayers)
resolution : 1, 1  (x, y)
extent     : 0, 798, 0, 794  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : memory
names      :       PC1,       PC2,       PC3,       PC4 
min values : -227.1124, -106.4863,  -74.6048,    0.0000 
max values : 133.48720, 155.87991,  51.56744,   0.00000 


attr(,"class")
[1] "rasterPCA" "RStoolbox"

# Per vedere le varie bande quanto pesano sulla variabilità usiamo la funzione summery

summary(senPCA$model)

Importance of components:
                           Comp.1     Comp.2      Comp.3 Comp.4
Standard deviation     77.3362848 53.5145531 5.765599616      0
Proportion of Variance  0.6736804  0.3225753 0.003744348      0
Cumulative Proportion   0.6736804  0.9962557 1.000000000      1

# la prima componente spiega il 67,36% della variabilità; la seconda 32,25 e la terza lo 0,37%.
# la zona cumulativa dice che bastano le prime due bande per spiegare il 99% della variabilità.

plot(senPCA$map)
# anche dall'immagine si vede bene quanta variabilità si riesce a riconoscere dalle 3 bande

pc1 <- senPCA$map$PC1
pc2 <- senPCA$map$PC2
pc3 <- senPCA$map$PC3

g1 <- ggplot() +
geom_raster(pc1, mapping=aes(x=x, y=y, fill=PC1))

g2 <- ggplot() +
geom_raster(pc2, mapping=aes(x=x, y=y, fill=PC2))

g3 <- ggplot() +
geom_raster(pc3, mapping=aes(x=x, y=y, fill=PC3))

g1+ g2+ g3

# Calcolo della deviazione standard

# di PC1
sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)

# Esercizio: creare una mappa con ggplot della deviazione standard della prima componente principale
ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer))

# cambiamo i colori con viridis
ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis (option="magma")

# l'opzione è variabile, ci sono tante legende

ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis (option="inferno")

# mettiamo insieme tutte le immagini

im1 <- ggRGB(sen, 2, 1, 3)
im2 <- ggplot() +
geom_raster(pc1, mapping=aes(x=x, y=y, fill=PC1))
im3 <- ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno")
im1 + im2 + im3

# Esercizio: Calcolo l'eterogeneità in una finestra 5x5 anziché 3x3
sd5 <- focal(pc1, matrix(1/25, 5, 5), fun=sd)

# Esercizio: Calcolo l'eterogeneità in una finestra 7x7 anziché 3x3
sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd)












