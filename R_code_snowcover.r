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
