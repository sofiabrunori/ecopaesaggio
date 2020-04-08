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
