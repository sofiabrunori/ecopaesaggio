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
 



 
















