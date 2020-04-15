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













