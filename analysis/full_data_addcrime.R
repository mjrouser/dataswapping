####################################
#### Created by : Jackie			 ####
#### Date: March 7, 2014 	 		####
#### Project: Dataswap 				 ####
#### Re: Add Crime data to full data	 ####
###################################
rm(list = ls())
setwd("C:/Users/Jackie/Dropbox/Civic Tech/Dataswap/dataswap/Tax Assessor's Database and Auxiliary Data/output/data")
crimedata <- read.csv("crime_bg_vars.csv")
fulldata <- read.csv("full_data.csv")
newdata <- merge(fulldata, crimedata, by = c("geoid10", "year"), all.x = TRUE)
newdata[is.na(newdata)] <- 0
write.csv(newdata, "full_data.csv", row.names = FALSE, na = '')
