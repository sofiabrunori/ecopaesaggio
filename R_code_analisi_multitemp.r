
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















