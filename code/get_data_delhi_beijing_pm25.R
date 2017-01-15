library("ropenaq")
library("dplyr")
library("ggplot2")
library("viridis")
library("usaqmindia")
library("tidyr")
data("pm25_india")
############################################################
#                                                          #
#                   Get older India data                   ####
#                                                          #
############################################################

pm25_india <- filter(pm25_india, city == "Delhi")
pm25_india <- mutate(pm25_india, 
                     location = "US Diplomatic Post: New Delhi")
pm25_india <- rename(pm25_india, value = conc)
pm25_india <- rename(pm25_india, dateLocal = datetime)

############################################################
#                                                          #
#          Get data from the two diplomatic posts          ####
#                                                          #
############################################################

count_india <- aq_measurements(city = "Delhi", parameter = "pm25",
                               location = "US+Diplomatic+Post%3A+New+Delhi",
                               date_to = as.character(Sys.Date() - 1))
count_india <- attr(count_india, "meta")$found
meas_india <- NULL
for(page in 1:ceiling(count_india/1000)){
  print(page)
  meas_india <- bind_rows(meas_india,
                          aq_measurements(city = "Delhi", parameter = "pm25",
                                          location = "US+Diplomatic+Post%3A+New+Delhi",
                                          limit = 1000, page = page))
}



count_china <- aq_measurements(city = "Beijing", parameter = "pm25",
                               location = "Beijing+US+Embassy")
count_china <- attr(count_china, "meta")$found
meas_china <- NULL
for(page in 1:ceiling(count_china/1000)){
  print(page)
  meas_china <- bind_rows(meas_china,
                          aq_measurements(city = "Beijing", parameter = "pm25",
                                          location = "Beijing+US+Embassy",
                                          limit = 1000, page = page))
}

common_dates <- pm25_india$dateLocal[pm25_india$dateLocal %in% meas_india$dateLocal]
meas_india <- filter(meas_india,
                     !dateLocal %in% common_dates)
both <- bind_rows(meas_china, meas_india)
both <- select(both, dateLocal, city, value, location)
both <- bind_rows(both, pm25_india)
save(both, file = "data/meas_india.RData")
save(meas_china, file = "data/meas_china.RData")

