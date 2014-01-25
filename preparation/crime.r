# load libraries for processing
library(sqldf)
library(foreign)
library(stringr)

# set wd
setwd('/Volumes/SaoirseMor/Dropbox/dataswap/')

# load publishing data
crime <- read.csv('Open_Gov_Boston/Crime_Incident_Reports.csv')
crime_sample <- head(crime, 20)
write.csv(crime_sample, 'Open_Gov_Boston/crime_sample.csv', row.names=F)
