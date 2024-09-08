
# Source other scripts used in the app
source("R/Posts/Growth/grafici7m.R")
source("R/Posts/Growth/grafici7f.R")
source("R/Posts/Growth/grafici6m.R")
source("R/Posts/Growth/grafici6f.R")
source("R/Posts/Growth/grafici1m.R")
source("R/Posts/Growth/grafici1f.R")
source("R/Posts/Growth/grafici2m.R")
source("R/Posts/Growth/grafici2f.R")

# Load required data
load("R/Posts/Growth/data/mydata7f.rda")
load("R/Posts/Growth/data/mydata7m.rda")
load("R/Posts/Growth/data/mydata6f.rda")
load("R/Posts/Growth/data/mydata6m.rda")
load("R/Posts/Growth/data/mydata2f.rda")
load("R/Posts/Growth/data/mydata2m.rda")
load("R/Posts/Growth/data/mydata1f.rda")
load("R/Posts/Growth/data/mydata1m.rda")

# Load CSV files
hg_60 <- read.csv("R/Posts/Growth/data/hg_60.csv")
wg_60 <- read.csv("R/Posts/Growth/data/wg_60.csv")
wg_5 <- read.csv("R/Posts/Growth/data/wg_5.csv")
hg_5 <- read.csv("R/Posts/Growth/data/hg_5.csv")
