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
















