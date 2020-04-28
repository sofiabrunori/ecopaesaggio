# R spatial: codice per fare analisi spaziali (24/03/20)
#il comando install.packages permette di installare il pacchetto R che comprende le funzioni che mi servono
install.packages("sp")

# con Library sto richiamando un paccetto
library(sp)

# dati
data(meuse)

# per visualizzare solo i primi dati
head(meuse)

# plottare cadmium e led
# allegare anche il dataframe, il comando attach permette di richiamare direttamente un elemento del dataframe
attach(meuse)
plot(cadmium, lead) #il comando plot invece porta alla visualizzazione grafice che volevo

# se voglio cambiare colore col=x, per cambiare carattere pch=num, cambiare dimens cex=num
plot (cadmium, lead, col="red", pch=19, cex=2)

# ex: plottare copper e zinco con simbolo triangolo (17) e colore verde
plot (copper, zinc, col = "green", pch=17)

# cambiare le etichette, metto tra virgolette perchè è un testo
plot (copper, zinc, col = "green", pch=17, xlab="rame", ylab="zinco")

# fare mulfiframe o multipanel in questo caso una riga e due colonne, in parica ho unito nella stessa fig. i 2 grafici di prima
par(mfrow=c(1,2)) # mfrow è vettore di forma c(nr, nc). I grafici saranno disegnati in una tavola di nr righe e nc colonne.
plot (cadmium, lead, col="red", pch=19, cex=2)
plot (copper, zinc, col = "green", pch=17, cex=2)

# inversione da riga colonna a colonna riga
par(mfrow=c(2,1))
plot (cadmium, lead, col="red", pch=19, cex=2)
plot (copper, zinc, col = "green", pch=17, cex=2)

#multiframe automatico 
install.packages ("GGally")
#attenzione R è cage sensitive ovvero sensibile alle maiuscole
library(GGally)
# la quadra serve per fare una sottoclasse cioè dai dati meuse tengo solo dalla colonna 3 alla 6
ggpairs(meuse[,3:6])
# su R per vedere come operano le funzioni basta scrivere la funzone 
ggpairs

#spatial analisi
head(meuse)

# con la funzione coordinates dico al software come si chiamano
coordinates(meuse) =~ x+y
plot(meuse)

#funzione spplot la uso per ottenere un grafico spaziale
spplot(meuse,"zinc")


