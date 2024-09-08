
MygrowthFun <- function(
  sex=c("m", "f"), 
  type=c("wlc", "hac", "wsc", "wac", "lac", "bac"), 
  state = c("CDC-WHO", "Saudi"),
  path="./R/Posts/Growth/",
  name = NULL,
  birth_date = NULL,
  date_visit = NULL,
  mydataAA = NULL) {
  
  if(state == "Saudi") {
    switch(
      type,
      "wac" = source(paste(path, "wa_60.R", sep="")),
      "lac" = source(paste(path, "ha_60.R", sep=""))
    )
    if(mydataAA$months < 61) {
      saudi_wa60(sex)
    } else {
      mydataAA <- mydataAA %>%
        mutate(months = floor(months/12))
      switch(
        type,
        "wac" = source(paste(path, "wa_5.R", sep="")),
        "lac" = source(paste(path, "ha_5.R", sep=""))
      )
      saudi_wa5(sex)
    }
  } else {
    if(mydataAA$months < 61) {
      if(sex == "m") {
        switch(
          type,
          "wac" = source(paste(path, "grafici1m.R", sep=""))
        )
      } else {
        switch(
          type,
          "wac"	= source(paste(path, "grafici1f.R", sep=""))
        )
      }
    }
    if(mydataAA$months > 60) {
      if(sex == "m") {
        switch(
          type,
          "wac" = source(paste(path, "grafici6m.R", sep=""))
        )
      } else {
        switch(
          type,
          "wac"	= source(paste(path, "grafici6f.R", sep=""))
        )
      }
    }
    if(mydataAA$months < 37) {
      if(sex == "m") {
        switch(
          type,
          "lac"	= source(paste(path, "grafici2m.R", sep="")),
          #"wlc"	= source(paste(path, "grafici3m.R", sep="")),
          #"hac"	= source(paste(path, "grafici4m.R", sep="")),
          #"wsc"	= source(paste(path, "grafici5m.R", sep="")),
          #"bac"	= source(paste(path, "grafici8m.R", sep=""))
        )
      } else {
        switch(
          type,
          "lac"	= source(paste(path, "grafici2f.R", sep="")),
          #"wlc"	= source(paste(path, "grafici3f.R", sep="")),
          #"hac"	= source(paste(path, "grafici4f.R", sep="")),
          #"wsc"	= source(paste(path, "grafici5f.R", sep="")),
          #"bac"	= source(paste(path, "grafici8f.R", sep=""))
        )
      }
    }
    if(mydataAA$months > 36) {  
      if(sex == "m") {
        switch(
          type,
          "lac"	= source(paste(path, "grafici7m.R", sep="")),
          #"wlc"	= source(paste(path, "grafici3m.R", sep="")),
          #"hac"	= source(paste(path, "grafici4m.R", sep="")),
          #"wsc"	= source(paste(path, "grafici5m.R", sep="")),
          #"bac"	= source(paste(path, "grafici8m.R", sep=""))
        )
      } else {
        switch(
          type,
          "lac"	= source(paste(path, "grafici7f.R", sep="")),
          #"wlc"	= source(paste(path, "grafici3f.R", sep="")),
          #"hac"	= source(paste(path, "grafici4f.R", sep="")),
          #"wsc"	= source(paste(path, "grafici5f.R", sep="")),
          #"bac"	= source(paste(path, "grafici8f.R", sep=""))
        )
      }
    }
  }
  
  mtext(
    substitute(
      paste(bolditalic("Name: "), name), list(name=name)),
    side=1, outer=T, adj=0, line=-3)
  mtext(
    substitute(
      paste(bolditalic("Date of Measurement: "), date), 
      list(date=date_visit)),
    side=1, outer=T, adj=0, line=-1)
  mtext(
    substitute(
      paste(bolditalic("Birth Date: "), birth_date), list(birth_date=birth_date)), 
    side=1, outer=T, adj=0, line=-2)
  
  points(mydataAA, type="p", col="red", pch = 16)
}
