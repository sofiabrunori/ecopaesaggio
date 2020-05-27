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
 

