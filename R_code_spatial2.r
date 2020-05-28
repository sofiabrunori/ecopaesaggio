##### R spatial
# SB libreria sp già installata in precedenza e andare sui dati che ci interessano
library(sp)
data(meuse)
# SB coordinate del dataframe 
coordinates(meuse)=~x+y
# SB sppplot dei dati con lo zinco (questa funzione è dentro sp per questo ho richiamato la libreria)
spplot(meuse, "zinc")
## ex: fare una tabella con ssplot con il rame
head(meuse) # SB con head vedo le prime 6 righe del dataset :
#         coordinates cadmium copper lead zinc  elev       dist   om ffreq soil
 #1 (181072, 333611)    11.7     85  299 1022 7.909 0.00135803 13.6     1    1
# 2 (181025, 333558)     8.6     81  277 1141 6.983 0.01222430 14.0     1    1
# 3 (181165, 333537)     6.5     68  199  640 7.800 0.10302900 13.0     1    1
# 4 (181298, 333484)     2.6     81  116  257 7.655 0.19009400  8.0     1    2
# 5 (181307, 333330)     2.8     48  117  269 7.480 0.27709000  8.7     1    2
# 6 (181390, 333260)     3.0     61  137  281 7.791 0.36406700  7.8     1    2
# SB potrei vedere il nome copper invece che con la funzione head con la funzione names(meuse)
names(meuse)
spplot(meuse, "copper")
# SB utilizzo della funzione bubble, è un modo per plottare dati diverso
bubble(meuse, "zinc")
## EX utilizzare la funzione bubble sul rame ma fare i pallini di colore rosso
bubble(meuse, "copper", col="red")
## EX osservare un'eventuale correlazione tra le due variabili tramite il plottaggio
# foraminiferi (io), carbon capture (marco)
# faccio un array (ho creato due oggetti)
foram <- c(10,20,35,55,67,80) # SB associo con la freccia a sin il nome della variabile all'ogetto
carbon<- c(5,15,30,70, 85, 99)
plot(foram, carbon, col="green", cex=2, pch=9) 

# SB importare dati esterni sul covid-19
# SB cartella da creare in C:/lab_eco
setwd("C:/lab_eco") # SB settare la workingdirectory
read.table("covid_agg.csv")  # SB questa funzione mi restituisce a video la tabela di dati che ho importato
# SB devo informare che la prima riga è composta dai titoli non da dati e devo assegnare il titolo
covid <-read.table("covid_agg.csv", head=TRUE) 
head(covid)
# quello che mi restituisce R è
#  cat     country cases       lat        lon
#1   1 Afghanistan    21  33.83890  66.026530
#2   2     Albania    51  41.14596  20.069178
#3   3     Algeria    49  28.16336   2.632366
#4   4     Andorra    14  42.54858   1.575688
#5   5     Antigua     1  17.28014 -61.791128
#6   6   Argentina    56 -35.37667 -65.167485
 










