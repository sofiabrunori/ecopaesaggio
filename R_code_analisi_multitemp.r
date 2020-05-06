#analisi multitemporale 29/04
#settiamo la working directory
setwd("C:/lab_eco/")
#procediamo a caricare i dati
#richiamiamo la libreria utile ovvero raster
library(raster)
#ora con la funzione brick carico le immagini cioè il nostro dataset
defor1 <- brick("defor1_.jpg")
defor2 <- brick("defor2_.jpg")
#plottiamo i dataset utilizzando le bande comprese al loro interno
defor1 #così vedo le caratteristiche (names : defor1_.1, defor1_.2, defor1_.3 sono i nomi delle bande)
#defor1_.1= nir, defor1_.2=red, defor1_.3= green
# devo associale le tre bande di riferimento al colore rgb che voglio: mettiamo la nir con il red
#la funzione che lo permette e plotRGB
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
#plottiamo anche l'immagine 2 che si riferisce ad una data successiva 
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin") #osserviamo che la porzione rossa è molto inferiore perchè la foresta pluviale è stata ridotta( ho poca riflettanza nel NIR)
#plottiamo le due immagini nello stesso grafico
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")
# classifichiamo in 2 classi in modo tale da scontornare tutto quello che è foresta e non 
#la funzione che lo permette e unsuperclass (classificazione non supervisionata) in pratica raggruppa i pixrl simili 
#la funzione è in una libreria diversa la devo caricare
library(RStoolbox)
d1c <- unsuperClass(defor1, nClasses=2) # diamo il nome e decidiamo quante classi servono 
plot(d1c$map)
#facciamo dei colori migliori
cl <- colorRampPalette(c('black','green'))(100) # 
plot(d1c$map, col=cl)
#facciamo la classificazione anche del'immagine più recente chiamata defor2
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)
cl <- colorRampPalette(c('black','green'))(100)
plot(d2c$map, col=cl)
#plot di confronto con le due mappe ottenute
par(mfrow=c(2,1))
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)
#fare stima dei valori, occore misurare la frequenza delle due classi con la funzione freq
freq(d1c$map)
##       value  count ottengo questi valori tabulati
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

#dobbiamo creare una nuova colonna
cover <- c("Agriculture","Forest")
# una nuova con i valori 
before <- c( 10.04155,89.95845)
after  <- c(179515, 163211)
output <- data.frame(cover,before,after) #abbiamo creato un dataframe 
View(output) # vediamo una tabella 
#### 5/05
# apriamo la cartella di lavoro giusta e carichiamo il dataset che avevamo creato la scorsa lezione
setwd("C:/lab_eco/")
load("defor.RData")
ls()
library(raster)
par(mfrow=c(1,2)) #fare un plot coni due anni a confronto dell altra volta
cl <- colorRampPalette(c('black','green'))(100) # 
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)
#creare un output cioè un dataframe con il tipo di landcover, la percentuale prima e dopo il disposcamento
cover <- c("Agriculture","Forest")
before <- c(10.9,89.1)
after <- c(48.2,51.8)
output #vedo la tabellina che ho creato la volta scorsa
#facciamo un plot dove si vedono le percentuali a confronto con ggplot della deforestazione
library(ggplot2)
ggplot(output, aes(x=cover, y=before, color=cover)) +
geom_bar(stat="identity", fill="white")
# stessa cosa ma dopo la deforestazione 
ggplot(output, aes(x=cover, y=after, color=cover)) +
geom_bar(stat="identity", fill="white")
# facciamo un plot di entrampi insieme, instaliamo un altro paccheto perchè la funz. par non funziona con ggplot
install.packages("gridExtra")
library(gridExtra)
#la funzione che lo permette è grid.arrange e in pratica prende i vari plot e li mette nello stesso grafico
# si assegna un nome al precedente ggplot
grafico1<-ggplot(output, aes(x=cover, y=before, color=cover)) +
geom_bar(stat="identity", fill="white")
grafico2<- ggplot(output, aes(x=cover, y=after, color=cover)) +
geom_bar(stat="identity", fill="white")
grid.arrange(grafico1, grafico2, nrow=1) #se ometto nrow me li mette uno sotto l'altro

## modifiche 6/05
library(ggplot2)
cover <- c("Agriculture","Forest") #recuperiamo l'output di ieri
before <- c(10.9,89.1)
after <- c(48.2,51.8)
output <- data.frame(cover,before,after)
output
library(gridExtra)
# plottiamo i grafici che sono degli istogrammi che mostrano i cambiamenti
grafico1 <- ggplot(output, aes(x=cover, y=before, color=cover)) +
geom_bar(stat="identity", fill="white")
grafico2 <- ggplot(output, aes(x=cover, y=after, color=cover)) +
geom_bar(stat="identity", fill="white")
grid.arrange(grafico1, grafico2, nrow = 1) #il grid.arrange equivale al par
 #aggiungiamo un limite alla y=100 in modo tale che i grafici siano più confrontabili 
grafico1 <- ggplot(output, aes(x=cover, y=before, color=cover)) + 
geom_bar(stat="identity", fill="white") +
ylim(0, 100)
grafico2 <- ggplot(output, aes(x=cover, y=after, color=cover)) + 
geom_bar(stat="identity", fill="white") +
ylim(0, 100) 
grid.arrange(grafico1, grafico2, nrow = 1)















