# data from http://dtes.gencat.cat/icqa/
library("readr")
library("dplyr")

poblenou2013 <- read_csv("data/poblenou2013.csv")
poblenou2014 <- read_csv("data/poblenou2014.csv")
poblenou2015 <- read_csv("data/poblenou2015.csv")
poblenou2016 <- read_csv("data/poblenou2016.csv")

poblenou <- bind_rows(poblenou2013,
                      poblenou2014,
                      poblenou2015,
                      poblenou2016)

poblenou <- poblenou[,c(1,3)]
names(poblenou) <- c("day", "value")
poblenou <- mutate(poblenou, value = as.numeric(value))

poblenou <- mutate(poblenou, day = lubridate::dmy(day))
poblenou <- mutate(poblenou, day = as.character(day))
write_csv(poblenou, path = "data/poblenou.csv")