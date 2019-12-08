#Necessary packages
library(ggmap)
library(tidyverse)

#Loading data
setwd("~/Fall Quarter 2019/Computation Social Science/2019 Final Project")

#Police use of force: VICE
vice_dat <- read.csv("vice_news_original_data.csv")

#Right wing extremist violence: TEVUS
tevus_dat <- read.csv("tevus_data_2010_2016_rightwing.csv")

#Getting the VICE data into coordinate form
#Google API
register_google(key = "AIzaSyDsxtPNazZLYeveTkaWOpFjZgypNECpMno")
getOption("ggmap")


#Function to add geocoded cities' longitude coordinate back into original dataframe:
lon_function <- function(x){
  long_lat <- as.character(x)
  geocode(long_lat) %>%
    select(lon) %>%
    mutate(lon = sapply(lon, toString)) %>%
    unlist() %>%
    as.numeric()
}

#Function to add geocoded cities' latitute coordinate back into original dataframe:
lat_function <- function(x){
  long_lat <- as.character(x)
  geocode(long_lat) %>%
    select(lat) %>%
    mutate(lat = sapply(lat, toString))%>%
    unlist() %>%
    as.numeric()
}

#Adding latitude into vice_dat
vice_latitude <- vice_dat %>%
  mutate(latitude = lat_function(City))

#Adding longitude into vice_latitude
adjusted_vice <- vice_latitude %>%
  mutate(longitude = lon_function(City))

#Writing CSV for adjusted vice: 
write.csv(adjusted_vice,
          "C:\\Users\\Maya\\Documents\\Fall Quarter 2019\\Computation Social Science\\2019 Final Project\\Vice_with_lat_long.csv", row.names 
          = TRUE)

#Mapping data
install.packages("sp")
install.packages("data.table")
install.packages("ggrepel")
install.packages("sf")
install.packages("mapview")
install.packages("leafsync")

library(lubridate)
library(ggplot2)
library(dplyr)
library(data.table)
library(ggrepel)
library(sf)
library(mapview)
library(leaflet)
library(tidyverse)

#load new VICE csv
adjusted_vice <- read.csv("Vice_with_lat_long.csv")

#Add frequency column to map by event frequency at each location
test_freq_vice <- adjusted_vice %>%
  mutate(Dummy = 1) %>%
  group_by(City, longitude, latitude) %>%
  summarize(sum(Dummy))

#Map function for VICE
Vice <- st_as_sf(test_freq_vice, coords = c("longitude", "latitude"), crs = 4326)  

#Frequencies for TEVUS
test_freq_tevus <- tevus_dat %>%
  mutate(Dummy = 1) %>%
  group_by(Longitude, Latitude) %>%
  summarize(sum(Dummy))

#Map function for TEVUS
TEVUS <- st_as_sf(test_freq_tevus, coords = c("Longitude", "Latitude"), crs = 4326) %>%
  mutate(Dummy = "a")

#Mapping both datasets
mapview(Vice, color = "mediumseagreen", col.regions = "mediumseagreen", cex = "sum(Dummy)") 
+ mapview(TEVUS, color = viridis, col.regions = viridis, cex = "sum(Dummy)", Legend = FALSE) 

