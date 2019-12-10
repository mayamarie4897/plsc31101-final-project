#Adding in zip code, city, and state data to VICE and TEVUS
require(revgeo)

#Getting unique latitude and longitude dataframes for each data set
tevus_lat_long <- tevus_dat[, 2:3]

#Test smaller dataset
tevus_lat_long_test <- tevus_lat_long[1:10, ]

vice_lat_long <- adjusted_vice[, 18:19]
vice_lat_long_test <- vice_lat_long[1:10, ]

#Getting location information for TEVUS:
#Test
county_test_tevus <- revgeo(tevus_lat_long_test$Longitude, tevus_lat_long_test$Latitude, 
                            provider= 'google', API = "", 
                            output = 'frame')
                                      

county_tevus <- revgeo(tevus_lat_long$Longitude, tevus_lat_long$Latitude, 
                       provider= 'google', API = "", 
                       output = 'frame')
                                                             
#Writing CSV for TEVUS city/state data
write.csv(county_tevus,
"C:\\Users\\Maya\\Documents\\Fall Quarter 2019\\Computation Social Science\\2019 Final Project\\TEVUS_county.csv", row.names 
= TRUE)

county_tevus <- read.csv("TEVUS_county.csv")

#Smaller VICE dataset to input into Google Maps:

#Unique coordinate values for all 50 police departments
unique_vice_lat_long <- distinct(vice_lat_long)
vice_lat <- unique(vice_lat_long$latitude)
vice_long <- unique(vice_lat_long$longitude)

#New data frame of VICE coordinates
vice_lat_long_unique<- data.frame(vice_lat, vice_long, stringsAsFactors=FALSE)
names(vice_lat_long_unique)[1] <- "latitude"
names(vice_lat_long_unique)[2] <- "longitude"

#Gathering zip code information for VICE: 
county_vice <- revgeo(vice_lat_long_unique$longitude, vice_lat_long_unique$latitude, 
                      provider= 'google', API = "", 
                      output = 'frame')

write.csv(county_vice,"C:\\Users\\Maya\\Documents\\Fall Quarter 2019\\Computation Social Science\\2019 Final Project\\VICE_county.csv", row.names = TRUE)

county_vice <- read.csv("VICE_county.csv")

#Adding new location information to smaller VICE data frame
total <- vice_lat_long_unique %>%
  mutate("ID" = 1:47)

names(county_vice)[1] <- "ID"

#creating complete VICE data set with county and zip info 
merged_vice <- county_vice %>%
  left_join(total, by = "ID")

names(merged_vice)[9] <- "latitude"
names(merged_vice)[10] <- "longitude"

#Adding to full adjusted vice data
full_vice_dat <- merged_vice %>%
  left_join(adjusted_vice, by = "latitude", "longitude")

#Removing a redundant longitude row 
full_vice_dat <- full_vice_dat[, -28]
names(full_vice_dat)[10] <- "longitude"

#CSV for full_vice_dat
write.csv(full_vice_dat, "C:\\Users\\Maya\\Documents\\Fall Quarter 2019\\Computation Social Science\\2019 Final Project\\full-vice-dat.csv", row.names = TRUE)

#Merging the two datasets by loctation:  
#Zip code 
col_a <- full_vice_dat %>%
  count(full_vice_dat$zip)

col_b <- county_tevus %>%
  count(county_tevus$zip)

names(col_a)[1] <- "zip"
names(col_b)[1] <- "zip"

zip_merge <- col_a %>%
  full_join(col_b, by = "zip") %>%
  na.omit()

#Cities
Vice_city_count <- full_vice_dat %>%
  count(full_vice_dat$city)

Tevus_city_count <- county_tevus %>%
  count(county_tevus$city)

names(Vice_city_count)[1] <- "city"
names(Tevus_city_count)[1] <- "city"

city_merge <- Vice_city_count %>%
  full_join(Tevus_city_count, by = "city") %>%
  na.omit ()

names(city_merge)[2] <- "vice"
names(city_merge)[3] <- "tevus"

#States
Vice_state_count <- full_vice_dat %>%
  count(full_vice_dat$state) 

Tevus_state_count <- county_tevus %>%
  count(county_tevus$state)

names(Vice_state_count)[1] <- "state" 
names(Tevus_state_count)[1] <- "state"

state_merge <- Vice_state_count %>%
  full_join(Tevus_state_count, by = "state") %>%
  na.omit()

names(state_merge)[2] <- "vice"
names(state_merge)[3] <- "tevus"

write.csv(state_merge, "C:\\Users\\Maya\\Documents\\Fall Quarter 2019\\Computation Social Science\\2019 Final Project\\state_merge.csv", row.names = TRUE)

head(state_merge)

