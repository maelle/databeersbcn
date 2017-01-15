library("ropenaq")
library("dplyr")
library("tidyr")
count <- aq_measurements(country = "US", 
                         has_geo = TRUE, 
                         parameter = "pm25", 
                         date_from = "2016-07-04",
                         date_to = "2016-07-06",
                         value_from = 0)
count <- ceiling(attr(count, "meta")$found/1000)
measurements <- NULL
for (page in 1:count){
  print(page)
  measurements <- rbind(measurements,
                        aq_measurements(country = "US", 
                                        has_geo = TRUE, 
                                        page = page,
                                        parameter = "pm25", 
                                        limit = 1000,
                                        date_from = "2016-07-04",
                                        date_to = "2016-07-06",
                                        value_from = 0))}

measurements <- measurements %>% 
  group_by(hour = update(dateUTC, minute = 0),
           location, longitude, latitude, dateUTC) %>%
  summarize(value = mean(value))
measurements <- group_by(measurements, location) %>%
  filter(all(!is.na(value))) %>%
  ungroup()

measurements <- measurements %>%
  ungroup() %>%
  mutate(hour = update(hour, hour = lubridate::hour(hour) - 5)) %>%
  mutate(value = ifelse(value > 80, 80, value))
save(measurements, file = "data/4th_july.RData")




