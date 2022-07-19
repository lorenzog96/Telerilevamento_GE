# Primo script utilizzato a lezione

# install.packages("raster")
library(raster)

# settaggio della cartella di lavoro per Windows
setwd("C:/Users/Lorenzo/Desktop")

# vado a importare dei dati RASTER (quindi immagini impilate)
brick(x,...)

# lo assegno ad un oggetto per essere più chiari
l2011 <- brick("p224r63 2011.grd")

# mettendo il nome dell'oggetto precedente l2011 vengono fuori tutte le informazioni dell'immagine
# si leggono così il numero di righe, il numero di colonne, il numero di bande e il numero di pyxel (oltre 4 milioni per ogni banda)
# si vedono anche i nomi delle bande (spectrum reflectance)
# si vedono i valori minimi e i valori massimi della riflettanza, che vanno da 0 a 1 (la riflettanza è la divisione tra quanto flusso radiante viene riflesso e quanto viene assorbito)
# se assorbo tutto, la riflettanza è pari a zero, se viene riflessa tutta la luce, la riflettanza è 1

# vediamo un primo plot dell'immagine caricata
plot(l2011)

# mettiamo colori noi per la legenda (colorRampPalette)
colorRampPalette(c("black", "grey", "light grey")) (100)

# i colori su R si chiamano in determinato modo, e si trova su google; si mettono le virgolette perchè sono già interni a R
# il 100 rappresenta i colori che deve usare in quel range di colori
# la c serve per il gruppo di elementi
# gli conferisco un nome
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)

