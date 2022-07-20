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
l92 <- ggRGB(l2006, r=1, g=2, b=3, stretch="lin")
l06 <- ggRGB(l1992, r=1, g=2, b=3, stretch="lin")
install.packages("patchwork")
library(patchwork)

l92 + l06
# oppure
l92/l06

# facciamo la classificazione
l92c <- unsuperClass(l92, nClasses=2)
l92c
plot(l92c$map)

# classe 1: foresta
# classe 2: aree agricole

l06c <- unsuperClass(l06, nClasses=2)
l06c
plot(l06c$map)

# classe 1: foresta
# classe 2: aree agricole

# adesso si possono calcolare le aree di foresta e di aree agricole
# si calcola con la FREQUENZA

freq(l92c$map)
freq(l06c$map)

# escono i pixel totali, quelli appartenenti alla Classe 1, quelli appartenenti alla Classe 2




















