##### R spatial
# SB libreria sp già installata in precedenza e andare sui dati che ci interessano
library(sp)
data(meuse)
# SB coordinate del dataframe 
coordinates(meuse)=~x+y
# SB sppplot dei dati con lo zinco (questa funzione è dentro sp)
spplot(meuse, "zinc")
## ex: fare una tabella con ssplot con il rame
head(meuse)
# SB potrei vedere il nome copper invece che con la funzione head con la funzione names(meuse)
names(meuse)
spplot(meuse, "copper")
# SB utilizzo della funzione bubble, è un modo per plottare dati diverso
bubble(meuse, "zinc")
## EX utilizzare il bubble sul rame  ma fare i pallini di colore rosso
bubble(meuse, "copper", col="red")
## EX 
# foraminiferi (io), carbon capture (marco)
# faccio un array (ho creato due oggetti)
foram <- c(10,20,35,55,67,80)
carbon<- c(5,15,30,70, 85, 99)
plot(foram, carbon, col="green", cex=2, pch=9)

# importare dati esterni sul covid-19
# cartella da creare C:/lab_eco
setwd("C:/lab_eco")
read.table("covid_agg.csv")
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
 










