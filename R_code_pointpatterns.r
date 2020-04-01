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
