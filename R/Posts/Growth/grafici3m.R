#************************
#**Weight-for-recumbent length charts, birth to 36 months, LMS parameters and selected smoothed weight percentiles in kilograms, by sex and recumbent length (in centimeters)
#************************

#	load data
#	M
ccM <- get(load("./R/Posts/Growth/data/mydata3m.rda"))

#	create dataframe for M with numeric
mydataM <- ccM
cols = c(1:ncol(mydataM))
mydataM[,cols] = apply(mydataM[,cols], 2, function(x) as.numeric(as.character(x)))

#***********************
#	Grafico Maschi
#***********************

attach(mydataM)
par(mgp = c(3, 1, 0))
plot(lowess(Length, P3, f=.01), type="l", ylim=c(0,20.5), xlim=c(44,104), lwd=2, axes=F, xlab = "", ylab = "")
title(main="Weight-for-recumbent length charts: \n selected smoothed weight percentiles in kilograms", ylab="Weight (kg)", xlab="Length (cm)")
mtext("Birth to 36 months, Boys", cex=.95, font=3, col="red")

# y axis left
axis(side=2, at=seq(0, 20, 1), labels=seq(0, 20, 1), lwd.ticks=2)
axis(side=2, at=setdiff(seq(0, 20, .2), seq(40, 105, 5)), labels=FALSE, col.ticks="blue")

# y axis right
axis(side=4, at=seq(0, 20, 1), labels=seq(0, 20, 1), lwd.ticks=2)
axis(side=4, at=setdiff(seq(0, 20, .2), seq(40, 105, 5)), labels=FALSE, col.ticks="blue")

# x axis down
axis(side=1, at=seq(44, 104, 1), labels=FALSE, col.ticks="blue")
axis(side=1, at=seq(44, 104, 2), labels=seq(44, 104, 2), lwd.ticks=2)

lines(lowess(Length, P5,  f=.01))
lines(lowess(Length, P10, f=.01), lwd=2)
lines(lowess(Length, P25, f=.01))
lines(lowess(Length, P50, f=.01), lwd=2)
lines(lowess(Length, P75, f=.01))
lines(lowess(Length, P90, f=.01), lwd=2)
lines(lowess(Length, P95, f=.01))
lines(lowess(Length, P97, f=.01), lwd=2)

abline(v=seq(44, 104, 2), col="#0000FF50")
abline(h=seq(0, 20, .2),  col="#0000FF50")

text(max(Length)+.7, max(P3),  "3rd",  adj=0.3, cex=.55)
text(max(Length)+.7, max(P5),  "5th",  adj=0.3, cex=.55)
text(max(Length)+.7, max(P10), "10th", adj=0.3, cex=.55)
text(max(Length)+.7, max(P25), "25th", adj=0.3, cex=.55)
text(max(Length)+.7, max(P50), "50th", adj=0.3, cex=.55)
text(max(Length)+.7, max(P75), "75th", adj=0.3, cex=.55)
text(max(Length)+.7, max(P90), "90th", adj=0.3, cex=.55)
text(max(Length)+.7, max(P95), "95th", adj=0.3, cex=.55)
text(max(Length)+.7, max(P97), "97th", adj=0.3, cex=.55)

detach(mydataM)

