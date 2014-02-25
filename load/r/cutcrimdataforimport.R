# subset data from Crime data
setwd("C:/Users/Jackie/Dropbox/Civic Tech/Dataswap/dataswap/Tax Assessor's Database and Auxiliary Data/Open_Gov_Boston")

# Crime reports ####
dat <- read.csv("Crime_Incident_Reports.csv")
datcut <- dat[, c(5, 18:23, 27:28, 34:35)]

library("stringr")
datcut[, 1] <- as.numeric(str_sub(datcut[, 1], 7, 10)) # substring the year
# create dummies for different crime types
datcut$Robbery <- as.numeric(datcut$ROBBERY_TYPE != "")
datcut$Burglary <- as.numeric(datcut$BURGLARY_TIME != "")
datcut$Domestic <- as.numeric(datcut$DOMESTIC == "Yes")
datcut$Weapon <- as.numeric(datcut$WEAPON_TYPE %in% c("Firearm", "Knife", "Other"))
Assault <- vector(length = nrow(datcut))
for (i in 1:nrow(datcut)) {
	Assault[i] <- as.numeric(grepl(datcut$COMPUTEDCRIMECODEDESC[i], "ASSAULT") | 
														 	grepl(datcut$COMPUTEDCRIMECODEDESC[i], "A&B"))
}
datcut$Assault <- Assault

# remove unnecessary variables
datcut <- datcut[, c(1, 8:9, 12:16)]
datcut1 <- datcut[datcut$X > 700000, ]
datcut2 <- datcut[datcut$X < 700000, ]
write.csv(datcut1, "crimedata_forimport1.csv", row.names=F, na = '')
write.csv(datcut2, "crimedata_forimport2.csv", row.names=F, na = '')
