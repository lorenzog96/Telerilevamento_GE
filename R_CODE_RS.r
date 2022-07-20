# Primo script utilizzato a lezione

# install.packages("raster")
library(raster)

# settaggio della cartella di lavoro per Windows
setwd("C:/Users/Lorenzo/Desktop/lab")

# vado a importare dei dati RASTER (quindi immagini impilate)
brick(x,...)

# lo assegno ad un oggetto per essere più chiari
l2011 <- brick("p224r63_2011.grd")

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

# B1 -> blu; B2 -> verde; B3 -> rosso; B4 -> Infrarosso vicino (NIR).

# andiamo a plottare una singola banda, per creare una sola immagine
# plot della banda del blu, che si chiama B1_sre (che appartiene al gruppo l2011, quindi uso dollaro perchè è una corda che lega)
plot(l2011$B1_sre)
# provo a farlo senza usare il nome, ma cercando il primo elemento
plot(l2011[[1]])

# vado a modificare nuovamente la legenda, mettendo quella già creata prima (nero e bianco - cl)
plot(l2011$B1_sre, col=cl)
# ora usiamo il plot del blu, mettendo una scala di colori sul blu (nomi si cercano su google)
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (1000)
plot(l2011$B1_sre, col=clb)

#esportare un plot (immagine) nella cartella .lab, che lo nomino banda1
pdf("banda1.pdf")
plot(l2011$B1_sre, col=clb)
dev.off()
# il dev.off serve per chiudere l'immagine
# se vogliamo cambiare la cartella di salvataggio basta inserire la cartella; es: su download
pdf("download/banda2.pdf/")

# ci sono altre funzioni per fare questa esportazione, come
png("banda.png")

# se si vuole esportare il dataset intero, e non solo il plot si usa la funzione writeRaster

# plottare più bande insieme; ad esempio, plottiamo insieme la banda del blu e quella del verde
# prima creo la banda del verde
plot(l2011$B2_sre)
clv <- colorRampPalette(c("dark green", "green", "light green")) (1000)
plot(l2011$B2_sre, col=clv)
# ora creo un multiframe dove inseriremo i plot di blu e verde (1 riga e 2 colonne)
par(mfrow=c(1,2))
# vado ad inserirci i due plot
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clv)
# in questo modo prende diretto il primo nel numero 1 e il secondo nel numero 2

# per esportarlo come pdf
pdf("multiframe.pdf")
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clv)
dev.off()

# facciamo un multiframe con tutte e 4 le bande
# prima creo tutti plot
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (1000)
plot(l2011$B1_sre, col=clb)
clv <- colorRampPalette(c("dark green", "green", "light green")) (1000)
plot(l2011$B2_sre, col=clv)
clr <- colorRampPalette(c("violet", "red", "pink")) (1000)
plot(l2011$B3_sre, col=clr)
clnir <- colorRampPalette(c("red", "orange", "yellow")) (1000)
plot(l2011$B4_sre, col=clnir)
# ora li metto tutti insieme
par(mfrow=c(2,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clv)
plot(l2011$B3_sre, col=clr)
plot(l2011$B4_sre, col=clnir)

# CREARE IMMAGINI A COLORI
# plot l2011 in banda NIR band
clnir <- colorRampPalette(c("red", "pink", "yellow")) (1000)
plot(l2011$B4_sre, col=clnir)

# plot RGB layers (serve per lavorare con lo schema RGB component)
plotRGB(l2011, r=3, g=2, b=1)
# la funzione necessita di un altro argomento, lo Stretch, per vedere meglio i contrasti
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
# lin = lineare
# viene fuori l'immagine a colori naturali, quindi come la vede l'occhio umano
# ora vogliamo visualizzare anche l'infrarosso vicino, e bisogna sacrificarne un'altra, essendo che si possono usare solo 3 bande
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")
# da ricordare che le piante riflettono moltissimo sull'infrarosso, e avendo messo IR su R diventerà rosso nell'immagine
# spostandolo su un'altra componente, prenderà il colore della componente (es: g=green; b= blue)
plotRGB(l2011, r=3, g=4, b=2, stretch="lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="lin")

# per mettere uno Stretch non lineare (per istogrammi)
plotRGB(l2011, r=4, g=3, b=2, stretch="hist")

# Esercizio: fare multiframe con visualizzazione a colori naturali (visible RGB), Stretch lineare e Stretch a istogrammi
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="hist")

# Esercizio: si va ora a paragonare due immagini, una del 1988 e una del 2011
# carico l'immagine del 1988
l1988 <- brick("p224r63_1988.grd")

# le informazioni saranno sempre le stesse della precedente, ma cambia solo l'anno di cattura dell'immagine
# creiamo il multiframe
par(mfrow=c(2,1))
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")
# si vede che nel 1988 l'uomo inizia a creare le prime strade, ma c'è ancora notevolmente la foresta










