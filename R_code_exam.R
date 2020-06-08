# R code exam
1. R_code_first.r   
2. R_code_spatial.r   
3. R_code_spatial2.r
4. R_code_point_patterns.r   
5. R_code_teleril.r   
6. R_code_landcover.r   
7. R_code_multitemp.r   
8. R_code_multitemp_NO2.r   
9. R_code_snow.r   
10. R_code_patches.r  
11. R_code_crop.r
12. R_ code_spieces_distribution_modeling
################################################################################################################################
###  1 R_code_first.R
#primo codice
install.packages("sp") # SB il comando install.packages serve per installare i pacchetti che mi servono
# in R quando vado a prendere qualcosa di esterno ad R devo sempre metterlo tra virgolette
library(sp) # SB può anche essere sostituito da require e serve per richiamare la libreria che serve
data(meuse) # SB il comando data permette di selezionare i dati che mi servono
meuse # SB scrivendo il nome vedo le caratteristiche :
#class       : SpatialPointsDataFrame 
#features    : 155 
#extent      : 178605, 181390, 329714, 333611  (xmin, xmax, ymin, ymax)
#crs         : NA 
#variables   : 12
#names       : cadmium, copper, lead, zinc,  elev,     dist, om, ffreq, soil, lime, landuse, dist.m 
#min values  :     0.2,     14,   37,  113,  5.18,        0,  1,     1,    1,    0,      Aa,     10 
#max values  :    18.1,    128,  654, 1839, 10.52, 0.880389, 17,     3,    3,    1,       W,   1000 
head(meuse) # SB il comando head mi mostra le prime righe del dataset, potrei usare anche il comando names
#       x     y  cadmium copper lead zinc elev dist om ffreq soil lime landuse
# 1   181072 333611 11.7 85 299 1022 7.909 0.00135803 13.6 1 1 1 Ah# dist.m
# 2   181025 333558 8.6 81 277 1141 6.983 0.01222430 14.0 1 1 1 Ah
# 3   181165 333537 6.5 68 199 640 7.800 0.10302900 13.0 1 1 1 Ah
# 4   181298 333484 2.6 81 116 257 7.655 0.19009400 8.0 1 2 0 Ga
# 5   181307 333330 2.8 48 117 269 7.480 0.27709000 8.7 1 2 0 Ah
# 6   181390 333260 3.0 61 137 281 7.791 0.36406700 7.8 1 2 0 Ga

names(meuse)
#[1] "cadmium" "copper"  "lead"    "zinc"    "elev"    "dist"    "om"     
#[8] "ffreq"   "soil"    "lime"    "landuse" "dist.m" 
summary(meuse) # SB questa funzione mi mostra un sommario del mio dataset
pairs(meuse) # SB la funzione pairs produce un plot di tutte le variabili in un dataset
pairs(~ cadmium + copper + lead , data = meuse) # SB così dico ad R quali variabili voglio rappresentare e da quale dataset (data=meuse)
## EX: fare un pairs con cadmium copper lead zinc
pairs(~ cadmium + copper + lead + zinc, data = meuse)
# SB potevo fare anche pairs(meuse[,3:6]) perchè osservando le caratteristiche del dataset questi elementi sono i primi 4
# SB fare pairs ma cambiare il colore in rosso
pairs(meuse[,3:6], col="red") # SB bisogna mettere tra virgolette anche i testi come "red"
pairs(meuse[,3:6], col="red", pch=19) # SB con pch si intende il tipo di simbolo che usa per plottare (c'è elenco su internet)
pairs(meuse[,3:6], col="red", pch=19, cex=3) # SB cex è la dimensione del simbolo
pairs(meuse[,3:6], col="red", pch=19, cex=3, main="Primo pairs") # SB main = quello che voglio scrivere nel grafico
## Ex:fare la stessa cosa ma con la relazione tra elevatione gli elementi 
pairs(meuse[,3:7], col="red", pch=19, cex=3, main="Primo pairs") # SB ho visto che elevation corrisponde alla colonna 7
# SB 3 pannelli dall'esterno (già fatti)
 # panel.correlations <- function(x, y, digits=1, prefix="", cex.cor)
# {
#     usr <- par("usr"); on.exit(par(usr))
#     par(usr = c(0, 1, 0, 1))
#     r1=cor(x,y,use="pairwise.complete.obs")
#     r <- abs(cor(x, y,use="pairwise.complete.obs"))
# 
#     txt <- format(c(r1, 0.123456789), digits=digits)[1]
#     txt <- paste(prefix, txt, sep="")
#     if(missing(cex.cor)) cex <- 0.9/strwidth(txt)
#     text(0.5, 0.5, txt, cex = cex * r)
# }
# 
# panel.smoothing <- function (x, y, col = par("col"), bg = NA, pch = par("pch"),
#     cex = 1, col.smooth = "red", span = 2/3, iter = 3, ...)
# {
#     points(x, y, pch = pch, col = col, bg = bg, cex = cex)
#     ok <- is.finite(x) & is.finite(y)
#     if (any(ok))
#         lines(stats::lowess(x[ok], y[ok], f = span, iter = iter),
#             col = 1, ...)
# }
# 
# 
# panel.histograms <- function(x, ...)
# {
#     usr <- par("usr"); on.exit(par(usr))
#     par(usr = c(usr[1:2], 0, 1.5) )
#     h <- hist(x, plot = FALSE)
#     breaks <- h$breaks; nB <- length(breaks)
#     y <- h$counts; y <- y/max(y)
#     rect(breaks[-nB], 0, breaks[-1], y, col="white", ...)
# }

pairs(meuse[,3:6], lower.panel = panel.correlations, upper.panel = panel.smoothing, diag.panel = panel.histograms)
## EX : mettere come lower panel lo smoothing, come diagonal apnel gli istogrammi e come upper panel le correlazioni 
pairs(meuse[,3:6], lower.panel = panel.smoothing, upper.panel = panel.correlations, diag.panel = panel.histograms)# SB basta cambiare l'ordine
# SB come utilizzare la funzione plot
plot(meuse$cadmium,meuse$copper) # SB il $ lega la variabile al suo dataset (è meglio di attach perche funziona con tutti i pacchetti)
plot(cadmium, copper, pch=17, col="green", main="primo plot") # SB aggiungiamo il colore verde e il titolo 
plot(cadmium, copper, pch=17, col="green", main="primo plot", xlab="cadmio", ylab="rame") # SB aggiungiamo anche le etichette agli assi
plot(cadmium, copper, pch=17, col="green", main="primo plot", xlab="cadmio", ylab="rame", cex.lab=2, cex=2) # SB aggiustiamo anche la dimensione del simbolo

###################################################################################################################################
### 2  R_code_spatial.r
# R spatial: codice per fare analisi spaziali (24/03/20)
# SB il comando install.packages permette di installare il pacchetto R che comprende le funzioni che mi servono
install.packages("sp")
# SB con Library sto richiamando un paccetto
library(sp)
# SB prendiamo i dati
data(meuse)
# SB per visualizzare solo i primi dati
head(meuse)
# SB  plottare cadmium e led con la funzione plot
# SB allegare anche il dataframe, il comando attach permette di richiamare direttamente un elemento del dataframe
attach(meuse)
plot(cadmium, lead) # SB il comando plot invece porta alla visualizzazione grafice che volevo
# SB se voglio cambiare colore col=x, per cambiare carattere pch=num, cambiare dimens cex=num
plot (cadmium, lead, col="red", pch=19, cex=2)
# ex: plottare copper e zinco con simbolo triangolo (17) e colore verde
plot (copper, zinc, col = "green", pch=17)
# SB cambiare le etichette, metto tra virgolette perchè è un testo
plot (copper, zinc, col = "green", pch=17, xlab="rame", ylab="zinco")
# SB fare mulfiframe o multipanel in questo caso una riga e due colonne, in parica ho unito nella stessa fig. i 2 grafici di prima
par(mfrow=c(1,2)) # mfrow è vettore di forma c(nr, nc). I grafici saranno disegnati in una tavola di nr righe e nc colonne.
plot (cadmium, lead, col="red", pch=19, cex=2)
plot (copper, zinc, col = "green", pch=17, cex=2)
# SB inversione da riga colonna a colonna riga
par(mfrow=c(2,1)) #così visualizzo i due grafici uno sotto l'altro
plot (cadmium, lead, col="red", pch=19, cex=2)
plot (copper, zinc, col = "green", pch=17, cex=2)
#multiframe automatico 
install.packages ("GGally") # SB la libreria che lo permette è GGaly la devo quindi installare
# SB attenzione R è cage sensitive ovvero sensibile alle maiuscole
library(GGally) # SB richiamo la libreria
# SB la parentesi quadra serve per fare una sottoclasse cioè dai dati meuse tengo solo dalla colonna 3 alla 6
ggpairs(meuse[,3:6]) # SB questa funzione in pratica fa una matrice di dati già stabiliti
# SB su R per vedere come operano le funzioni basta scrivere la funzone 
ggpairs
#spatial analisi
head(meuse) # SB vedo l'inizio del dataset
# SB con la funzione coordinates dico al software come si chiamano
coordinates(meuse) =~ x+y
plot(meuse)
# SB funzione spplot la uso per ottenere un grafico spaziale
spplot(meuse,"zinc")


###############################################################################################################
### 3 R_code_spatial2.r

# SB libreria sp già installata in precedenza e andare sui dati che ci interessano
library(sp)
data(meuse)
# SB coordinate del dataframe 
coordinates(meuse)=~x+y
# SB sppplot dei dati con lo zinco (questa funzione è dentro sp per questo ho richiamato la libreria)
spplot(meuse, "zinc")
## ex: fare una tabella con ssplot con il rame
head(meuse) # SB con head vedo le prime 6 righe del dataset :
#         coordinates cadmium copper lead zinc  elev       dist   om ffreq soil
 #1 (181072, 333611)    11.7     85  299 1022 7.909 0.00135803 13.6     1    1
# 2 (181025, 333558)     8.6     81  277 1141 6.983 0.01222430 14.0     1    1
# 3 (181165, 333537)     6.5     68  199  640 7.800 0.10302900 13.0     1    1
# 4 (181298, 333484)     2.6     81  116  257 7.655 0.19009400  8.0     1    2
# 5 (181307, 333330)     2.8     48  117  269 7.480 0.27709000  8.7     1    2
# 6 (181390, 333260)     3.0     61  137  281 7.791 0.36406700  7.8     1    2
# SB potrei vedere il nome copper invece che con la funzione head con la funzione names(meuse)
names(meuse)
spplot(meuse, "copper")
# SB utilizzo della funzione bubble, è un modo per plottare dati diverso
bubble(meuse, "zinc")
## EX utilizzare la funzione bubble sul rame ma fare i pallini di colore rosso
bubble(meuse, "copper", col="red")
## EX osservare un'eventuale correlazione tra le due variabili tramite il plottaggio
# foraminiferi (io), carbon capture (marco)
# faccio un array (ho creato due oggetti)
foram <- c(10,20,35,55,67,80) # SB associo con la freccia a sin il nome della variabile all'ogetto
carbon<- c(5,15,30,70, 85, 99)
plot(foram, carbon, col="green", cex=2, pch=9) 
# SB importare dati esterni sul covid-19
# SB cartella da creare in C:/lab_eco
setwd("C:/lab_eco") # SB settare la workingdirectory
read.table("covid_agg.csv")  # SB questa funzione mi restituisce a video la tabela di dati che ho importato
# SB devo informare che la prima riga è composta dai titoli non da dati e devo assegnare il titolo
covid <-read.table("covid_agg.csv", head=TRUE) 
head(covid)
# quello che mi restituisce R è
#  cat     country cases       lat        lon
#1   1 Afghanistan    21  33.83890  66.026530
#2   2     Albania    51  41.14596  20.069178
#3   3     Algeria    49  28.16336   2.632366
#4   4     Andorra    14  42.54858   1.575688
#5   5     Antigua     1  17.28014 -61.791128
#6   6   Argentina    56 -35.37667 -65.167485


#######################################################################################################################
### 4 R_code_pointpatterns.r
#### codice per analisi dei patterns legati ai punti

setwd("C:/lab_eco")
# SB attribuire il nome al dataset che mi serve 
covid <- read.table("covid_agg.csv", head=T)
 # SB per visualizzare i primi dati 
 head(covid)
 # facciamo un primo plot
 plot(covid$country, covid$cases) # SB il dollaro collega la colonna al proprio dataset, potrei sostituirlo con attach(covid)
 # SB dobbiamo cambiare le lables perchè ho troppi dati sulla x e non vedo i nomi
 plot(covid$country, covid$cases, las=0) # SB las=0 è il default non cambia nulla è parallelo agli assi
 plot(covid$country, covid$cases, las=1) # SB las=1 è orizzontale
 plot(covid$country, covid$cases, las=2) # SB las=2 é perpendicolari agli assi
 plot(covid$country, covid$cases, las=3) # SB las=3 le imposta tutte verticali
  # SB si vede ancora male perchè ho troppi dati quindi mi conviene usare la funzione che diminuisce i caratteri (cex.axis)
  plot(covid$country,covid$cases,las=3, cex.axis=0.5)
 # SB plottiamo tramite ggplot2 , servono: il dataset , l'estetica e la geometria della mappatura)
 #per prima cosa lo devo installare 
 install.packages ("ggplot2")
 library(ggplot2) # SB avrei potuto usare il comando equivalente require(ggplot2)
 data(mpg) # SB caricamento dei dati
 head(mpg)
 # SB posso fare un plot d'esempio: la costrrtuzione è ggplot(data, estetica) + tipo
 # SB aest, sono in pratica le variabili che vedo esteticamente
 # SB tipo, è la geometria e si aggiunge con un più
 ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()
 ggplot(mpg, aes(x=displ, y=hwy)) + geom_line() # SB geom_line fa il grafico con linee
 ggplot(mpg, aes(x=displ, y=hwy)) + geom_polygon() # SB posso farlo anche a poligoni anche se non ha senso in questo caso
 # SB applichiamo ggplot ai dati relativi al covid, per vedere i nomi delle variabili basta fare names(covid)
 ggplot(covid, aes(x=lon, y=lat, size=cases)) + geom_point()
 ## ex: calcolare la densità 
 # SB density è il comando che lo permette, in pratica lo devo rasterizzare
 # SB prima installo il pacchetto che permette di rasterizzare un dato
 install.packages("spatstat")
 library(spatstat)
 #devo creare il dataset per spatstat
 attach(covid)
 covids <- ppp(lon, lat, c(-180,180), c(-90,90))# SB negli array metto l'area che mi interessa
 d<-density(covids) # SB associo alla densità il nome d
 plot(d)
 # SB plottare anche i punti con la funzione con la funzione points
 points(covids, pch=19)
 # SB aggiungiamo anche i bordi di dove si collocano i paesi come range di lat e lon, c'è un database internazionale che li ha già inseriri
# SB salvare il dataset comepointpattern.RData
 # SB recupero i dati di ieri che si trovano nella cartella lab_eco
setwd("C:/lab_eco") # setting della WD
load("pointpattern.RData") # SB caricamento dell' Rdata con la funzione load
ls() # SB per vedere i dati presenti salvati nelle varie sessioni si lavoro su r
library(spatstat)
# SB plottiamo di nuovo la mappa di ieri
plot(d)
# SB cambiamo i colori della mappa in modo arbitrario con la funzione  color ramp palette palette 
# SB associo una sigla alla mia palette e inserisco l'array dei colori
cl<- colorRampPalette(c('yellow', 'orange', 'red'))
# SB posso anche inserire quante gradazioni usare per rendere + precisa la mappa
cl<- colorRampPalette(c('yellow', 'orange', 'red')) (100)
plot(d, col=cl)
## es: plot mappa della densità dal verde al blu
cl<- colorRampPalette(c('green', 'violet', 'blue')) (200)
plot(d, col=cl)
# SB aggiungiamo ora i punti che avevamo ieri
points(covids)
# SB ora aggiungiamo anche i confini degli stati con le coordinate, questo dato è uno shapefile esterno
coastlines<-readOGR("ne_10m_coastline.shp")
# SB mi da un errore perchè ho messo red OGR(legge file vettoriali) senza aver prima installato la librereria giusta quindi bisogna installarla
install.packages("rgdal")
library(rgdal)
# SB ora posso richiamare il comando che prima non aveva funzionato e plottarlo
coastlines<-readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)
## ex: plot della mappa di densità con nuovi colori e aggiunta delle coast lines 
cl<- colorRampPalette(c('green', 'violet', 'blue')) (200)
plot(d, col=cl)
coastlines<-readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)
# SB altri esempi ci color ramp
# cl <- colorRampPalette(c('red','orange','yellow','green', 'blue')) (800)
# cl <- colorRampPalette(c('violet','yellow','green'))(100)
# cl <-colorRampPalette(c('white','blue','green','red','orange','yellow')) (150)
## Ex: caricare il workspace pointpattern.RData e crare un garfico della mappa di densità
library(spatstat) # le WD vanno sempre richiamate
library(rgdal) 
setwd("C:/lab_eco")
load("pointpattern.RData") # SB la funzione load serve per caricare dataset precedentemente salvati
ls() # SB vedo cosa ho 
cl <- colorRampPalette(c('cyan', 'purple', 'red')) (200) # SB assegno la color ramp palette che voglio
plot(d, col=cl, main=" ") # SB "d" era la densità
points(covids) # SB so aggiungono anche i punti
coastlines <- readOGR("ne_10m_coastline.shp") # SB assegno un nome più semplice allo shapefile della coastline
plot(coastlines, add=T)
# SB ora facciamo delle interpolazioni
head(covid)
marks(covids) <- covid$cases # SB la funzione marks estrae i dati associati al dataset
s <- Smooth(covids) # SB elimina lo smoothing dei valori numerici
plot(s)
# Exercise: plot s con anche i punti e e coastlines
cl <- colorRampPalette(c('cyan', 'purple', 'red')) (200) 
plot(s, col=cl, main="estimate of cases")
points(covids)
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)
# SB visualizzazione della mappa finale
par(mfrow=c(2,1))# SB le metto nella stessa schermata 
cl <- colorRampPalette(c('cyan', 'purple', 'red')) (200) 
plot(d, col=cl, main=" ")
points(covids)
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)
# SB interpolazione del numero di casi
cl <- colorRampPalette(c('cyan', 'purple', 'red')) (200) 
plot(s, col=cl, main="estimate of cases")
points(covids)
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)

######################################################################################################################
### 5 R_code_teleril.r
#### codice in R per fare analisi di immagini satellitari
# SB dobbiamo installare i pachetti utili al fine "raster" (già fatto) quindi devo solo richiamarlo con library
library(raster)
# SB richiamare la cartella 
setwd("C:/lab_eco/")
# SB associamo il nome al file con la freccia a sin e la funzione brick
# SB così abbiamo importato un immagine sattellitare all'interno di R
p224r63 <- brick("p224r63_2011_masked.grd")
# SB rinominiamola inserendo anche l'anno 
p224r63_2011 <- brick("p224r63_2011_masked.grd")
# SB cerchiamo di ricavare le info di base plottando 
plot(p224r63_2011)
# SB  ricarichiamo l'R data che abbiamo salvato che contiene le stringhe sopra
load("teleril.RData") #carico l'R data
ls() #con questa controllo che cosa contiene il mio file 
library(raster) # SB ricarichiamo la libreria che visualizza i file raster
plot(p224r63_2011) # SB plottiamo l'immagine di ieri 
## SB di seguito si vedono le sigle a quali bande corrispondono secondo la legenda standard di R
# B1: blue 
# B2: green
# B3: red
# B4: near infrared (nir)
# B5: medium infrared
# B6: thermal infrared
# B7: medium infrared
# ora cambiamo la scala di colori perchè cosi non è efficace con la funzione :
cl <- colorRampPalette(c('black','grey','light grey'))(100) #così assegno l'array che rappresenta i colori che voglio a cl
plot(p224r63_2011, col=cl) # SB riplotto tutto
cllow <- colorRampPalette(c('black','grey','light grey'))(5) #proviamo a diminuire la risoluzione
plot(p224r63_2011, col=cllow)
# SB  ora plottiamo la banda del blu con una scala di colori sul blu
names(p224r63_2011) # SB ora posso vedere i nomi 
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) #
plot(p224r63_2011$B1_sre, col=clb) # SB siccome non posso usare attach con raster uso il $ che collega una variabile al suo dataset
## es: plotta la banda del nir con la color ramp da rosso a giallo 
 clnir <- colorRampPalette(c('red','orange','yellow'))(100) #
 plot(p224r63_2011$B4_sre, col=clnir)
# SB  cerchiamo di fare un multi frame con plottate 4 bande diverse
par(mfrow=c(2,2)) # SB imposto le righe: voglio 2 righe e 2 colonne 
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) #
plot(p224r63_2011$B1_sre, col=clb) # SB la blu è stata plottat
clg <- colorRampPalette(c('dark green','green','light green'))(100) # SB verde
 plot(p224r63_2011$B2_sre, col=clg)
clr <- colorRampPalette(c('dark red','red','pink'))(100)# SB rosso
 plot(p224r63_2011$B3_sre, col=clr) 
clnir <- colorRampPalette(c('red','orange','yellow'))(100) # SB vicino infrarosso nir
 plot(p224r63_2011$B4_sre, col=clnir)
# SB dev.off è un comando che permette di chiudere la finestra dove compaiono le immagini
dev.off()
# SB netural colours: plottare le immagini come l evedrebbe un occhio umano (RGB) devo in pratica montare le bande sulle 3 componenti del pc cioè RGB
# R= banda del rosso =B3
# G = banda del verde = B2
# B = banda del blu = B1
# B4 = near infrared
plotRGB(p224r63_2011, r=3, g=2, b=1)
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") # SB uso stretch (lineare) per aumentare la rislouzione dell'immagine visto che è tutta nera
#false colours
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")# SB abbiamo messo una componente che l'occhio umano non può vedere
# SB in questo modo le piante che riflettono l'infrarosso si vedono di più (si vede la foresta che a occho nudo non avremmo distinto)
# SB per salvare un grafico in pdf
pdf("primografico.pdf")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
dev.off()
# SB ora facciamo un grafico che metta in confronto tutto
par(mfrow =c(1,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
#es: mettere nir nella componente green
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
#es: mettere nir nella blu
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
# SB devo caricare anche l'R.Data che abbiamo salvato che contiente il codice scritto fino ad ora
load("teleril2.RData")
# SB guardiamo i dati che abbiamo salvato nelle volte precedenti con la funzione
ls()
# SB per importare un immagine satellitare (servono quelle dell 88) occorre usare il comando brick
p224r63_1988 <- brick ("p224r63_1988_masked.grd") # SB gli ho ridato il nome che volevo con la freccina 
# SB facciamo un primo plot
plot(p224r63_1988)
# SB la volta scorsa avevamo modificato la color ramp palette per visualizzare meglio 
par(mfrow=c(2,2)) #imposto le righe: voglio 2 righe e 2 colonne 
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) #
plot(p224r63_1988$B1_sre, col=clb) # SB la blu è stata plottata copiando il comando già fatto prima ma ricordandoci di cambiare il nome dell'immagine 1988
clg <- colorRampPalette(c('dark green','green','light green'))(100) # SB verde
 plot(p224r63_1988$B2_sre, col=clg)
clr <- colorRampPalette(c('dark red','red','pink'))(100)# SB rosso
 plot(p224r63_1988$B3_sre, col=clr) 
clnir <- colorRampPalette(c('red','orange','yellow'))(100) # SB vicino infrarosso nir
plot(p224r63_1988$B4_sre, col=clnir)
dev.off() # SB cancello i plot 
# SB ora cerchiamo di fare il plot in sistema RGB mettendo in ognuna delle componenti la banda corrispondente 
# R= banda del rosso =3
#G = banda del verde = 2
# B= banda del blu = 1
# B4= nir infrared =4
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
## es: plottare la stessa immagine con al posto della componente red la infrarossi 
plotRGB(p224r63_1988, r=4, g=2, b=1, stretch="Lin")
# SB ora plottiamo la 1988 e la 2011 per fare un confronto
par(mfrow=c(2,1)) # SB faccio un multipanel per vedere le immagini affiancate ho fatto due righe 
plotRGB(p224r63_1988, r=4, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=2, b=1, stretch="Lin")
# SB ora calcoliamo l indice DVI sottraendo la banda del red alla banda dell'infrarosso per ogni pixel
# div1988= nir1988-r1988
dvi1988<-p224r63_1988 $ B4_sre -  p224r63_1988 $ B3_sre # SB il dollaro collega le parti, (il b3 e b4 sono le bande)
plot(dvi1988)
# SB plot anche del 2011
dvi2011<- p224r63_2011 $ B4_sre -  p224r63_2011 $ B3_sre
plot(dvi2011)
difdvi <- dvi2011-dvi1988
cldvi <- colorRampPalette(c('light blue','light green','green'))(100) # SB cambio colore
plot(dvi2011, col=cldvi)
# SB faccio la differenza cioè un ANALISI MULTITEMPORALE tra i due anni
difdvi <- dvi2011-dvi1988
plot(difdvi)
# SB cambiamo la legenda 
cldifdvi<- p224r63_2011 colorRampPalette(c('red','white','blue'))(100) # 
plot(difdvi, col=cldifdvi)
# SB visualizziamo l'immagine rgb del 1988 , quella del 2011 e la differenza del dvi 
par(mfrow=c(3,1)) #faccio multiframe con 3 righe 
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plot(difdvi, col=cldifdvi)
# SB ora cerchiamo di modificare la risoluzione o anche detta grana inferiore sull'imagine del 2011
p224r63_2011lr <- aggregate( p224r63_2011, fact=10) # SB il pixel è aumentato di un fattore 10 (il pc fa una media dei pixel interni alla nuova maglia)
# SB  per vedere le caratteristiche dell' immagine pasta crivere il nome in r
p224r63_2011
# SB ora facciamo un multipanel con le due immagini a risoluzione diversa 
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr, r=4, g=3, b=2, stretch="Lin")
# SB proviamo con una risoluzione ancora diversa 
p224r63_2011lr50 <- aggregate( p224r63_2011, fact=50)
p224r63_2011lr50 # SB si osserva che il fattore è 50 quindi 1500m 
par(mfrow=c(3,1)) # SB faccio di nuovo un multipanel con le 3 risoluzioni diverse 
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr50, r=4, g=3, b=2, stretch="Lin")
# SB possiamo creare il DBI con le immagini a risoluzione bassa di fattore 50 
p224r63_2011lr50 <- p224r63_2011lr50$B4_sre - p224r63_2011lr50$B3_sre
 plot( p224r63_2011lr50)
# SB facciamo lo stesso anche per il 1988
p224r63_1988lr50 <- aggregate(p224r63_1988, fact=50)
dvi1988lr50 <- p224r63_1988lr50$B4_sre - p224r63_1988lr50$B3_sre
# SB ora facciamo la differenza tra i due anni con risoluzione 50 
dvi2011lr50 <- p224r63_2011lr50$B4_sre - p224r63_2011lr50$B3_sre
 dvi1988lr50 <- p224r63_1988lr50$B4_sre - p224r63_1988lr50$B3_sre
 difdvilr50 <- dvi2011lr50 - dvi1988lr50
plot(difdvilr50,col=cldifdvi)
par(mfrow=c(2,1))
plot(difdvi, col=cldifdvi)
plot(difdvilr50, col=cldifdvi)
###########################################################################################################################
### 6. R_code_landcover.r  
##### codice R per fare analisi di tipo "land cover"
# devo settare la WD
setwd("C:/lab_eco")
library(raster) # SB richiamiamo la libreria raster che ci serve
install.packages("RStoolbox") # SB installiamo la libreria RStoolbox che mi permette di fare analisi di questo tipo
library(RStoolbox) # SB la richiamo 
# SB importiamo i dati che sono stati scaricati da iol
p224r63_2011 <- brick("p224r63_2011_masked.grd") # SB la funzione che lo permette e brick, l'argomento va tra virgolette perchè vado ad
#importare elementi "fuori da r"
# le bande sono : 1=b, 2=g, 3=r, 4= nir
# SB associare le bande di riferimento al colore rgb che voglio con la funzione plotRGB
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
# SB ora faccio una suddivisione in 4 classi (nClasses=4) con la funzione unsuperclass (classificazione non supervisionata)
p224r63_2011c <- unsuperClass(p224r63_2011, nClasses=4) # SB le associo un nome 
p224r63_2011c # SB mi da le inso sul risultato della suddivisione in 4 classi:
#$map
#class      : RasterLayer 
#dimensions : 1499, 2967, 4447533  (nrow, ncol, ncell)
#resolution : 30, 30  (x, y)
#extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#source     : C:/Users/utente/AppData/Local/Temp/Rtmp0SmpLZ/raster/r_tmp_2020-05-28_154348_13572_60358.grd 
#names      : layer 
#values     : 1, 4  (min, max)
plot(p224r63_2011c$map) # SB eseguo il plot che mi restituisce la mappa con le 4 classi
clclass <- colorRampPalette(c('red', 'green', 'blue', 'black'))(100) # SB associo a clclass la ramp palette desiderata
plot(p224r63_2011c$map, col=clclass)
# SB col più diminuisco il numero delle classi col più l'errore aumenta.


############################################################################################################################
###à 7 R_code_analisimultitemp.r
# SB settiamo la working directory
setwd("C:/lab_eco/")
# SB procediamo a caricare i dati
# SB richiamiamo la libreria utile ovvero raster
library(raster)
# SB ora con la funzione brick carico le immagini cioè il nostro dataset
defor1 <- brick("defor1_.jpg") # SB le associo anche il nome defor1
defor2 <- brick("defor2_.jpg") # SB le associo il nome defor2
# SB plottiamo i dataset utilizzando le bande comprese al loro interno
defor1 # SB così vedo le caratteristiche (names : defor1_.1, defor1_.2, defor1_.3 sono i nomi delle bande)
# SB defor1_.1= nir, defor1_.2=red, defor1_.3= green
# SB devo associale le tre bande di riferimento al colore rgb che voglio: mettiamo la nir con il red
# SB la funzione che lo permette e plotRGB
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
# SB plottiamo anche l'immagine 2 che si riferisce ad una data successiva 
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin") # SB osserviamo che la porzione rossa è molto inferiore perchè la foresta pluviale è stata ridotta( ho poca riflettanza nel NIR)
# SB plottiamo le due immagini nello stesso grafico
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")
# SB classifichiamo in 2 classi in modo tale da scontornare tutto quello che è foresta e non 
# SB la funzione che lo permette e unsuperclass (classificazione non supervisionata) in pratica raggruppa i pixel simili 
# SB la funzione è in una libreria diversa la devo caricare
library(RStoolbox)
d1c <- unsuperClass(defor1, nClasses=2) # SB diamo il nome e decidiamo quante classi servono 
plot(d1c$map)
# SB facciamo dei colori migliori
cl <- colorRampPalette(c('black','green'))(100) # 
plot(d1c$map, col=cl)
# SB facciamo la classificazione anche del'immagine più recente chiamata defor2
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)
cl <- colorRampPalette(c('black','green'))(100)
plot(d2c$map, col=cl)
# SB plot di confronto con le due mappe ottenute
par(mfrow=c(2,1))
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)
# SB fare stima dei valori, occore misurare la frequenza delle due classi con la funzione freq
freq(d1c$map)
##       value  count    # SB ottengo questi valori tabulati
##[1,]     1  34271
##[2,]     2 307021
#calcoliamo la proporzione, ci serve il totale delle celle 
totd1<-34271 + 307021
totd1
# [1] 341292 trovo questo 
#ora ci possiamo calcolare le percentuali 
percent1 <- freq(d1c$map) * 100 / totd1
percent1
# ottengo questo :           
#value    count
#[1,] 0.0002930042 10.04155
#[2,] 0.0005860085 89.95845
 ## facciamo lo stesso per la mappa 2
 freq(d2c$map)   
# value  count
#[1,]     1 179515
#[2,]     2 163211
totd2<-  179515+163211
totd2 
#[1] 342726
percent2 <- freq(d2c$map) * 100 / totd1
 percent2
  #ottengo            value    count
#[1,] 0.0002930042 52.59865
#[2,] 0.0005860085 47.82151

# SB dobbiamo creare una nuova colonna
cover <- c("Agriculture","Forest")
# SB una nuova con i valori 
before <- c( 10.04155,89.95845)
after  <- c(179515, 163211)
output <- data.frame(cover,before,after) # SB abbiamo creato un dataframe 
View(output) # vediamo una tabella 
#### 5/05
# apriamo la cartella di lavoro giusta e carichiamo il dataset che avevamo creato la scorsa lezione
setwd("C:/lab_eco/")
load("defor.RData") # SB così importo un dataset precedentemente salvato su R
ls()
library(raster)
par(mfrow=c(1,2)) #fare un plot coni due anni a confronto dell altra volta
cl <- colorRampPalette(c('black','green'))(100) # 
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)
# SB creare un output cioè un dataframe con il tipo di landcover, la percentuale prima e dopo il disboscamento
cover <- c("Agriculture","Forest")
before <- c(10.9,89.1)
after <- c(48.2,51.8) # SB i valori non corrispondono perchè per vedere uguale agli altri ho scaricato l'RData da iol 
output # SB vedo la tabellina che ho creato la volta scorsa
# SB facciamo un plot dove si vedono le percentuali a confronto con ggplot della deforestazione
library(ggplot2)
ggplot(output, aes(x=cover, y=before, color=cover)) +
geom_bar(stat="identity", fill="white")
# SB stessa cosa ma dopo la deforestazione 
ggplot(output, aes(x=cover, y=after, color=cover)) +
geom_bar(stat="identity", fill="white")
# SB facciamo un plot di entrampi insieme, instaliamo un altro paccheto perchè la funz. par non funziona con ggplot
install.packages("gridExtra")
library(gridExtra)
# SB la funzione che lo permette è grid.arrange e in pratica prende i vari plot e li mette nello stesso grafico
# SB si assegna un nome al precedente ggplot
grafico1<-ggplot(output, aes(x=cover, y=before, color=cover)) +
geom_bar(stat="identity", fill="white")
grafico2<- ggplot(output, aes(x=cover, y=after, color=cover)) +
geom_bar(stat="identity", fill="white")
grid.arrange(grafico1, grafico2, nrow=1) # SB se ometto nrow me li mette uno sotto l'altro in pratica corrisponde ad mfrow
# SB aggiungiamo un limite alla y=100 in modo tale che i grafici siano più confrontabili 
grafico1 <- ggplot(output, aes(x=cover, y=before, color=cover)) + 
geom_bar(stat="identity", fill="white") +
ylim(0, 100)
grafico2 <- ggplot(output, aes(x=cover, y=after, color=cover)) + 
geom_bar(stat="identity", fill="white") +
ylim(0, 100) 
grid.arrange(grafico1, grafico2, nrow = 1)


#################################################################################################################################
#### 8 R_code_multitempNO2.r
# SB settiamo la wd per prima cosa
setwd("C:/lab_eco/")
# SB la libreria che utilizziamo è raster quindi la richiamo
library(raster) #in realtà non avendo chiuso R non serviva farlo 
# SB ora importiamo tramite la funzione ratser la prima immagine presa da iol che si trova in lab_eco
EN01 <- raster("EN_0001.png") # SB le do anche un nome più comodo
plot(EN01) # SB così la visualizzo la situazione dell'azoto a gennaio
# SB procediampo ad importare tutte le immagini 
EN02 <- raster("EN_0002.png")
EN03 <- raster("EN_0003.png")
EN04 <- raster("EN_0004.png")
EN05 <- raster("EN_0005.png")
EN06 <- raster("EN_0006.png")
EN07 <- raster("EN_0007.png")
EN08 <- raster("EN_0008.png")
EN09 <- raster("EN_0009.png")
EN10 <- raster("EN_0010.png")
EN11 <- raster("EN_0011.png")
EN12 <- raster("EN_0012.png")
EN13 <- raster("EN_0013.png")
# SB potevo fare un ciclo for per fare prima 
# list_rast=list()
# for(i in 1:length(rlist)){
#  r=raster(rlist[[i]])
#  list_rast[[i]]=r
# }
# SB oppure un altro metodo studiato ah hoc per R
library(raser)
setwd("~/lab/esa_no2") # SB si crea una sottocartella con tutte le immagini .png
rlist=list.files(pattern=".png", full.names=T) # SB in pratica racchiude i file che ci interessano in una lista
list_rast=lapply(rlist, raster) # SB la funzione lapply le importa
# SB se scrivo rlist su R mi mostra la lista con le 13 immagini.
# SB plot della immagine uno e della 13 per vedere confronto
cl <- colorRampPalette(c('red','orange','yellow'))(100) #cambiamo i colori 
plot(EN01, col=cl)
plot(EN013, col=cl)
par(mfrow=c(1,2)) # SB si vede meglio se le metto affiancate
plot(EN01, col=cl)
plot(EN13, col=cl)
# SB ora facciamo una differenza tra le due immagini 
difno2 <- EN13 - EN01
cldif <- colorRampPalette(c('blue','black','yellow'))(100) #
plot(difno2, col=cldif)
# SB facciamo delle statistiche di base
# SB plottiamo tutte le mappe, ho due strade per farlo  
# SB la più lentapar(mfrow=c(4,4))
par(mfrow=c(4,4))
plot(EN01, col=cl)
plot(EN02, col=cl)
plot(EN03, col=cl)
plot(EN04, col=cl)
plot(EN05, col=cl)
plot(EN06, col=cl)
plot(EN07, col=cl)
plot(EN08, col=cl)
plot(EN09, col=cl)
plot(EN10, col=cl)
plot(EN11, col=cl)
plot(EN12, col=cl)
plot(EN13, col=cl)
# SB il metodo più veloce è creare uno stack 
EN <- stack(EN01,EN02,EN03,EN04,EN05,EN06,EN07,EN08,EN09,EN10,EN11,EN12,EN13) # SB la funzione stack imballa le 13 immagini in una sola 
cl <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(EN, col=cl) # SB plot della nuova immagine che comprende tutte le 13 precedenti e con una nuova nuance di colori.

##12/05 rifacciamo l'importazione dei dati usando lapply
library(raster) #richiamiamo la libreria raster
#abbiamo prima spostato tutti i file da importare in una sottocartella della nosta lab_eco
setwd("C:/lab_eco/esa_no2")
rlist <- list.files(pattern=".png") #creaiamo una lista di file che hanno in comune l'estensione .png
rlist #scrivendo il nome che le ho associato vedo i file che sono compresi 
# vedo questa lista infatti:  [1] "EN_0001.png" "EN_0002.png" "EN_0003.png" "EN_0004.png" "EN_0005.png"
 [6] "EN_0006.png" "EN_0007.png" "EN_0008.png" "EN_0009.png" "EN_0010.png"
[11] "EN_0011.png" "EN_0012.png" "EN_0013.png"
#adesso con la funzione raster posso importare le immagini
#lapply applica una funzione ad una lista, in pratica applico raster alla lista che ho appena crreato
listafinale <- lapply(rlist, raster)
listafinale #mi fa vedere le caratteristiche dei 13 file 
#vedo [[1]]
# class      : RasterLayer 
# band       : 1  (of  3  bands)
# dimensions : 432, 768, 331776  (nrow, ncol, ncell)
# resolution : 1, 1  (x, y)
# extent     : 0, 768, 0, 432  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : C:/lab_eco/esa_no2/EN_0001.png 
# names      : EN_0001 
# values     : 0, 255  (min, max)
EN <- stack(listafinale) # SB questa Funzione raggruppa tutte le 13 immagini in una unica 
# SB facciamo la differenza tra la prima immagine e l'ultima 
difEN <- EN$EN_0013 - EN$EN_0001 # SB il dollaro lega 
cld <- colorRampPalette(c('blue','white','red'))(100) # 
plot(difEN, col=cld)
cl <- colorRampPalette(c('red','orange','yellow'))(100) #
plot(EN, col=cl)
boxplot(EN) # SB mi fa un grafico dove si vede in un certo senso la distribuzione 
boxplot(EN, horizontal=T) # SB lo metto orrizontale perchè non si capiva bene 
boxplot(EN, horizontal=T,outline=F) # SB si vede ancora meglio il calo dei valori massimi 
boxplot(EN, horizontal=T,outline=F,axes=T) # SB aggiungo anche gli assi
boxplot(EN, horizontal=T,outline=F,axes=F)   # SB vedo comè senza perchè in realtà =T è quello d default

#########################################################################################################
#### 9 R_code_snowcover.r

# SB il primo passo è sempre settare la wd
setwd("C:/lab_eco/") 
# SB installare la libreria che apre file .nc
install.packages("ncdf4")
library(ncdf4) # SB richiamare le librerie che mi serviranno
library(rgdal)
library(raster)
# SB importare i dati(con la funzione raster) da lab_eco che ho scaricato da copernicus e messo nella cartella 
snowmay <- raster("c_gls_SCE500_202005180000_CEURO_MODIS_V1.0.1.nc") # SB gli associo il nome snowmay
## ex: plottare snowmay con una color ramp
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 
plot(snowmay,col=cl) # SB lo plotto
# es importare le immagini di altri anni
# SB setto la nuova WD per la cartella dove ho messo le immagini .tif
setwd("C:/lab_eco/snow")
# SB ora tramite la funzione lapply importo tutti gli elementi 
rlist=list.files(pattern=".tif", full.names=T) # SB creo una lista di file .tif
list_rast <- lapply(rlist, raster) # SB la associo ad un nome
snow.multitemp <- stack(list_rast)
plot(snow.multitemp,col=cl)
# SB facciamo dei confronti 2000 vs 2020
par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl)
plot(snow.multitemp$snow2020r, col=cl)
par(mfrow=c(2,1)) 
# SB unifichiamo il limite tra le due immagini tramite la funzione zlim=c(qua inserisco i limiti)
plot(snow.multitemp$snow2000r, col=cl, zlim=c(0,250))
plot(snow.multitemp$snow2020r, col=cl, zlim=c(0,250))
# SB calcoliamoci la differenza
difsnow = snow.multitemp$snow2020r - snow.multitemp$snow2000r
# SB diamo una nuova ramp palette
cldiff <- colorRampPalette(c('blue','white','red'))(100) 
plot(difsnow, col=cldiff)
# SB facciamo una previsione multitemporale per vedere come sarà la situazione nel 2025 per la copertura nevosa
# SB scarichiamo il file prediction nella cartella snow ed importiamolo in R
predicted.snow.2025.norm <- raster("predicted.snow.2025.norm.tif")
# SB per metterlo in r avrei potuto usare la funzione source("prediction.r")
plot(predicted.snow.2025.norm, col=cl)
#########################################################################################################################
### 10 R_code_patches.R

# SB la prima operazione è il settaggio della WD
setwd("C:/lab_eco/")
# SB carichiamo la libreria raster, solitamente la libreria è la prima cosa da settare
library(rster) 
install.packages("igraph") # SB questa libreria mi permette di creare le patches
library(igraph) 
library(ggplot) # SB mi serge ggplot per il grafico finale
# SB per caricare la mappa devo utilizzare la funzione raster (se fosse stato un file a + livelli dovevo usare brik)
d1c <- raster("d1c.tif") # SB do il nome e lo assegno con la freccia
d2c <- raster("d2c.tif") # SB do il nome e lo assegno con la freccia 
# SB procediamo col fare un plot per vedere cosa ho davanti
par(mfrow=c(1,2)) # SB par serve per mettere 2 immagini di fianco o incolonnate (è un arrey (2,1))
cl <- colorRampPalette(c('green','black'))(100) # SB metto anche una nuova color ramp palette (metto in verde la foresta e nero la non foresta)
plot(d1c,col=cl)
plot(d2c,col=cl)
# SB mi accorgo che è invertito perciò inverto gli elementi dell'array
cl <- colorRampPalette(c('black','green'))(100)
plot(d1c,col=cl)
plot(d2c,col=cl)
### la foresta= classe 2 e agricoltura= classe 1

# SB estraiamo la foresta 
# SB la funzione che lo permette è cbind
# SB devo riclassificare l'immagine riassegmando dei valori (in questo caso do valore nullo ad agricoltura)
d1c.for <- reclassify(d1c, cbind(1,NA)) #dell'immagine 1 che corrisponde a d1c modifico la classe 1 (agricoltura e gli do NA not assigned)
par(mfrow=c(1,2))
cl <- colorRampPalette(c('black','green'))(100) #
plot(d1c,col=cl)
plot(d1c.for)
#rimetto la color ramp palette di prima
par(mfrow=c(1,2))
cl <- colorRampPalette(c('black','green'))(100) #
plot(d1c,col=cl)
plot(d1c.for, col=cl)
## rifacciamo tutto per il secondo periodo
d2c.for <- reclassify(d2c, cbind(1,NA))
par(mfrow=c(1,2))
cl <- colorRampPalette(c('black','green'))(100)
plot(d1c.for, col=cl)
plot(d2c.for, col=cl)
# SB creiamo le petch unendo i pixel vivini creando una singola petch
# SB la funzione che lo permette è clamp
# SB non aveva funzionato perchè non era stata installata la libreria igrapg
install.packages("igraph")
library(igraph)
d1c.for.patches <-  clump(d1c.for)
d2c.for.patches <-  clump(d2c.for)
# SB la funzione writeraster esporta il file appena creato all'interno della cartella lab_eco
writeRaster(d1c.for.patches, "d1c.for.patches.tif")
writeRaster(d2c.for.patches, "d2c.for.patches.tif")
# SB per importarle su R
# d1c.for.pacthes <- raster("d1c.for.pacthes.tif")
# d2c.for.pacthes <- raster("d2c.for.pacthes.tif")
# EX plottiamole entrambe le nuove immagini vicine 
par(mfrow=c(1,2))
cl <- colorRampPalette(c('red','green','yellow'))(100)
plot(d1c.for.patches, col=cl)
plot(d2c.for.patches, col=cl)
# SB creiamo una color ramp palette più utile al nostro fine
cl <- colorRampPalette(c('dark blue','blue','green','orange','yellow','red'))(100) # 
# SB replottiamo
cl <- colorRampPalette(c('dark blue','blue','green','orange','yellow','red'))(100) # 
plot(d1c.for.patches, col=cl)
plot(d2c.for.patches, col=cl)
# SB definiamo quantitativamente il numero delle petchs che abbiamo 
 d1c.for.patches # SB digitando questo R mi mostra le caratteristiche (values max= 301= numero patches)
# SB class      : RasterLayer 
# SB dimensions : 478, 714, 341292  (nrow, ncol, ncell)
# SB resolution : 1, 1  (x, y)
# SB extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
# SB crs        : NA 
# SB source     : memory
# SB names      : clumps 
# SB values     : 1, 301  (min, max)
#faccio lo stesso per la 2
d2c.for.patches
#  SB max petches1 =301
#  SB max petches 2 = 1212
# SB facciamo un plot con ggplot
time <- c("Before deforestation","After deforestation") #per evitare che mi mostri le colonne prima after poi before dovrei dargli nomi diversi perchè va in ordine alfabetico
npatches <- c(301,1212)
output <- data.frame(time,npatches)
attach(output)
library(ggplot2)
ggplot(output, aes(x=time, y=npatches, color="red")) + geom_bar(stat="identity", fill="white")
###############################################################################################################################
################## 11. R-code_crop.r
 setwd("C:/lab_eco/snow/") # SB ricorda di aggiungere anche la sottocartella
# SB caricare i dati da copernicus e raggrupparli nella sottocartella 
librart(ncdf) # SB questa libreria mi permette di usare il dato.nc così come lo scarico 
rlist=list.files(pattern="snow20", full.names=T) # SB l'elemento in comune tra i file che che vorrei importare è snow20
list_rast=lapply(rlist, raster)
snow.multitemp <- stack(list_rast)
plot(snow.multitemp)
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # 
plot(snow.multitemp,col=clb)
# SB usiamo per la prima volta la funzione zoom, dobbiamo cambiare extension (le coordinate)
snow.multitemp # SB vedo i names delle immagini che voglio plottare singolarmante
plot(snow.multitemp$snow2010r, col=clb) # SB così con il $ lego la mia immagine al dataset che voglio plottare
# SB con la funzione ext seleziono le coordinate x e y che voglio vedere
extension <- c(6, 18, 40, 50)
zoom(snow.multitemp$snow2010r, ext=extension)
extension <- c(6, 20, 35, 50)
zoom(snow.multitemp$snow2010r, ext=extension) # SB correggiamo con le giuste coordinate
# SB posso usare anche il drawExtent
 plot(snow.multitemp$snow2010r, col=clb)
zoom(snow.multitemp$snow2010r, ext=drawExtent()) # SB fare clic e tenere premuto sulla diagonale poi ricliccare
# SB la funzione crop taglia l'immagine su quella zona 
extension <- c(6, 20, 35, 50)
snow2010r.italy <- crop(snow.multitemp$snow2010r, extension) # SB uso crop e gli assoccio un nome 
plot(snow2010r.italy, col=clb)
# SB facciamo crop dell'intero stak
extension <- c(6, 20, 35, 50)
snow.multitemp.italy<- crop(snow.multitemp, extension) # SB basta che non specifico col $ l'immagine a cui devo collegarmi avendo già creato una lista (snow.multitemp)
plot(snow.multitemp.italy, col=clb)
# SB osservo che i range nelle legende sono differenti per rendere comparabili le immagini
snow.multitemp.italy # SB cos' vedo tutti i range 
#class      : RasterBrick 
#dimensions : 150, 140, 21000, 5  (nrow, ncol, ncell, nlayers)
#resolution : 0.1, 0.1  (x, y)
#extent     : 6, 20, 35, 50  (xmin, xmax, ymin, ymax)
#crs        : +proj=longlat +ellps=WGS84 +no_defs 
#source     : memory
#names      : snow2000r, snow2005r, snow2010r, snow2015r, snow2020r 
#min values :        20,        20,        20,        20,        20 
#max values :  195.3692,  194.5759,  136.6333,  130.0056,  130.5333 
plot(snow.multitemp.italy, col=clb, zlim=c(20,200)) # SB unifichiamo il limite di solito si mette 255 perchè sistema 8bit 2^8=256
# SB facciamo un box plot
boxplot(snow.multitemp.italy, horizontal=T,outline=F) # SB outline significano i valori fuori trend in questo caso le metto false=F

 ## SB se voglio usare prediction devo stare attena alla normalizzazione (moltiplico per il max e divido per il min)
 
###############################################################################################################
#########################################################
12. spieces_diatribution_modeling
install.packages("sdm") # SB il pacchetto che serve per queste modellazioni è questo
library(sdm)
library(raster)
library(rgdal)
file <- system.file("external/species.shp", package="sdm") # SB gli shape file vengono letti da rgdal
species <- shapefile(file) 
species # SB vediamo le caratteristiche, nell'utm l'Italia è nei fusi 32-33 
#class       : SpatialPointsDataFrame 
#features    : 200 
#extent      : 110112, 606053, 4013700, 4275600  (xmin, xmax, ymin, ymax)
#crs         : +proj=utm +zone=30 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#variables   : 1
#names       : Occurrence   # SB la variabile occurrence mi mostra se la specie è presente o assente 
#min values  :          0 
#max values  :          1 
species$Occurrence # SB così lego la variabile al dataset e vedo quello che ho ovvero serie di 0 e 1
plot(species) # SB vedo il plot che ottengo (è una nuvola di punti)
# SB visualizziamo in modo diverso le presenze dalle assenze 
plot(species[species$Occurrence == 1,],col='blue',pch=16) # SB dico di plottare in blu i punti dove la specie è ugulae a 1
points(species[species$Occurrence == 0,],col='red',pch=16) # SB aggiungiamo i punti dove la specie è assente (0)
# SB cerchiamo di montare le variabili ambientali per comporre il modello
path <- system.file("external", package="sdm") # SB importiamo la cartella all'interno del percorso
lst <- list.files(path=path,pattern='asc$',full.names = T) # SB facciamo una lista di files con il pattern .asc (è un formato)
lst # SB vediamo cosa contiene 
#[1] "C:/Users/utente/Documents/R/win-library/3.6/sdm/external/elevation.asc"    
#[2] "C:/Users/utente/Documents/R/win-library/3.6/sdm/external/precipitation.asc"
#[3] "C:/Users/utente/Documents/R/win-library/3.6/sdm/external/temperature.asc"  
#[4] "C:/Users/utente/Documents/R/win-library/3.6/sdm/external/vegetation.asc"   
preds <- stack(lst) # SB facciamo uno stak con questi livelli tutti insieme delle variabili predittrici
cl <- colorRampPalette(c('pink','purple','cyan')) (100)
plot(preds, col=cl) # SB così vediamo come le specie si distribuiscono rispetto alle pariabili
plot(preds$elevation, col=cl) # SB facciamolo solo per elevation
points(species[species$Occurrence == 1,], pch=16) # SB vediamo dove la specie era presente
plot(preds$temperature, col=cl) # SB temperatura
points(species[species$Occurrence == 1,], pch=16)
plot(preds$vegetation, col=cl) # SB vegetation
points(species[species$Occurrence == 1,], pch=16)
# SB facciamo un modellino lineare che contiente tutte queste variabili
d <- sdmData(train=species, predictors=preds)
# SB train significa il dato delle specie per noi è infatti il dataset spieces
# SB predictors sono le 4 variabili che abbiamo
d
#class                                 : sdmdata 
#=========================================================== 
#number of species                     :  1 
#species names                         :  Occurrence 
#number of features                    :  4 
#feature names                         :  elevation, precipitation, temperature, ... 
#type                                  :  Presence-Absence 
#has independet test data?             :  FALSE 
#number of records                     :  200 
#has Coordinates?                      :  TRUE 
# SB la funzione sdm mi permette di fare la modellazione
# SB la tilde corrispone all'uguale nei modelli
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=d, methods='glm')
# SB facciamo una previsione 
p1 <- predict(m1, newdata=preds)
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)


