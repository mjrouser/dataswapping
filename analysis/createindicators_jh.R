###################################
#### Created by : Jackie			 ####
#### Date: February 23, 2014 	 ####
#### Project: Dataswap 				 ####
#### Re: Create indicators 		 ####
###################################

rm(list=ls())

# read all data ####
library("foreign")

# tax data ####
setwd("C:/Users/Jackie/Dropbox/Civic Tech/Dataswap/dataswap/Tax Assessor's Database and Auxiliary Data/output/data")
fulldata <- read.csv("full_data.csv")


# acsdata ####
setwd("C:/Users/Jackie/Dropbox/Civic Tech/Dataswap/dataswap/Tax Assessor's Database and Auxiliary Data/ACS_2008_2012")
acsdata <- read.csv("acs0812_bg_suffolk_clean.csv")
names(acsdata)[1] <- c("geoid10")

# merge acs data
fulldata <- merge(fulldata, acsdata, by = "geoid10", all.x = TRUE)

setwd("C:/Users/Jackie/Dropbox/Civic Tech/Dataswap/dataswap/Tax Assessor's Database and Auxiliary Data/output/data")
write.csv(fulldata, "full_data_super.csv")

dispc <- prcomp(cbind(na.omit(fulldata[, 11:16])))

# exploratory factor analysis ####
dat <- fulldata[fulldata$year == 2011, c(6:25, 27:34, 39:40, 42:43, 46:50)]
dat <- dat[is.na(dat$popu) == FALSE, ]  
dat <- dat[dat$popu > 0, ]
fit <- princomp(~., dat, na.action = na.omit)
summary(fit)
loadings(fit)


bdat <- dat[, c(4:5)]
bdat2 <- as.data.frame(scale(busibdata))
fit <- princomp(~., bdat, na.action = na.omit)
loadings(fit)

