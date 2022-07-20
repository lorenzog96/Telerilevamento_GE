library(raster)
library(RStoolbox)
setwd("C:/Users/Lorenzo/Desktop/lab")

# Creare un codice per generare una mappa di copertura del suolo dal satellite

# Importo le immagini
l1992 <- brick("defor1_.jpg")
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
l2006 <- brick("defor2_.jpg")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# usiamo una nuova formula "ggRGB"
# serve per fare un facile multiframe con ggplot

install.packages("ggplot2")

# usiamo la funzione ggRGB
# a livello di codice è identico all'altro metodo
ggRGB(l2006, r=1, g=2, b=3, stretch="lin")
ggRGB(l1992, r=1, g=2, b=3, stretch="lin")

# per unire le due immagini in un multiframe
l1992c <- ggRGB(l2006, r=1, g=2, b=3, stretch="lin")
l2006c <- ggRGB(l1992, r=1, g=2, b=3, stretch="lin")
install.packages("patchwork")
library(patchwork)

l1992c + l2006c
# oppure
l1992c/l2006c

# facciamo la classificazione
l92c <- unsuperClass(l1992c, nClasses=2)
l92c
plot(l92c$map)

# classe 1: foresta
# classe 2: aree agricole

l06c <- unsuperClass(l2006c, nClasses=2)
l06c
plot(l06c$map)

# classe 1: foresta
# classe 2: aree agricole

# adesso si possono calcolare le aree di foresta e di aree agricole
# si calcola con la FREQUENZA

freq(l92c$map)
freq(l06c$map)

# escono i pixel totali, quelli appartenenti alla Classe 1, quelli appartenenti alla Classe 2

# vado a cercare la proporzione di pixel legati ad una classe sul totale
tot92 <- 341292
# tot rappresenta il numero totale di pixel dell'immagine l1992
perc_forest_92 <- 305213/tot92
# il numero rappresenta il numero di pixel che sono dentro la classe foresta
# l'89,4% dell'immagine è formato da foresta

# Esercizio: calcola la percentuale di area agricola in l1992
perc_agr_92 <- 100-perc_forest_92
# oppure
perc_agr_92 <- 341292-tot92

# perc_forest_92 <- 89,4%
# perc_agr_92 <- 10,6%

# facciamo ora le percentuali del 2006
tot06 <- 342726
perc_forest_06 <- [(177941*100)/tot06]
# 51,9%
perc_agr_06 <- 100-perc_forest_06
# 48,1%

# Dati finali:
# perc_forest_92 <- 89.4%
# perc_agr_92 <- 10.6%
# perc_forest_06 <- 51.9%
# perc_agr_06 <- 48.1%

# Andiamo a creare un DATAFRAME (Tabella) con 3 colonne e 2 righe
# Colonne
class <- c("Forest", "Agriculture")
percent_1992 <- c(89.4, 10.6)
percent_2006 <- c(51.9, 48.1)

multitemporal <- data.frame(class, percent_1992, percent_2006)

# per vederla: multitemporal - Invio
# oppure View(multitemporal)

# creiamo ora gli istogrammi

ggplot(multitemporal, aes (x=class, y=percent_1992, col=class))
# aes <- aestetics (colonne)
geom_bar(stat="identity", fill="white")

ggplot(multitemporal, aes (x=class, y=percent_2006, col=class))
geom_bar(stat="identity", fill="white")

