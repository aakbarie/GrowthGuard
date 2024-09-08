# Weight-for-age charts ---------------------------------------------------
# LMS parameters and selected smoothed weight percentiles in kilograms, by sex and age 

#	load data
saudi_wa5 <- function(sex=c("m", "f")) {
  library(tidyverse)
  
  suppressMessages(wa_data <- read_csv("./R/Posts/Growth/data/wg_5.csv"))
  
  sex_c = ifelse(sex == "m", 1, 2)
  color = ifelse(sex == "m", "blue", "red")
  gender = ifelse(sex == "m", "Boys", "Girls")
  
  wa_data <- wa_data %>%
    filter(Sex == sex_c)
  
  par(mgp = c(3, 1, 0))
  
  plot(lowess(wa_data$Agemos, wa_data$P3, f=.01), 
       type="l", ylim=c(10, 120), lwd=2, axes=F, xlab = "", ylab = "")
  title(main="The Growth Charts for Children and Adolescents", 
        xlab="Age (Years)", ylab="Weight (kg)")
  mtext(
    paste0("Weight-for-age percentiles: ",gender,", age 5 to 18"),
    cex=.95, font=3, col="red")
  
  # y axis left
  axis(side=2, at=seq(10, 120, 2), labels=FALSE, col.ticks=color)
  axis(side=2, at=seq(10, 120,  5), labels=seq(10, 120,  5), lwd.ticks=2)
  
  # y axis right
  axis(side=4, at=seq(10, 120,  0.5), labels=FALSE, col.ticks=color)
  axis(side=4, at=seq(10, 120,  5), labels=seq(10, 120,  5), lwd.ticks=2)
  
  # x axis down
  axis(side=1, at=seq(5, 18, 0.5), labels=FALSE, col.ticks=color)
  axis(side=1, at=seq(5, 18, 1), labels=seq(5, 18, 1), lwd.ticks=2)
  
  lines(lowess(wa_data$Agemos, wa_data$P5,  f=.01))
  lines(lowess(wa_data$Agemos, wa_data$P10, f=.01), lwd=2)
  lines(lowess(wa_data$Agemos, wa_data$P25, f=.01))
  lines(lowess(wa_data$Agemos, wa_data$P50, f=.01), lwd=2)
  lines(lowess(wa_data$Agemos, wa_data$P75, f=.01))
  lines(lowess(wa_data$Agemos, wa_data$P90, f=.01), lwd=2)
  lines(lowess(wa_data$Agemos, wa_data$P95, f=.01))
  lines(lowess(wa_data$Agemos, wa_data$P97, f=.01), lwd=2)
  
  abline(v=seq(5, 18, 1),   col=color)
  abline(h=seq(10, 120, 2), col=color)
  
  text(max(wa_data$Agemos)+.7, max(wa_data$P3),  "3rd",  adj=0.3, cex=.55)
  text(max(wa_data$Agemos)+.7, max(wa_data$P5),  "5th",  adj=0.3, cex=.55)
  text(max(wa_data$Agemos)+.7, max(wa_data$P10), "10th", adj=0.3, cex=.55)
  text(max(wa_data$Agemos)+.7, max(wa_data$P25), "25th", adj=0.3, cex=.55)
  text(max(wa_data$Agemos)+.7, max(wa_data$P50), "50th", adj=0.3, cex=.55)
  text(max(wa_data$Agemos)+.7, max(wa_data$P75), "75th", adj=0.3, cex=.55)
  text(max(wa_data$Agemos)+.7, max(wa_data$P90), "90th", adj=0.3, cex=.55)
  text(max(wa_data$Agemos)+.7, max(wa_data$P95), "95th", adj=0.3, cex=.55)
  text(max(wa_data$Agemos)+.7, max(wa_data$P97), "97th", adj=0.3, cex=.55)
}

