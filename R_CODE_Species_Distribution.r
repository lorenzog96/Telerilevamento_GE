library(raster)
library(rgdal)
library(sdm)
library(ggplot2)
library(viridis)
library(RStoolbox)

# si usa direttamente un file di libreria esterna contenuta in sdm
file <- system.file("external/species.shp",package="sdm")
species <- shapefile(file)

plot(species, pch=19)

species$occurence

# vado a mappare solo le presenze (gli 1) (creare un subset)
plot(species[species$occurence == 1,], col="blue", pch=19)

occ <- species$occurence

plot(species[occ == 1,], col="blue", pch=19)

# per aggiungergli le assenze (gli 0)
plot(species[occ == 1,], col="blue", pch=19)
points(species[occ == 0,], col="red", pch=19)

# predittori: sono le mappe di varie cose (caratteri ambientali) che mi possono influenzare la presenza della specie
path <- system.file("external", package="sdm")
# esce fuori "C:/Users/Lorenzo/AppData/Local/R/win-library/4.2/sdm/external"
# precipitazione, quota, vegetazione, temperatura

# creo la lista
lst <- list.files(path=path, pattern="asc$", full.names=T)

# facciamo lo stack dei file
preds <- stack(lst)

# plottiamo i predittori
plot(preds)

# plottiamo ogni predittore con la presenza
elev <- preds$elevation
prec <- preds$precipitation
temp <- preds$temperature
vege <- preds$vegetation

plot(elev, col=cl)
points(species[occ==1], col="black", pch=19)

plot(prec, col=cl)
points(species[occ==1], col="black", pch=19)

plot(temp, col=cl)
points(species[occ==1], col="black", pch=19)

plot(vege, col=cl)
points(species[occ==1], col="black", pch=19)

# cerchiamo ora un modello in cui c'è si vede la probabilità di trovare la specie
# si usano funzioni dentro il pacchetto sdm
# funzione sdmData, servono i predittori e la situazione a terra
datasdm <- sdmData(train=species, predictors=preds)

# usiamo la funzione che crea il modello
mod1 <- sdm(occurence = elevation + precipitation + temperature + vegetation, data=datasdm, methods="glm")

# ora facciamo la previsione: funzione predict
pred1 <- predict(mod1, newdata=preds)

# si plotta la previsione
plot(pred1)
points(species[occ == 1,], pch=19)

# mettiamo tutto insieme per fare il confronto finale
par(mfrow=c(2,3))
plot(pred1, col=cl)
plot(vege, col=cl)
plot(prec, col=cl)
plot(temp, col=cl)
plot(elev, col=cl)

# oppure
final <- stack(preds, pred1)
plot(final, col=cl)





