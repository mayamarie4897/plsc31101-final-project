plsc31101-final-project
This is my final project for PLSC 31101

Project Description

This project compares locations of police use of force and right wing extremist violence in the US. To accomplish this, the project utilizes two data sets: one from VICE News on police use of force and another from the Terrorism and Extremist Violence in the US (TEVUS) database on right wing extremist violence. To map the locations of these events, both datasets needed to have latitude and longitude coordinates, so the first part of the code allows one to convert the city names of the VICE data into coordinates. With coordinates, one can map both data sets on an interactive map. 

To run statistical analysis and visualize the data, the project required merging the two data sets by location. To do this, the TEVUS data set needs zip code, city, and state information. The "revgeo" function allows one to translate coordinates into multiple levels of location data. After gathering zip codes, cities, and states for both data sets, one can merge the two together. This required trials at several different levels of analysis location-wise. There were few zip codes and cities that had both police use of force event and right wing extremist events, so the project analyzed state-level data. 

Dependencies

1. R, 3.6.1
2. RStudio, Version 1.2.5001


Files

1. Van Nuys Narrative.Rmd: Provides a 3-5 page narrative of the project, main challenges, solutions, and results.
2. Van Nuys Narrative.pdf: A knitted pdf of the Narrative.Rmd.
3. Van_Nuys_final_presentation.pptx: Lightning talk slides

Code
1. Mapping_code.R: Converts VICE location data to coordinates and maps the VICE and TEVUS data onto an interactive map. 
2. Merging_and_analysis.R: Merges the VICE and TEVUS data sets based on three different location-types (zip code, city, and state). Plots the merged data set of frequencies for both TEVUS and VICE at the state-level on a barplot. Conducts a linear regression on the merged state-level data. 

Data
1. Tevus_original_dat.csv: The original TEVUS data set of right wing extremist violence between 2010 and 2016. 
2. TEVUS_right_wing_locations.csv: The city, state, zip code, and other locational data for the TEVUS data set derived from the original data.  
3. VICE_original_dat.csv: The original VICE News data set of police use of force incident in the 50 largest US police departments between 2010 and 2016. 
4. VICE_police_violence_locations.csv: The city, state, zip code, and other locational data for the VICE data set added to the original data. 
5. VICE_TEVUS_merged_state.csv: The merged data set of TEVUS and VICE events by state - the final product of the analysis at the state-level. It includes the variables state (for a US state), vice (for the frequency of police use of force incidents in the state in the specified time frame), and tevus (for the frequency of right wing extremist events in the state during the time frame). 

Results
1. regression_one.txt: Summarizes the results of a sipmle linear regression of VICE on TEVUS. 
2. TEVUS_VICE_by_state.png: A barplot of TEVUS and VICE events by state between 2010 and 2016. 
3. TEVUS_VICE_map.png: A screenshot of the interactive map layering TEVUS and VICE data over each other with point size determined by frequency. 
