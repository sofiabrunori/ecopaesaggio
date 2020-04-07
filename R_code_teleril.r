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
