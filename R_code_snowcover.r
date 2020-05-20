setwd("C:/lab_eco/") 
#installare la libreria che apre file .nc
install.packages("ncdf4")
library(ncdf4)
library(rgdal)
library(raster)
#importare i dati da lab_eco
snowmay <- raster("c_gls_SCE500_202005180000_CEURO_MODIS_V1.0.1.nc") #gli associo il nome snowmay
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) #gli dico che colori voglio
plot(snowmay,col=cl) #lo plotto
# es con immagini di altri anni
#setto la nuova WD per la cartella dove ho messo le immagini .tif
setwd("C:/lab_eco/snow")
#ora tramite la funzione lapply importo tutto
rlist=list.files(pattern=".tif", full.names=T)
list_rast <- lapply(rlist, raster)
snow.multitemp <- stack(list_rast)
plot(snow.multitemp,col=cl)
#facciamo dei confronti 2000 vs 2020
par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl)
plot(snow.multitemp$snow2020r, col=cl)
par(mfrow=c(2,1))
#unifichiamo il limite tra le due immagini 

plot(snow.multitemp$snow2000r, col=cl, zlim=c(0,250))
plot(snow.multitemp$snow2020r, col=cl, zlim=c(0,250))

#calcoliamoci la differenza
difsnow = snow.multitemp$snow2020r - snow.multitemp$snow2000r
 #diamo una nuova ramp palette
cldiff <- colorRampPalette(c('blue','white','red'))(100) 
plot(difsnow, col=cldiff)
#facciamo una previsione multitemporale per vedere come saremo nel 2025 con la copertura nevosa
#scarichiamo il file prediction nella cartella snow
# per metterlo in r posso usare la funzione source
    predicted.snow.2025.norm <- raster("predicted.snow.2025.norm.tif")
    plot(predicted.snow.2025.norm, col=cl)
 

