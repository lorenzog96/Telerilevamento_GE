### Inizio Progetto ###

# Progetto volto allo studio dell'area est della regione emiliano-romagnola, con particolar
# riguardo all'area appartenente al Parco Interregionale del Delta del Po dell'Emilia-Romagna.
# Lo studio verte sulla classificazione e la variabilità legate al territorio, sulla copertura del suolo, quindi sull'Indice di Vegetazione.

# Immagini Telerilevate: sviluppate da Sentinel-2 (filtro 2A), il giorno 17/07/2022 tra le ore 16:00 e le ore 18:00

# Carico tutti i pacchetti necessari per le varie funzioni che andrò ad effettuare
library(raster) # Necessario per caricare e operare dati raster ("immagini sovrapposte - bande")
library(RStoolbox) # Necessario per la produzione degli Indici Spettrali e la Classificazione
library(rasterdiv) # Pacchetto utile per definire indici di diversità tra differenti matrici
library(ggplot2) # Necessario come altra modalità oltre a raster per tradurre graficamente i dati
library(patchwork) # Pacchetto semplificato per la produzione di Multiframe
library(viridis) # Pacchetto utile per aggiungere palette di colori preimpostati e utili per lo studio

# Definisco la cartella da cui verranno prelevati i file
setwd("C:/Users/Lorenzo/Desktop/exam")

# Carico la lista dei file necessari, conferendo come oggetto "images-list"
ilist <- list.files(pattern="T32TQQ_")

# Info ilist (si tratta di file .jp2, che rappresentano le varie bande dello spettro di onde che vengono captate da Sentinel-2):
[1] "T32TQQ_20220717T100611_B01_20m.jp2"
[2] "T32TQQ_20220717T100611_B02_20m.jp2"
[3] "T32TQQ_20220717T100611_B03_20m.jp2"
[4] "T32TQQ_20220717T100611_B04_20m.jp2"
[5] "T32TQQ_20220717T100611_B05_20m.jp2"
[6] "T32TQQ_20220717T100611_B06_20m.jp2"
[7] "T32TQQ_20220717T100611_B07_20m.jp2"
[8] "T32TQQ_20220717T100611_B11_20m.jp2"
[9] "T32TQQ_20220717T100611_B12_20m.jp2"
[10] "T32TQQ_20220717T100611_B8A_20m.jp2"

# Le bande riflettono rispettivamente:
# B01 = Coastal Aerosol
# B02 = Blue
# B03 = Green
# B04 = Red
# B05 = Vegetation Red Edge
# B06 = Vegetation Red Edge
# B07 = Vegetation Red Edge
# B8A = Vegetation Red Edge
# B11 = SWIR
# B12 = SWIR

# Vado ad importare la lista di file, oggetto "podelta"
podelta <- lapply(ilist, raster)

# li inserisco tutti in un unico stack, in modo da sovrapporre le varie bande in un'unica immagine telerilevata.
delta <- stack(podelta)

# Info "delta"
class      : RasterStack 
dimensions : 5490, 5490, 30140100, 10  (nrow, ncol, ncell, nlayers)
resolution : 20, 20  (x, y)
extent     : 699960, 809760, 4890240, 5000040  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=32 +datum=WGS84 +units=m +no_defs 
names      : T32TQQ_20//11_B01_20m, T32TQQ_20//11_B02_20m, T32TQQ_20//11_B03_20m, T32TQQ_20//11_B04_20m, T32TQQ_20//11_B05_20m, T32TQQ_20//11_B06_20m, T32TQQ_20//11_B07_20m, T32TQQ_20//11_B11_20m, T32TQQ_20//11_B12_20m, T32TQQ_20//11_B8A_20m 
min values :                     0,                     0,                     0,                     0,                     0,                     0,                     0,                     0,                     0,                     0 
max values :                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535 

# Cosa significano i dati che ne fuoriescono:
# - RasterStack rappresenta la classe di appartenenza dell'immagine, e la inserisce tra le immagini ("stack") formate da più rasterLayer ("banda singola").
# - Le dimensioni definiscono: 5490 righe, 5490 colonne, 30.140.100 pixel totali, 10 bande.
# - Risoluzione = 20 metri.
# - Estensione: rappresentano i pixel di partenza e di arrivo, sia nella componente x che nella y (numero legato alla distanza dall'equatore e dal meridiano).
# - Crs va ad indicare i Sistemi di Riferimento: UTM (Universal Transverse Mercator) - suddivisione del Mondo in 60 spicchi; 32 rappresenta lo spicchio di appartenza 
#   per l'immagine in questione; WGS84 rappresenta l'ellissoide di riferimento; unità di misura: metro.
# - Nomi dei file ("bande") che compongono il RasterStack.
# - Minimo e Massimo sono i valori min e max di riflettanza delle varie bande.

# NB: (la riflettanza è la divisione tra quanto flusso radiante viene riflesso e quanto viene assorbito).
#     Se assorbo tutta la radiazione, la riflettanza è pari a 0; se viene riflessa tutta la luce, la riflettanza (in questo caso) è 65535 (16 bit).

# Effettuo il plot dell'immagine satellitare che ne deriva, con la funzione RGB (Red-Green-Blue).
plotRGB(delta, r=4, g=3, b=2, stretch="lin")

# Creo un pdf del plot, nominandolo "delta.pdf"; 
# il file finirà direttamente all'interno della cartella richiamata all'inizio.
pdf("delta.pdf")
plotRGB(delta, r=4, g=3, b=2, stretch="lin")

# Con questa modalità si vede l'immagine nel visibile (come la vedremmo con i nostri occhi).
# Layer 2 = Blue
# Layer 3 = Green
# Layer 4 = Red
# Layer 5 = NIR
# NB: bande legate al satellite Sentinel-2.

# Creo le Classi di suddivisione dell'area, e la verifico nel plot.
# Decido di creare 3 classi, in quanto i componenti principali del territorio sono: acqua, suolo nudo, vegetazione.
delta3 <- unsuperClass(delta, nClasses=3)

cl <- colorRampPalette(c("blue", "green", "yellow"))(100)
plot(delta3$map, col=cl)

# Creo un unico Multiframe con la visione in spettro visibile e la classificazione.
par(mfrow=c(1,2))
plotRGB(delta, r=4, g=3, b=2, stretch="lin")
plot(delta3$map, col=cl)

# Salvo l'immagine creata in pdf, denominazione "multi_VIS_class.pdf".
pdf("multi_VIS_class.pdf")
par(mfrow=c(1,2))
plotRGB(delta, r=4, g=3, b=2, stretch="lin")
plot(delta3$map, col=cl)

# Vado a calcolare le Frequenze delle classi.
freq(delta3$map)
     value    count
[1,]     1  7827975
[2,]     2 13290500
[3,]     3  9021625

# Dalle frequenze si nota come l'area considerata è prevalentemente ricoperta da acqua (classe 2 - richiama il maggior numero di pixel),
# in particolar modo a causa della presenza dell'Adriatico. Per quanto riguarda suolo incolto e aree
# vegetate (agricoltura e pinete), rispettivamente classe 1 e classe 3, hanno una frequenza abbastanza simile fra loro.

# Utilizzo i dati di frequenza per creare le percentuali di suddivisione del Land Cover.
totdelta <- 30140100
perc_acq <- (13290500*100)/totdelta
perc_veg <- (9021625*100)/totdelta
perc_suo <- 100 - (perc_acq + perc_veg)

# Creo un Dataframe per sistemare i risultati percentuali.
Class <- c("Water", "Vegetation", "Soil")
Percent <- c(44.1, 25.97, 29.93)
data <- data.frame(Class, Percent)

# Risultato
       Class Percent
1      Water   44.10
2 Vegetation   25.97
3       Soil   29.93

# Vado ora a verificare la Variabilità dell'area di interesse.

# Inizio con l'effettuare l'Analisi Multivariata delle bande, per decidere quale variabile utilizzare.
# Per iniziare, importo un'immagine che pesi di meno (con lo stack iniziale R non riesce ad effettuare il calcolo).
del3 <- brick("delta_VIS.pdf")
# Si tratta dell'immagine satellitare creata all'inizio attraverso le varie bande in uso 
# (caricata in modo singolo, in quanto le bande sono già tutte inserite insieme).

# Vado ora ad effettuare lo studio della Variabilità, partendo dal metodo di Analisi Multivariata (oggetto "delta-PCA").
delPCA <- rasterPCA(del3)

# Info delPCA:
$call
rasterPCA(img = del3)

$model
Call:
princomp(cor = spca, covmat = covMat[[1]])

Standard deviations:
  Comp.1   Comp.2   Comp.3 
85.07704 21.82987 11.18231 

 3  variables and  1102500 observations.

$map
class      : RasterBrick 
dimensions : 1050, 1050, 1102500, 3  (nrow, ncol, ncell, nlayers)
resolution : 1, 1  (x, y)
extent     : 0, 1050, 0, 1050  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : memory
names      :       PC1,       PC2,       PC3 
min values : -144.6142, -103.3550, -125.3460 
max values :  293.0341,  124.4206,  120.2690 


attr(,"class")
[1] "rasterPCA" "RStoolbox"

# Si nota come l'immagine caricata sia composta solo da 3 variabili, e da 1.102.500 osservazioni.

# Vado ora a vedere quanto pesano le 3 variabili sulla costruzione della variabilità dell'immagine.
summary(delPCA$model)

# Info delPCA$model:
Importance of components:
                           Comp.1      Comp.2      Comp.3
Standard deviation     85.0770414 21.82986595 11.18230755
Proportion of Variance  0.9232639  0.06078596  0.01595012
Cumulative Proportion   0.9232639  0.98404988  1.00000000

# Come indicato dal Dataframe in uscita, si nota che:
# - la componente 1 riesce a spiegare ben il 92.33% della variabilità dell'immagine;
# - la componente 2 spiega il 6.08% della variabilità;
# - la componente 3 spiega l'1.59%

# Di conseguenza, scelgo la componente n.1 per spiegare la variabilità dell'immagine (in quanto vado ad utilizzare una sola variabile).

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

# Calcolo infine la Deviazione Standard sulla componente 1 (finestra 3x3).
sd3 <- focal(comp1, matrix(1/9, 3, 3), fun=sd)

# Info sd3
class      : RasterLayer 
dimensions : 1050, 1050, 1102500  (nrow, ncol, ncell)
resolution : 1, 1  (x, y)
extent     : 0, 1050, 0, 1050  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : memory
names      : layer 
values     : 0, 21.04971  (min, max)

# I dati risultanti indicano che i valori di deviazione standard sull'immagine plottata vanno da 0 a 21.

# Creo il plot della deviazione standard con ggplot.
ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis (option="magma")

# Creo un Multiframe per mettere a confronto: Visibile, Componente 1 e Variabilità.
a1 <- ggRGB(del3, 1, 2, 3)

a2 <- ggplot() +
geom_raster(comp1, mapping=aes(x=x, y=y, fill=PC1))

a3 <- ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis (option="inferno")

a1 + a2 + a3

# Effettuo ora lo studio dell'Indice di Vegetazione.

# Creo un'immagine eliminando le bande non necessarie per lo studio, inserendo quindi una nuova cartella personale, dove si trovano i file (bande) necessarie.
setwd("C:/Users/Lorenzo/Desktop/exam/NDVI")

flist <- list.files(pattern="T32TQQ_")

[1] "T32TQQ_20220717T100611_B02_20m.jp2"
[2] "T32TQQ_20220717T100611_B03_20m.jp2"
[3] "T32TQQ_20220717T100611_B04_20m.jp2"
[4] "T32TQQ_20220717T100611_B05_20m.jp2"
[5] "T32TQQ_20220717T100611_B06_20m.jp2"
[6] "T32TQQ_20220717T100611_B07_20m.jp2"
[7] "T32TQQ_20220717T100611_B8A_20m.jp2"

# Vado ad importare la lista di file, conferendo come oggetto "deltadvi".
deltadvi <- lapply(flist, raster)

# li inserisco tutti in un unico stack.
dvidelta <- stack(deltadvi)

# Info dvidelta:
class      : RasterStack 
dimensions : 5490, 5490, 30140100, 7  (nrow, ncol, ncell, nlayers)
resolution : 20, 20  (x, y)
extent     : 699960, 809760, 4890240, 5000040  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=32 +datum=WGS84 +units=m +no_defs 
names      : T32TQQ_20//11_B02_20m, T32TQQ_20//11_B03_20m, T32TQQ_20//11_B04_20m, T32TQQ_20//11_B05_20m, T32TQQ_20//11_B06_20m, T32TQQ_20//11_B07_20m, T32TQQ_20//11_B8A_20m 
min values :                     0,                     0,                     0,                     0,                     0,                     0,                     0 
max values :                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535 

# Effettuo il plot dell'immagine satellitare che ne deriva.
plotRGB(dvidelta, r=4, g=3, b=2, stretch="lin")

# Vado ora ad effettuare lo studio dell'Indice di Vegetazione (DVI).
# DVI -> Differential Vegetation Index
# DVI = NIR - red (il calcolo vede sottrarre la banda del rosso dalla banda di infrarosso vicino, in quanto le piante hanno più alta riflettanza su tale banda
#       rispetto al resto degli elementi presenti in un'immagine satellitare.
NIR <- dvidelta[[4]] + dvidelta[[5]] + dvidelta[[6]] + dvidelta[[7]]
dvi2022 <- NIR - dvidelta[[3]]

# Info dvi2022
class      : RasterLayer 
dimensions : 5490, 5490, 30140100  (nrow, ncol, ncell)
resolution : 20, 20  (x, y)
extent     : 699960, 809760, 4890240, 5000040  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=32 +datum=WGS84 +units=m +no_defs 
source     : r_tmp_2022-07-24_121314_12416_67939.grd 
names      : layer 
values     : 0, 60724  (min, max)

# Creo il plot del DVI
cl <- colorRampPalette(c("dark blue", "yellow", "red", "black")) (100)
plot(dvi2022, col=cl)

# L'immagine che esce è caratterizzata da un'enorme distesa blu, legata alla presenza di acqua, che non riflette/riflette pochissimo
# nella banda del NIR; l'enorme presenza di giallo, invece, conferma una grande distesa di vegetazione, formata sia da zone rurali, 
# che da zone nauturali (canneti, praterie di zone umide, pinete, boschi igrofili).

# Vado ora a standardizzare il risultato, in modo tale da poterlo eventualmente confrontare con altre elaborazioni.
# NDVI = Normalized Diferential Vegetation Index
ndvi2022 <- dvi2022/(NIR+dvidelta[[3]])

# Info ndvi2022
class      : RasterLayer 
dimensions : 5490, 5490, 30140100  (nrow, ncol, ncell)
resolution : 20, 20  (x, y)
extent     : 699960, 809760, 4890240, 5000040  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=32 +datum=WGS84 +units=m +no_defs 
source     : r_tmp_2022-07-24_122954_12416_33240.grd 
names      : layer 
values     : 0.1379958, 0.9157373  (min, max)

# Da notare la normalizzazione visibile nei valori di min e max (tra 0 e 1 - non tiene in considerazione i bit dell'immagine).
# L'immagine che si crea va a evidenziare ancora meglio la vegetazione presente (in rosso, la riflettanza più elevata).

# Infine plottiamo in un unico Multiframe l'Indice di Vegetazione e l'immagine satellitare di partenza.
par(mfrow=c(1,2))
plotRGB(dvidelta, r=4, g=3, b=2, stretch="lin")
plot(ndvi2022, col=cl)

### Fine progetto ###


