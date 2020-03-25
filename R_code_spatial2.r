##### R spatial
# libreria sp già installata in precedenza e andare sui dati che ci interessano
library(sp)
data(meuse)

# coordinate del dataframe 
coordinates(meuse)=~x+y

#sppplot dei tati con lo zinco (questa funzione è dentro sp)
spplot(meuse, "zinc")

## ex: fare una tab con ssplot con il rame
head(meuse)
# potrei vedere il nome copper invece che con la funzione head con la funzione names(meuse)
names(meuse)
spplot(meuse, "copper")

#utilizzo della funzione bubble, è un modo per plottare dati diverso
bubble(meuse, "zinc")
## utilizzare il bubble sul rame  ma fare i pallini di colore rosso
bubble(meuse, "copper", col="red")

# foraminiferi (io), carbon capture (marco)
# faccio un array (ho vreato due oggetti)
foram <- c(10,20,35,55,67,80)
carbon<- c(5,15,30,70, 85, 99)
plot(foram, carbon, col="green", cex=2, pch=9)

# importare dati esterni sul covid-19
# cartella da creare C:/lab_eco

setwd("C:/lab_eco")

read.table("covid_agg.csv")

#devo informare che la prima riga è composta dai titoli non da dati e devo assegnare il titolo
covid <-read.table("covid_agg.csv", head=TRUE)
head(covid)
