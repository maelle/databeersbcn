library("rdefra")
library("dplyr")

# Pollutant 6 = Particulate Matter (PM2.5) 
nox_stations <- ukair_ catalogue(pollutant = 2,
                                 country_id = 1)
nox_stations$siteID <- ukair_get_site_id(nox_stations$UK.AIR.ID)
nox_london <- filter(nox_stations, grepl("London", Site.Name))
save(nox_london, file = "data/london_stations.RData")
nox_london <- filter(nox_london, !is.na(siteID))

output <- NULL
units <- NULL
for(siteID in nox_london$siteID[nox_london$siteID != "HG2"]){
  print(siteID)
  start_date <- nox_london$Start.Date[nox_london$siteID == siteID]
  start_year <- lubridate::year(start_date)
  end_date <- nox_london$End.Date[nox_london$siteID == siteID]
  
  if(is.na(end_date)){
    end_year <- 2016
  }else{
    end_year <- lubridate::year(end_date)
  }
  
  print(paste(start_year, end_year))
  now <- ukair_get_hourly_data(site_id = siteID, 
                              years = start_year:end_year)
  if(is(now, "data.frame")){
    output <- bind_rows(output,
                        now)
  }
  
  site_units <- attributes(now)$units
  if(!is.null(site_units)){
    mutate(site_units, siteID = siteID)
  }

  units <- bind_rows(units, site_units)
}

readr::write_csv(output, path = "data/defra_london_nox.csv")
readr::write_csv(units, path = "data/defra_london_nox_units.csv")
