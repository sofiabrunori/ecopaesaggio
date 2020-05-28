##### codice R per fare analisi di tipo "land cover"
# devo settare la WD
setwd("C:/lab_eco")
library(raster) # SB richiamiamo la libreria raster che ci serve
install.packages("RStoolbox") # SB installiamo la libreria RStoolbox che mi permette di fare analisi di questo tipo
library(RStoolbox) # SB la richiamo 
# SB importiamo i dati che sono stati scaricati da iol
p224r63_2011 <- brick("p224r63_2011_masked.grd") # SB la funzione che lo permette e brick, l'argomento va tra virgolette perchè vado ad
#importare elementi "fuori da r"
# le bande sono : 1=b, 2=g, 3=r, 4= nir
# SB associare le bande di riferimento al colore rgb che voglio con la funzione plotRGB
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
# SB ora faccio una suddivisione in 4 classi (nClasses=4) con la funzione unsuperclass (classificazione non supervisionata)
p224r63_2011c <- unsuperClass(p224r63_2011, nClasses=4) # SB le associo un nome 
p224r63_2011c # SB mi da le inso sul risultato della suddivisione in 4 classi:
#$map
#class      : RasterLayer 
#dimensions : 1499, 2967, 4447533  (nrow, ncol, ncell)
#resolution : 30, 30  (x, y)
#extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#source     : C:/Users/utente/AppData/Local/Temp/Rtmp0SmpLZ/raster/r_tmp_2020-05-28_154348_13572_60358.grd 
#names      : layer 
#values     : 1, 4  (min, max)
plot(p224r63_2011c$map) # SB eseguo il plot che mi restituisce la mappa con le 4 classi
clclass <- colorRampPalette(c('red', 'green', 'blue', 'black'))(100) # SB associo a clclass la ramp palette desiderata
plot(p224r63_2011c$map, col=clclass)
# SB col più diminuisco il numero delle classi col più l'errore aumenta.

