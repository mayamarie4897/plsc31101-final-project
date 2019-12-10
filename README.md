# plsc31101-final-project
This is my final project for PLSC 31101

## Project Description

This project compares locations of police use of force and right wing extremist violence in the US. To accomplish this, the project utilizes two data sets: one from VICE News on police use of force and another from the Terrorism and Extremist Violence in the US (TEVUS) database on right wing extremist violence.

## Dependencies

1. R, 3.6.1
2. RStudio, Version 1.2.5001
3. Required: tidyverse, ggmap, ggplot2, dplyr, sf, mapview, leaflet, viridis, revgeo, stargazer

## Files

####/

1. Van Nuys Narrative.Rmd: Provides a 3-5 page narrative of the project, main challenges, solutions, and results.
2. Van Nuys Narrative.pdf: A knitted pdf of the Narrative.Rmd.
3. Van_Nuys_final_presentation.pptx: Lightning talk slides

#### Code
1. Mapping_code.R: Converts VICE location data to coordinates and maps the VICE and TEVUS data onto an interactive map. 
2. Merging_code.R: Merges the VICE and TEVUS data sets based on three different location-types (zip code, city, and state). 
3. Analysis_and_visualization.R: Plots the merged data set of frequencies for both TEVUS and VICE at the state-level on a barplot. Conducts a linear regression on the merged state-level data. 

#### Data
1. Tevus_original_dat.csv: The original TEVUS data set of right wing extremist violence between 2010 and 2016. You can request access to the Terrorist and Extremist Violence in the US (TEVUS) database: https://www.start.umd.edu/tevus-portal-access-request
2. TEVUS_right_wing_locations.csv: The city, state, zip code, and other locational data for the TEVUS data set derived from the original data.  
3. VICE_original_dat.csv: The original VICE News data set of police use of force incident in the 50 largest US police departments between 2010 and 2016. Access here: https://news.vice.com/en_us/article/a3jjpa/nonfatal-police-shootings-data 
4. VICE_police_violence_locations.csv: The city, state, zip code, and other locational data for the VICE data set added to the original data. 
5. VICE_TEVUS_merged_state.csv: The merged data set of TEVUS and VICE events by state - the final product of the analysis at the state-level. It includes the variables state (for a US state), vice (for the frequency of police use of force incidents in the state in the specified time frame), and tevus (for the frequency of right wing extremist events in the state during the time frame). 

#### Results
1. regression_one.txt: Summarizes the results of a sipmle linear regression of VICE on TEVUS. 
2. TEVUS_VICE_by_state.png: A barplot of TEVUS and VICE events by state between 2010 and 2016. 
3. TEVUS_VICE_map.png: A screenshot of the interactive map layering TEVUS and VICE data over each other with point size determined by frequency. 
