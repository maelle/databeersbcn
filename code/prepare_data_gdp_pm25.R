library("readr")
library("tidyr")
library("dplyr")

gdp <- read_csv("data/plotlyfig.csv")
africa <- gdp[, 1:3] %>% mutate(continent = "Africa")
names(africa)[1:3] <- c("country", "gdp", "pm25")
asia <- gdp[, 4:6] %>% mutate(continent = "Asia Pacific")
names(asia)[1:3] <- c("country", "gdp", "pm25")

eastern <- gdp[, 8:10] %>% mutate(continent = "Eastern Europe")
names(eastern)[1:3] <- c("country", "gdp", "pm25")

latin <- gdp[, 11:13] %>% mutate(continent = "Latin America &Carribean")
names(latin)[1:3] <- c("country", "gdp", "pm25")

western <- gdp[, 15:17] %>% mutate(continent = "Western Europe &Others")
names(western)[1:3] <- c("country", "gdp", "pm25")

gdp_data <- bind_rows(africa, asia, eastern, latin, western)
write_csv(gdp_data, path = "data/gdp_data.csv")

