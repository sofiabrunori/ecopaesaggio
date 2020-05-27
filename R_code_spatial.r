# R spatial: codice per fare analisi spaziali (24/03/20)
# SB il comando install.packages permette di installare il pacchetto R che comprende le funzioni che mi servono
install.packages("sp")
# SB con Library sto richiamando un paccetto
library(sp)
# SB prendiamo i dati
data(meuse)
# SB per visualizzare solo i primi dati
head(meuse)
# SB  plottare cadmium e led con la funzione plot
# SB allegare anche il dataframe, il comando attach permette di richiamare direttamente un elemento del dataframe
attach(meuse)
plot(cadmium, lead) # SB il comando plot invece porta alla visualizzazione grafice che volevo
# SB se voglio cambiare colore col=x, per cambiare carattere pch=num, cambiare dimens cex=num
plot (cadmium, lead, col="red", pch=19, cex=2)
# ex: plottare copper e zinco con simbolo triangolo (17) e colore verde
plot (copper, zinc, col = "green", pch=17)
# SB cambiare le etichette, metto tra virgolette perchè è un testo
plot (copper, zinc, col = "green", pch=17, xlab="rame", ylab="zinco")
# SB fare mulfiframe o multipanel in questo caso una riga e due colonne, in parica ho unito nella stessa fig. i 2 grafici di prima
par(mfrow=c(1,2)) # mfrow è vettore di forma c(nr, nc). I grafici saranno disegnati in una tavola di nr righe e nc colonne.
plot (cadmium, lead, col="red", pch=19, cex=2)
plot (copper, zinc, col = "green", pch=17, cex=2)
# SB inversione da riga colonna a colonna riga
par(mfrow=c(2,1)) #così visualizzo i due grafici uno sotto l'altro
plot (cadmium, lead, col="red", pch=19, cex=2)
plot (copper, zinc, col = "green", pch=17, cex=2)
#multiframe automatico 
install.packages ("GGally") # SB la libreria che lo permette è GGaly la devo quindi installare
# SB attenzione R è cage sensitive ovvero sensibile alle maiuscole
library(GGally) # SB richiamo la libreria
# SB la parentesi quadra serve per fare una sottoclasse cioè dai dati meuse tengo solo dalla colonna 3 alla 6
ggpairs(meuse[,3:6]) # SB questa funzione in pratica fa una matrice di dati già stabiliti
# SB su R per vedere come operano le funzioni basta scrivere la funzone 
ggpairs
#spatial analisi
head(meuse) # SB vedo l'inizio del dataset
# SB con la funzione coordinates dico al software come si chiamano
coordinates(meuse) =~ x+y
plot(meuse)
# SB funzione spplot la uso per ottenere un grafico spaziale
spplot(meuse,"zinc")


