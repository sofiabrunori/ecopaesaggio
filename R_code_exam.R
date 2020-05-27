# R code exam
1. R_code_first.r   
2. R_code_spatial.r   
3. R_code_spatial2.r
4. R_code_point_pattern   
5. R_code_teleril.r   
6. R_code_landcover.r   
7. R_code_multitemp.r   
8. R_code_multitemp_NO2.r   
8. R_code_snow.r   
9. R_code_patches.r  
###  1 R_code_first.R

### 2  R_code_spatial.r
# R spatial: codice per fare analisi spaziali (24/03/20)
#il comando install.packages permette di installare il pacchetto R che comprende le funzioni che mi servono
install.packages("sp")

# con Library sto richiamando un paccetto
library(sp)

# dati
data(meuse)

# per visualizzare solo i primi dati
head(meuse)

# plottare cadmium e led
# allegare anche il dataframe, il comando attach permette di richiamare direttamente un elemento del dataframe
attach(meuse)
plot(cadmium, lead) #il comando plot invece porta alla visualizzazione grafice che volevo

# se voglio cambiare colore col=x, per cambiare carattere pch=num, cambiare dimens cex=num
plot (cadmium, lead, col="red", pch=19, cex=2)

# ex: plottare copper e zinco con simbolo triangolo (17) e colore verde
plot (copper, zinc, col = "green", pch=17)

# cambiare le etichette, metto tra virgolette perchè è un testo
plot (copper, zinc, col = "green", pch=17, xlab="rame", ylab="zinco")

# fare mulfiframe o multipanel in questo caso una riga e due colonne, in parica ho unito nella stessa fig. i 2 grafici di prima
par(mfrow=c(1,2)) # mfrow è vettore di forma c(nr, nc). I grafici saranno disegnati in una tavola di nr righe e nc colonne.
plot (cadmium, lead, col="red", pch=19, cex=2)
plot (copper, zinc, col = "green", pch=17, cex=2)

# inversione da riga colonna a colonna riga
par(mfrow=c(2,1))
plot (cadmium, lead, col="red", pch=19, cex=2)
plot (copper, zinc, col = "green", pch=17, cex=2)

#multiframe automatico 
install.packages ("GGally")
#attenzione R è cage sensitive ovvero sensibile alle maiuscole
library(GGally)
# la quadra serve per fare una sottoclasse cioè dai dati meuse tengo solo dalla colonna 3 alla 6
ggpairs(meuse[,3:6])
# su R per vedere come operano le funzioni basta scrivere la funzone 
ggpairs

#spatial analisi
head(meuse)

# con la funzione coordinates dico al software come si chiamano
coordinates(meuse) =~ x+y
plot(meuse)

#funzione spplot la uso per ottenere un grafico spaziale
spplot(meuse,"zinc")


### 3 R_code_spatial2.r

# libreria sp già installata in precedenza e andare sui dati che ci interessano
library(sp)
data(meuse)

# coordinate del dataframe 
coordinates(meuse)=~x+y

#sppplot dei tati con lo zinco (questa funzione è dentro sp)
spplot(meuse, "zinc")

## ex: fare una tab con ssplot con il rame
head(meuse)
# potrei vedere il nome copper invece che con la funzione head con la funzione names(meuse)
names(meuse)
spplot(meuse, "copper")

#utilizzo della funzione bubble, è un modo per plottare dati diverso
bubble(meuse, "zinc")
## utilizzare il bubble sul rame  ma fare i pallini di colore rosso
bubble(meuse, "copper", col="red")

# foraminiferi (io), carbon capture (marco)
# faccio un array (ho vreato due oggetti)
foram <- c(10,20,35,55,67,80)
carbon<- c(5,15,30,70, 85, 99)
plot(foram, carbon, col="green", cex=2, pch=9)

# importare dati esterni sul covid-19
# cartella da creare C:/lab_eco

setwd("C:/lab_eco")

read.table("covid_agg.csv")

#devo informare che la prima riga è composta dai titoli non da dati e devo assegnare il titolo
covid <-read.table("covid_agg.csv", head=TRUE)
head(covid)


### 4 R_code_pointpatterns.r
#### codice per analisi dei patterns legati ai punti

setwd("C:/lab_eco")
#attribuire il nome al dataset che mi serve 
covid <- read.table("covid_agg.csv", head=T)
 # per visualizzare i primi dati 
 head(covid)
 # facciamo un primo plot
 plot(covid$country, covid$cases) #il dollaro collega la colonna al proprio dataset, potrei sostituirlo con attach(covid)
 # dobbiamo cambiare le lables perchè ho troppi dati sulla x e non vedo i nomi
 plot(covid$country, covid$cases, las=0) #lass=0 è il default non cambia nulla è parallelo agli assi
 plot(covid$country, covid$cases, las=1) #è orizzontale
 plot(covid$country, covid$cases, las=2)#perpendicolari agli assi
 plot(covid$country, covid$cases, las=3) #tutte verticali
 plot(covid$country,covid$cases,las=3)
 #si vede ancora male perchè ho troppi dati quindi mi conviene usare la funzione che diminuisce i caratteri
  plot(covid$country,covid$cases,las=3, cex.axis=0.5)
 # plottiamo tramite ggplot2 , servono: il dataset , l'estetica e la geometria della mappatura)
 #per prima cosa lo devo installare 
 install.packages ("ggplot2")
 library(ggplot2)
 data(mpg)
 head(mpg)
 # ho caricato questi dati facciamo un plot d'esempio
 # mi serve dare
 #data
 #aest, sono in pratica le variabili che vedo esteticamente
 #tipo, è la geometria e si aggiunge con un più
 ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()
 ggplot(mpg, aes(x=displ, y=hwy)) + geom_line() #geom line fa grafico con linee
 ggplot(mpg, aes(x=displ, y=hwy)) + geom_polygon() #posso farlo anche a poligoni anche se non ha senso in questo caso
 # applichiamo ggplot ai dati relativi al covid per vedere i nomi delle variabili basta fare names(covid)
 ggplot(covid, aes(x=lon, y=lat, size=cases)) + geom_point()
 # es. calcolare la densità quindi vedere dove è la maggior parte della densità
 # density , in pratica lo devo rasterizzare
 #prima installo il pacchetto che lo permette
 install.packages("spatstat")
 library(spatstat)
 #devo creare il dataset per spatstat
 attach(covid)
 covids <- ppp(lon, lat, c(-180,180), c(-90,90))
 d<-density(covids)
 plot(d)
 # plottare anche i punti con la funzione
 points(covids, pch=19)
 #aggiungiamo anche i bordi di dove si collocano i paesi come range di lat e lon
 #c'è un database internazionale che li ha già inseriri
 ## recupero i dati di ieri che si trovano nella cartella lab_eco
setwd("C:/lab_eco")
load("pointpattern.RData")
# per vedere i dati presenti salvati nelle varie sessioni si lavoro su r
ls()
#dobbiamo ridire quale libreria useremo
library(spatstat)
#plottiamo di nuovo la mappa di ieri
plot(d)
#cambiamo i colori della mappa in modo arbitrario con la funzione palette 
# associo una sigla alla mia palette e inserisco l'array dei colori
cl<- colorRampPalette(c('yellow', 'orange', 'red'))
# posso anche inserire quante gradazioni usare per rendere + precisa la mappa
cl<- colorRampPalette(c('yellow', 'orange', 'red')) (100)
plot(d, col=cl)
#### esercizio : plot mappa della densità dal verde al blu
cl<- colorRampPalette(c('green', 'violet', 'blue')) (200)
plot(d, col=cl)
#aggiungiamo ora i punti che avevamo ieri
points(covids)
#ora aggiungiamo anche i confini degli stati con le coordinate, questo dato è esterno
coastlines<-readOGR("ne_10m_coastline.shp")
# mi da un errore perchè ho messo red OGR(legge file vettoriali) senza aver prima installato la librereria giusta quindi bisogna installarla
install.packages("rgdal")
library(rgdal)
#ora posso richiamare il comando che prima non aveva funzionato e plottarlo
coastlines<-readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)

## esercizio: plot della mappa di densità con nuovi colori e aggiunta delle coast lines 
cl<- colorRampPalette(c('green', 'violet', 'blue')) (200)
plot(d, col=cl)
coastlines<-readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)


### 5 R_code_teleril.r
#### codice in R per fare analisi di immagini satellitari
# dobbiamo installare i pachetti utili al fine "raster" (già fatto) quindi devo solo richiamarlo con library
library(raster)
# richiamare la cartella 
setwd("C:/lab_eco/")
# associamo il nome al file con la freccia a sin e la funzione brick come sempre
#così abbiamo importato un immagine sattellitare all'interno di R
p224r63 <- brick("p224r63_2011_masked.grd")
#inseriamo anche l'anno che è meglio
p224r63_2011 <- brick("p224r63_2011_masked.grd")
# cerchiamo di ricavare le info di base plottando 
plot(p224r63_2011)
## ricarichiamo l'R data che abbiamo salvato ieri che contiene le stringhe sopra
#(posso clioccarci sopra oppure: 
 setwd("C:/lab_eco/") #settare la working d.
load("teleril.RData") #carico l'R data
ls() #con questa controllo che cosa contiene il mio file 
library(raster) #ricarichiamo la libreria che visualizza i file raster
plot(p224r63_2011) #plottiamo l'immagine di ieri 
## di seguito si vedono le sigle a quali bande corrispondono secondo la legenda standard di R
# B1: blue 
# B2: green
# B3: red
# B4: near infrared (nir)
# B5: medium infrared
# B6: thermal infrared
# B7: medium infrared
# ora cambiamo la scala di colori perchè cosi non è efficace con la funzione :
cl <- colorRampPalette(c('black','grey','light grey'))(100) #così assegno l'array che rappresenta i colori che voglio a cl
plot(p224r63_2011, col=cl) #riplotto tutto
cllow <- colorRampPalette(c('black','grey','light grey'))(5) #proviamo a diminuire la risoluzione
plot(p224r63_2011, col=cllow)
# ora plottiamo la banda del blu con una scala di colori sul blu
names(p224r63_2011) #ora posso vedere i nomi 
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) #
 plot(p224r63_2011$B1_sre, col=clb) # siccome non posso usare attach con raster uso il $ che collega una variabile al suo dataset
## es: plotta la banda dell'infrarosso vico con la color ramp da rosso a giallo 
 clnir <- colorRampPalette(c('red','orange','yellow'))(100) #
 plot(p224r63_2011$B4_sre, col=clnir)
## cerchiamo di fare un multi frame con plottate 4 bande diverse
par(mfrow=c(2,2)) #imposto le righe: voglio 2 righe e 2 colonne 
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) #
 plot(p224r63_2011$B1_sre, col=clb) #la blu è stata plottat
clg <- colorRampPalette(c('dark green','green','light green'))(100) #verde
 plot(p224r63_2011$B2_sre, col=clg)
clr <- colorRampPalette(c('dark red','red','pink'))(100)#rosso
 plot(p224r63_2011$B3_sre, col=clr) 
clnir <- colorRampPalette(c('red','orange','yellow'))(100) #vicino infrarosso nir
 plot(p224r63_2011$B4_sre, col=clnir)
# dev.off è un comando che permette di chiudere la finestra dove compaiono le immagini
dev.off()
## netural colours: plottare le immagini come l evedrebbe un occhio umano (RGB) devo in bratica montare le bande sulle 3 componenti del pc cioè RGB
# R= banda del rosso =B3
#G = banda del verde = B2
# B= banda del blu = B1
# B4= near infrared
plotRGB(p224r63_2011, r=3, g=2, b=1)
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #uso stretch (lineare) per aumentare la rislouzione dell'immagine visto che è tutta nera
#false colours
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")# abbiamo messo una componente che l'occhio umano non può vedere
#in questo modo le piante che riflettono l'infrarosso si vedono di più (si vede la foresta che a occho nudo non avremmo distinto)
#per salvare un grafico in pdf
pdf("primografico.pdf")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
dev.off()
#ora facciamo un grafico che metta in confronto tutto
par(mfrow =c(1,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
#es: mettere nir nella componente green
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
#es: mettere nir nella blu
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
## Oggi (15-04) dobbiamo caricare la libraria raste (sew non è già stata installata devo farlo con install.packages
library(raster)
# ora devo settare la working directory
setwd("C:/lab_eco/")
# devo caricare anche l'R.Data che abbiamo salvato la volta scorsa
load("teleril2.RData")
# guardiamo i dati che abbiamo salvato nelle volte precedenti con la funzione
ls()
# per importare un immagine satellitare (servono quelle dell 88) occorre usare il comando brick
p224r63_1988 <- brick ("p224r63_1988_masked.grd") # gli ho ridato il nome che volevo con la freccina 
# facciamo un primo plot
plot(p224r63_1988)
#la volta scorsa avevamo modificato la color ramp palette per visualizzare meglio 
par(mfrow=c(2,2)) #imposto le righe: voglio 2 righe e 2 colonne 
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) #
 plot(p224r63_1988$B1_sre, col=clb) #la blu è stata plottata copiando il comando già fatto prima ma ricordandoci di cambiare il nome dell'immagine 1988
clg <- colorRampPalette(c('dark green','green','light green'))(100) #verde
 plot(p224r63_1988$B2_sre, col=clg)
clr <- colorRampPalette(c('dark red','red','pink'))(100)#rosso
 plot(p224r63_1988$B3_sre, col=clr) 
clnir <- colorRampPalette(c('red','orange','yellow'))(100) #vicino infrarosso nir
 plot(p224r63_1988$B4_sre, col=clnir)
dev.off() # cancello i plot 
#ora cerchiamo di fare il plot in sistema RGB mettendo in ognuna delle componenti la banda corrispondente 
# R= banda del rosso =3
#G = banda del verde = 2
# B= banda del blu = 1
# B4= nir infrared =4
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
## es: plottare la stessa immagine con al posto della componente red la infrarossi 
plotRGB(p224r63_1988, r=4, g=2, b=1, stretch="Lin")
# ora plottiamo la 1988 e la 2011 per fare un confronto
par(mfrow=c(2,1)) # faccio un multipanel per vedere le immagini affiancate ho fatto due righe 
plotRGB(p224r63_1988, r=4, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=2, b=1, stretch="Lin")
# ora calcoliamo l indice DVI sottraendo la banda del red alla banda dell'infrarosso per ogni pixel
# div1988= nir1988-r1988
dvi1988<-p224r63_1988 $ B4_sre -  p224r63_1988 $ B3_sre #il dollaro collega le parti, (il b3 e b4 sono le bande)
plot(dvi1988)
## plot anche del 211
dvi2011<- p224r63_2011 $ B4_sre -  p224r63_2011 $ B3_sre
plot(dvi2011)
difdvi <- dvi2011-dvi1988
cldvi <- colorRampPalette(c('light blue','light green','green'))(100) # # cambio colore
plot(dvi2011, col=cldvi)
# faccio la differenza cioè un ANALISI MULTITEMPORALE tra i due anni
difdvi <- dvi2011-dvi1988
plot(difdvi)
# cambiamo la legenda 
cldifdvi<- p224r63_2011 colorRampPalette(c('red','white','blue'))(100) # 
plot(difdvi, col=cldifdvi)
#visualizziamo l'immagine rgb del 1988 , quella del 2011 e la differenza del dvi 
par(mfrow=c(3,1)) #faccio multiframe con 3 righe 
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plot(difdvi, col=cldifdvi)
#ora cerchiamo di modificare la risoluzione o anche detta grana inferiore sull'imagine del 2011
p224r63_2011lr <- aggregate( p224r63_2011, fact=10) #il pixel è aumentato di un fattore 10 (il pc fa una media dei pixel interni alla nuova maglia)
# per vedere le caratteristiche dell' immagine pasta crivere il nome in r
p224r63_2011
#ora facciamo un multipanel con le due immagini a risoluzione diversa 
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr, r=4, g=3, b=2, stretch="Lin")
# proviamo con una risoluzione ancora diversa 
p224r63_2011lr50 <- aggregate( p224r63_2011, fact=50)
p224r63_2011lr50 #si osserva che il fattore è 50 quindi 1500m 
par(mfrow=c(3,1)) #faccio di nuovo un multipanel con le 3 risoluzioni diverse 
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr50, r=4, g=3, b=2, stretch="Lin")
# possiamo creare il DBI con le immagini a risoluzione bassa di fattore 50 
p224r63_2011lr50 <- p224r63_2011lr50$B4_sre - p224r63_2011lr50$B3_sre
 plot( p224r63_2011lr50)
# facciamo lo stesso anche per il 1988
p224r63_1988lr50 <- aggregate(p224r63_1988, fact=50)
dvi1988lr50 <- p224r63_1988lr50$B4_sre - p224r63_1988lr50$B3_sre
# ora facciamo la differenza tra i due anni con risoluzione 50 
dvi2011lr50 <- p224r63_2011lr50$B4_sre - p224r63_2011lr50$B3_sre
 dvi1988lr50 <- p224r63_1988lr50$B4_sre - p224r63_1988lr50$B3_sre
 difdvilr50 <- dvi2011lr50 - dvi1988lr50
plot(difdvilr50,col=cldifdvi)
par(mfrow=c(2,1))
plot(difdvi, col=cldifdvi)
plot(difdvilr50, col=cldifdvi)



############################################################################################################################
###à 6 R_code_analisimultitemp.r
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
# SB salviamo il dataset in R
#### SB  continuo analisi multitemporale
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
#### 7 R_code_multitempNO2.r
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
# [6] "EN_0006.png" "EN_0007.png" "EN_0008.png" "EN_0009.png" "EN_0010.png"
#[11] "EN_0011.png" "EN_0012.png" "EN_0013.png"
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
#### 8 R_code_snowcover.r

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
### 9 R_code_patches.R

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






