#primo codice
install.packages("sp") # SB il comando install.packages serve per installare i pacchetti che mi servono
# in R quando vado a prendere qualcosa di esterno ad R devo sempre metterlo tra virgolette
library(sp) # SB può anche essere sostituito da require e serve per richiamare la libreria che serve
data(meuse) # SB il comando data permette di selezionare i dati che mi servono
meuse # SB scrivendo il nome vedo le caratteristiche :
#class       : SpatialPointsDataFrame 
#features    : 155 
#extent      : 178605, 181390, 329714, 333611  (xmin, xmax, ymin, ymax)
#crs         : NA 
#variables   : 12
#names       : cadmium, copper, lead, zinc,  elev,     dist, om, ffreq, soil, lime, landuse, dist.m 
#min values  :     0.2,     14,   37,  113,  5.18,        0,  1,     1,    1,    0,      Aa,     10 
#max values  :    18.1,    128,  654, 1839, 10.52, 0.880389, 17,     3,    3,    1,       W,   1000 
head(meuse) # SB il comando head mi mostra le prime righe del dataset, potrei usare anche il comando names
#       x     y  cadmium copper lead zinc elev dist om ffreq soil lime landuse
# 1   181072 333611 11.7 85 299 1022 7.909 0.00135803 13.6 1 1 1 Ah# dist.m
# 2   181025 333558 8.6 81 277 1141 6.983 0.01222430 14.0 1 1 1 Ah
# 3   181165 333537 6.5 68 199 640 7.800 0.10302900 13.0 1 1 1 Ah
# 4   181298 333484 2.6 81 116 257 7.655 0.19009400 8.0 1 2 0 Ga
# 5   181307 333330 2.8 48 117 269 7.480 0.27709000 8.7 1 2 0 Ah
# 6   181390 333260 3.0 61 137 281 7.791 0.36406700 7.8 1 2 0 Ga

names(meuse)
#[1] "cadmium" "copper"  "lead"    "zinc"    "elev"    "dist"    "om"     
#[8] "ffreq"   "soil"    "lime"    "landuse" "dist.m" 
summary(meuse) # SB questa funzione mi mostra un sommario del mio dataset
pairs(meuse) # SB la funzione pairs produce un plot di tutte le variabili in un dataset
pairs(~ cadmium + copper + lead , data = meuse) # SB così dico ad R quali variabili voglio rappresentare e da quale dataset (data=meuse)
## EX: fare un pairs con cadmium copper lead zinc
pairs(~ cadmium + copper + lead + zinc, data = meuse)
# SB potevo fare anche pairs(meuse[,3:6]) perchè osservando le caratteristiche del dataset questi elementi sono i primi 4
# SB fare pairs ma cambiare il colore in rosso
pairs(meuse[,3:6], col="red") # SB bisogna mettere tra virgolette anche i testi come "red"
pairs(meuse[,3:6], col="red", pch=19) # SB con pch si intende il tipo di simbolo che usa per plottare (c'è elenco su internet)
pairs(meuse[,3:6], col="red", pch=19, cex=3) # SB cex è la dimensione del simbolo
pairs(meuse[,3:6], col="red", pch=19, cex=3, main="Primo pairs") # SB main = quello che voglio scrivere nel grafico
## Ex:fare la stessa cosa ma con la relazione tra elevatione gli elementi 
pairs(meuse[,3:7], col="red", pch=19, cex=3, main="Primo pairs") # SB ho visto che elevation corrisponde alla colonna 7
# SB 3 pannelli dall'esterno (già fatti)
 # panel.correlations <- function(x, y, digits=1, prefix="", cex.cor)
# {
#     usr <- par("usr"); on.exit(par(usr))
#     par(usr = c(0, 1, 0, 1))
#     r1=cor(x,y,use="pairwise.complete.obs")
#     r <- abs(cor(x, y,use="pairwise.complete.obs"))
# 
#     txt <- format(c(r1, 0.123456789), digits=digits)[1]
#     txt <- paste(prefix, txt, sep="")
#     if(missing(cex.cor)) cex <- 0.9/strwidth(txt)
#     text(0.5, 0.5, txt, cex = cex * r)
# }
# 
# panel.smoothing <- function (x, y, col = par("col"), bg = NA, pch = par("pch"),
#     cex = 1, col.smooth = "red", span = 2/3, iter = 3, ...)
# {
#     points(x, y, pch = pch, col = col, bg = bg, cex = cex)
#     ok <- is.finite(x) & is.finite(y)
#     if (any(ok))
#         lines(stats::lowess(x[ok], y[ok], f = span, iter = iter),
#             col = 1, ...)
# }
# 
# 
# panel.histograms <- function(x, ...)
# {
#     usr <- par("usr"); on.exit(par(usr))
#     par(usr = c(usr[1:2], 0, 1.5) )
#     h <- hist(x, plot = FALSE)
#     breaks <- h$breaks; nB <- length(breaks)
#     y <- h$counts; y <- y/max(y)
#     rect(breaks[-nB], 0, breaks[-1], y, col="white", ...)
# }

pairs(meuse[,3:6], lower.panel = panel.correlations, upper.panel = panel.smoothing, diag.panel = panel.histograms)
## EX : mettere come lower panel lo smoothing, come diagonal apnel gli istogrammi e come upper panel le correlazioni 
pairs(meuse[,3:6], lower.panel = panel.smoothing, upper.panel = panel.correlations, diag.panel = panel.histograms)# SB basta cambiare l'ordine
# SB come utilizzare la funzione plot
plot(meuse$cadmium,meuse$copper) # SB il $ lega la variabile al suo dataset (è meglio di attach perche funziona con tutti i pacchetti)
plot(cadmium, copper, pch=17, col="green", main="primo plot") # SB aggiungiamo il colore verde e il titolo 
plot(cadmium, copper, pch=17, col="green", main="primo plot", xlab="cadmio", ylab="rame") # SB aggiungiamo anche le etichette agli assi
plot(cadmium, copper, pch=17, col="green", main="primo plot", xlab="cadmio", ylab="rame", cex.lab=2, cex=2) # SB aggiustiamo anche la dimensione del simbolo


