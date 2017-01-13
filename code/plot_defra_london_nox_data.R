library("ggplot2")
library("viridis")
library("dplyr")
library("tidyr")
library("ggmap")
library("gganimate")
# open data
nox <- readr::read_csv("data/defra_london_nox.csv")
load("data/london_stations.RData")

# from wide to long, and without the columns not containing PM2.5
nox <- select(nox, datetime, SiteID, dplyr::contains("Nitr"))


nox <- left_join(nox, nox_london, by = c("SiteID" = "siteID"))

nox <- gather(nox, "parameter", "value", 3:5)
nox <- filter(nox, !is.na(value))
nox <- mutate(nox, date = as.Date(datetime))
nox <- mutate(nox, value = as.numeric(value))

mintime <- min(nox$datetime)
ew <- lubridate::eweeks(1)
nox <- mutate(nox, week = (datetime - mintime)/ew)

# mean
nox <- nox  %>%
  group_by(date, SiteID, Longitude, Latitude,
           Site.Name, Site.Description, parameter) %>%
  summarize(value = mean(value, na.rm = TRUE))

# boxplots 
nox %>% 
  filter(SiteID == "LON6") %>%
  ggplot() +
  geom_boxplot(aes(as.factor(lubridate::year(date)),
                   value, fill = parameter),
               outlier.shape = NA) +
  scale_color_viridis(discrete = TRUE) +
  facet_grid(parameter ~ ., scales = "free_y")

nox  %>%
  group_by(date, SiteID, Site.Name) %>%
  summarize(value = mean(value, na.rm = TRUE)) %>%
  ggplot() +
  geom_boxplot(aes(as.factor(lubridate::year(date)),
                   value)) +
  facet_grid(SiteID ~ .)

# map

nox_2015 <- filter(nox, parameter == "Nitric.oxide")
nox_2015 <- group_by(nox_2015, parameter,
                     SiteID, Longitude, Latitude,
                     year = lubridate::year(date))
nox_2015 <- summarize(nox_2015, value = mean(value))
map <- get_map("London")
ggmap(map) +
  g <- ggplot() +  geom_point(aes(x = Longitude, y = Latitude,
                                  col = value, frame = year), size = 3,
                              data = nox_2015) +
  scale_color_viridis() 
gg_animate(g, file = "test.mp4")



# another plot
for(siteID in unique(nox$SiteID)){
  print(siteID)
  nox %>% 
    filter(SiteID == siteID) %>%
    mutate(month = stringr::str_pad(lubridate::month(date),
                                    width = 2, pad = "0")) %>%
    ggplot() +
    geom_line(aes(date, value)) +
    scale_color_viridis(discrete = TRUE) +
    facet_grid(parameter ~ ., scales = "free_y")
  ggsave(file = paste0("figs/", siteID, ".png"),
         width = 8, height = 6)
}
