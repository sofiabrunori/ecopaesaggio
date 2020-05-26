#la prima operazione è il settaggio della WD
setwd("C:/lab_eco/")

#carichiamo la libreria raster, solitamente la libreria è la prima cosa da settare
library(rster) 

#per caricare la mappa devo utilizzare la funzione raster (se fosse stato un file a + livelli dovevo usare brik)
d1c <- raster("d1c.tif") #do il nome e lo assegno con la freccia
d2c <- raster("d2c.tif") #do il nome e lo assegno con la freccia 

#procediamo col fare un plot per vedere cosa ho davanti
par(mfrow=c(1,2)) #par serve per mettere 2 immagini di fianco o incolonnate (è un arrey (2,1))
cl <- colorRampPalette(c('green','black'))(100) # metto anche una nuova color ramp palette (metto in verde la foresta e nero la non foresta)
plot(d1c,col=cl)
plot(d2c,col=cl)
#mi accorgo che è invertito perciò inverto la cl
cl <- colorRampPalette(c('black','green'))(100)
plot(d1c,col=cl)
plot(d2c,col=cl)
### la foresta è la classe 1 e agricoltura è la classe 1

#estraiamo la foresta 
#la funzione che lo permette è cbind
# devo riclassificare l'immagine riassegmando dei valori (in questo caso do valore nullo ad agricoltura)
d1c.for <- reclassify(d1c, cbind(1,NA)) #dell'immagine 1 che corrisponde a d1c modifico la classe 1 (agricoltura e gli do NA not assigned)
par(mfrow=c(1,2))
cl <- colorRampPalette(c('black','green'))(100) #
plot(d1c,col=cl)
plot(d1c.for)
#rimetto la colo ramp di prima
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
## creiamo le petch unendo i pixel vivini creando una singola petch
#la funzione che lo permette è clamp
d1c.for.patches <-  clump(d1c.for)
d2c.for.patches <-  clump(d2c.for)
# la funzione writeraster esporta il file appena creato all'interno della cartella lab_eco
writeRaster(d1c.for.patches, "d1c.for.patches.tif")
writeRaster(d2c.for.patches, "d2c.for.patches.tif")
#per importarle su R
# d1c.for.pacthes <- raster("d1c.for.pacthes.tif")
# d2c.for.pacthes <- raster("d2c.for.pacthes.tif")
#plottiamole entrambe le nuove immagini vicine 
par(mfrow=c(1,2))
cl <- colorRampPalette(c('red','green','yellow'))(100)
plot(d1c.for.patches, col=cl)
plot(d2c.for.patches, col=cl)
# creiamo una color ramp palette più utile al nostro fine
cl <- colorRampPalette(c('dark blue','blue','green','orange','yellow','red'))(100) # 
# replottiamo
cl <- colorRampPalette(c('dark blue','blue','green','orange','yellow','red'))(100) # 
plot(d1c.for.patches, col=cl)
plot(d2c.for.patches, col=cl)
#definiamo quantitativamente il numero delle petchs che abbiamo 
 d1c.for.patches
# class      : RasterLayer 
#  dimensions : 478, 714, 341292  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : memory
#names      : clumps 
#values     : 1, 301  (min, max)
#faccio lo stesso per la 2
d2c.for.patches
# max petches1 =301
# max petches 2 = 1212
# facciamo un plot con ggplot
time <- c("Before deforestation","After deforestation")
npatches <- c(301,1212)
output <- data.frame(time,npatches)
attach(output)
library(ggplot2)
ggplot(output, aes(x=time, y=npatches, color="red")) + geom_bar(stat="identity", fill="white")
 



 
















