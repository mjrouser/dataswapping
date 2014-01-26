# subset data from Boston Blight and Building Data for necessary variables

setwd("C:/Users/Jackie/Dropbox/Dataswap/Tax Assessor's Database and Auxiliary Data/Boston Blight and Building Data")

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


write.csv(datcut, "CAD_Final_911Reports_forimport.csv")

# CRM (311) data ####
rm(list=ls())

dat <- read.csv("CRM Final.csv")
datcut <- dat[, c(8:9, 21:22, 3, 5, 6, 7, 16, 18, 31:38)]
names(datcut) <- c("X", "Y", "X_alt", "Y_alt", "opendate", "subject", "reason", "type", "channel", "source", "Unciviluse", "Housing", "BigBuild", "Graffiti", "Trash", "PrivateNeglect", "Problem", "PublicDenig")

datcut[, 5] <- as.Date(as.character(datcut[, 5]), "%m/%d/%Y") # reformat date
datcut[, 6] <- as.character(datcut[, 6])
datcut[, 7] <- as.character(datcut[, 7])
datcut[, 8] <- as.character(datcut[, 8])
datcut[, 9] <- as.character(datcut[, 9])
datcut[, 10] <- as.character(datcut[, 10])

write.csv(datcut, "CRM_Final_forimport.csv")

# fires data ####
rm(list=ls())

dat <- read.csv("Fires Final.csv")
datcut <- dat[, c(7:8, 14, 20, 22:23, 35)]

datcut[, 3] <- as.Date(as.character(datcut[, 3]), "%m/%d/%Y") # reformat date
datcut[, 6] <- as.character(datcut[, 6])

write.csv(datcut, "Fires_Final_forimport.csv")

# permits data ####

# inspections data ####

# acs 2008-2012 data ###