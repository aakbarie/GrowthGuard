#************************
#**Weight-for-stature charts, LMS parameters and selected smoothed weight percentiles in kilograms, by sex and stature (in centimeters) 
#************************

#	load data
#	M
ccM <- get(load("./R/Posts/Growth/data/mydata5m.rda"))

#	create dataframe for M with numeric
mydataM <- ccM
cols = c(1:ncol(mydataM))
mydataM[,cols] = apply(mydataM[,cols], 2, function(x) as.numeric(as.character(x)))

#***********************
#	Grafico Maschi
#***********************

attach(mydataM)
par(mgp = c(3, 1, 0))
plot(lowess(Height, P3, f=.01), type="l", ylim=c(8, 30.5), xlim=c(77, 121.5), lwd=2, axes=F, xlab = "", ylab = "")
title(main="Weight-for-stature charts: \n smoothed weight percentiles in kilograms", ylab="Weight (kg)", xlab="Stature (cm)")
mtext("Boys", cex=.95, font=3, col="red")

# y axis left
axis(side=2, at=seq(8, 30.5, .2), labels=FALSE, col.ticks="blue")
axis(side=2, at=seq(8, 30.5, 1), labels=seq(8, 30.5, 1), lwd.ticks=2)

# y axis right
axis(side=4, at=seq(8, 30.5, .2), labels=FALSE, col.ticks="blue")
axis(side=4, at=seq(8, 30.5, 1), labels=seq(8, 30.5, 1), lwd.ticks=2)

# x axis down
axis(side=1, at=seq(77, 121.5, 0.5), labels=FALSE, col.ticks="blue")
axis(side=1, at=seq(77, 121.5, 1), labels=seq(77, 121.5, 1), lwd.ticks=2)

lines(lowess(Height, P5,  f=.01))
lines(lowess(Height, P10, f=.01), lwd=2)
lines(lowess(Height, P25, f=.01))
lines(lowess(Height, P50, f=.01), lwd=2)
lines(lowess(Height, P75, f=.01))
lines(lowess(Height, P85, f=.01))
lines(lowess(Height, P90, f=.01), lwd=2)
lines(lowess(Height, P95, f=.01))
lines(lowess(Height, P97, f=.01), lwd=2)

abline(v=seq(77, 121.5, 1), col="#0000FF50")
abline(h=seq(8, 30.5, .2),  col="#0000FF50")

text(max(Height)+.7, max(P3),  "3rd",  adj=0.3, cex=.55)
text(max(Height)+.7, max(P5),  "5th",  adj=0.3, cex=.55)
text(max(Height)+.7, max(P10), "10th", adj=0.3, cex=.55)
text(max(Height)+.7, max(P25), "25th", adj=0.3, cex=.55)
text(max(Height)+.7, max(P50), "50th", adj=0.3, cex=.55)
text(max(Height)+.7, max(P75), "75th", adj=0.3, cex=.55)
text(max(Height)+.7, max(P85), "85th", adj=0.3, cex=.55)
text(max(Height)+.7, max(P90), "90th", adj=0.3, cex=.55)
text(max(Height)+.7, max(P95), "95th", adj=0.3, cex=.55)
text(max(Height)+.7, max(P97), "97th", adj=0.3, cex=.55)

detach(mydataM)

