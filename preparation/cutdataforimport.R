# subset data from Boston Blight and Building Data for necessary variables

setwd("C:/Users/Jackie/Dropbox/Dataswap/Tax Assessor's Database and Auxiliary Data/BostonBlightBuilding")

# david's path
setwd("/Volumes/SaoirseMor/Dropbox/dataswap/BostonBlightBuilding/")

# 911 reports ####
dat <- read.csv("CAD Final (911 Reports).csv")
datcut <- dat[, c(9, 10, 13, 14, 15, 17, 18, 19)]
names(datcut) <- c("XCoordinate", "YCoordinate", "type", "priority", "closedate", "disorder", "medemerg", "violent")

datcut[, 3] <- as.character(datcut[, 3]) # change to string from factor
datcut[, 4] <- ifelse(datcut[, 4]==".", NA, datcut[, 4]) # change . to NA

# reformat date
library("stringr")
datcut[, 5] <- ifelse(datcut[, 5] == ".", "", 
											ifelse(nchar(as.character(datcut[, 5]) == 8), 
													  	paste("20", str_sub(datcut[, 5], -2, -1), "-", 
										  							str_sub(datcut[, 5], -6, -4), "-", 
										  							"0", str_sub(datcut[, 5], 1, 1), 
										  							sep = ""), 
															paste("20", str_sub(datcut[, 5], -2, -1), "-", 
										  							str_sub(datcut[, 5], -6, -4), "-", 
										 			 					str_sub(datcut[, 5], 1, 2), 
										  							sep = "")))


write.csv(datcut, "CAD_Final_911Reports_forimport.csv", row.names=F, na = '')

# CRM (311) data ####
rm(list=ls())

dat <- read.csv("CRM Final.csv")
datcut <- dat[, c(8:9, 21:22, 13, 3, 5, 6, 7, 16, 18, 31:38)]
names(datcut) <- c("X", "Y", "X_alt", "Y_alt", "propid", "opendate", "subject", "reason", "type", "channel", "source", "Unciviluse", "Housing", "BigBuild", "Graffiti", "Trash", "PrivateNeglect", "Problem", "PublicDenig")
datcut[, 5] <- as.character(datcut[, 5])
datcut[, 6] <- as.Date(as.character(datcut[, 6]), "%m/%d/%Y") # reformat date
datcut[, 7] <- as.character(datcut[, 7])
datcut[, 8] <- as.character(datcut[, 8])
datcut[, 9] <- as.character(datcut[, 9])
datcut[, 10] <- as.character(datcut[, 10])
datcut[, 11] <- as.character(datcut[, 11])

write.csv(datcut, "CRM_Final_forimport.csv", row.names=F, na = '')

# fires data ####
rm(list=ls())

dat <- read.csv("Fires Final.csv")
datcut <- dat[, c(7:8, 38, 14, 20, 22:23, 35)]

datcut[, 4] <- as.Date(as.character(datcut[, 4]), "%m/%d/%Y") # reformat date
datcut[, 7] <- as.character(datcut[, 7])

write.csv(datcut, "Fires_Final_forimport.csv")

# permits data ####
dat <- read.csv("Hansen Permits_2009_2012.csv")
datcut <- dat[, c(20, 19, 10, 2, 3, 26, 29)]
names(datcut) <- c("X_GPS", "Y_GPS", "AddressID", "PermitType", "adddate", "PermitType_long", "Descript")

# change to numeric for GPS coordinates
datcut[, 1] <- as.numeric(
	ifelse(
		as.character(datcut[, 1]) %in% c("0", "-1", "NULL"), 
		"NA", 
		as.character(datcut[, 1])
		)
	) 
datcut[, 2] <- as.numeric(
	ifelse(
		as.character(datcut[, 2]) %in% c("0", "-1", "NULL"), 
		"NA", 
		as.character(datcut[, 2])
		)
	) 
datcut[, 3] <- as.character(datcut[, 3]) # change to string from factor
datcut[, 4] <- as.character(datcut[, 4]) # change to string from factor
datcut[, 6] <- as.character(datcut[, 6])
datcut[, 7] <- as.character(datcut[, 7])

# reformat date
library("stringr")
datcut[, 5] <- sub(" .*", "", as.character(datcut[, 5])) # get rid of time
datcut[, 5]	<- ifelse(nchar(sub("/.*", "", as.character(datcut[, 5]))) == 2, 
										 paste("20", sub(".*/", "", as.character(datcut[, 5])), "-", 
										 sub("/.*", "", as.character(datcut[, 5])), "-", 
										 sub("/.*", "", sub("*../*", "", as.character(datcut[, 5]))), 
										 sep = ""), 
										paste("20", sub(".*/", "", as.character(datcut[, 5])), "-", 
										 "0", sub("/.*", "", as.character(datcut[, 5])), "-", 
										 sub("/.*", "", sub("*../*", "", as.character(datcut[, 5]))), 
										 sep = ""))

write.csv(datcut, "Hansen_Permits_2009_2012_forimport.csv")

# inspections data ####
dat <- read.csv("Inspections Violations (Hansen).csv")
datcut <- dat[, c(20, 19, 10, 3, 26)]

# reformat date
datcut[, 4] <- as.Date(as.character(datcut[, 4]), "%m/%d/%Y")
datcut[, 5] <- as.character(datcut[, 5])

write.csv(datcut, "Inspection_Violations_forimport.csv")

