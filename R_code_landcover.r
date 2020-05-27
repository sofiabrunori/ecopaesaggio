##### codice R per fare analisi di tipo "land cover"
# devo settare la WD
setwd("C:/lab_eco")
library(raster) # SB richiamiamo la libreria raster che ci serve
install.packages("RStoolbox") # SB installiamo la libreria RStoolbox che mi permette di fare analisi di questo tipo
library(RStoolbox) # SB la richiamo 
# SB importiamo i dati che sono stati scaricati
p224r63_2011 <- brick("p224r63_2011_masked.grd") # SB la funzione che lo permette e brick, l'argomento va tra virgolette perchè vado ad
#importare elementi "fuori fa r"
# le bande sono : 1=b, 2=g, 3=r, 4= nir
# SB facciamo un plot dove sistemo le bande giuste 
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
# SB ora faccio una suddivisione in 4 classi 
p224r63_2011c <- unsuperClass(p224r63_2011, nClasses=4)

p224r63_2011c

plot(p224r63_2011c$map)

clclass <- colorRampPalette(c('red', 'green', 'blue', 'black'))(100) 
plot(p224r63_2011c$map, col=clclass)

# in funzione del numero di classi aumenta l'incertezza dell'algoritmo automatico di classificazione
# riportando potenzialmente classi leggermente differenti

p224r63_2011c <- unsuperClass(p224r63_2011, nClasses=4)
plot(p224r63_2011c$map)

p224r63_2011c <- unsuperClass(p224r63_2011, nClasses=2)
plot(p224r63_2011c$map)
