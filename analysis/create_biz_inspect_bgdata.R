###################################
#### Created by : Jackie			 ####
#### Date: February 23, 2014 	 ####
#### Project: Dataswap 				 ####
#### Re: Create BG variables	 ####
###################################

rm(list=ls())

# read all data ####
library("foreign")

# tax data ####
setwd("C:/Users/Jackie/Dropbox/Civic Tech/Dataswap/dataswap/Tax Assessor's Database and Auxiliary Data/dataswap_tax/analysis")
fulldata <- read.csv("full_data.csv")

# acsdata ####
setwd("C:/Users/Jackie/Dropbox/Civic Tech/Dataswap/dataswap/Tax Assessor's Database and Auxiliary Data/ACS_2008_2012")
acsdata <- read.csv("acs0812_bg_suffolk_clean.csv")
names(acsdata)[1] <- c("geoid10")

# business data ####
setwd("C:/Users/Jackie/Dropbox/Civic Tech/Dataswap/dataswap/Tax Assessor's Database and Auxiliary Data/output/data")
esridata07 <- read.csv("biz_data_2007.csv")
esridata08 <- read.csv("biz_data_2008.csv")
esridata09 <- read.csv("biz_data_2009.csv")
esridata10 <- read.csv("biz_data_2010.csv")
esridata11 <- read.csv("biz_data_2011.csv")

crmdata <- read.csv("crime_311.csv")
firesdata <- read.csv("fires.csv")
permitsdata <- read.csv("permits.csv")
inspectdata <- read.csv("inspection_violations.csv")
caddata <- read.csv("crime_911.csv")


# business counts ####
esridata <- c("esridata07", "esridata08", "esridata09", 
							"esridata10", "esridata11")

count_firms <- list()
for (i in 1:length(esridata)) {
	dat <- as.data.frame(do.call(rbind, mget(esridata[i], envir = .GlobalEnv)))
	count_firms[[i]] <- do.call(rbind, 
															as.list(by(dat$sic, 
																				 dat$geoid10, 
																				 length)))
	count_firms[[i]] <- cbind(as.numeric(row.names(count_firms[[i]])), 
														count_firms[[i]], 
														as.numeric(rep(paste("20", 
																					 sub("esridata/*", "", esridata[i]), 
																				 	 sep = ""), 
																			 		length(count_firms[[i]]))))
}
names(count_firms) <- esridata

count_firms_var <- as.data.frame(rbind(count_firms[[1]], 
												 count_firms[[2]], 
												 count_firms[[3]], 
											   count_firms[[4]], 
												 count_firms[[5]]))
colnames(count_firms_var) <- c("geoid10", "count_firms", "year")

# total sales volume ####
esridata <- c("esridata07", "esridata08", "esridata09", 
							"esridata10", "esridata11")

sales_vol <- list()
for (i in 1:length(esridata)) {
	dat <- as.data.frame(do.call(rbind, mget(esridata[i], envir = .GlobalEnv)))
	sales_vol[[i]] <- do.call(rbind, 
															as.list(by(dat$sales_vol, 
																				 dat$geoid10, 
																				 sum, na.rm = T)))
	sales_vol[[i]] <- cbind(as.numeric(row.names(sales_vol[[i]])), 
														sales_vol[[i]], 
														as.numeric(rep(paste("20", 
																					 sub("esridata/*", "", esridata[i]), 
																				 	 sep = ""), 
																			 		length(sales_vol[[i]]))))
}
names(sales_vol) <- esridata

sales_vol_var <- as.data.frame(rbind(sales_vol[[1]], 
												 sales_vol[[2]], 
												 sales_vol[[3]], 
											   sales_vol[[4]], 
												 sales_vol[[5]]))
colnames(sales_vol_var) <- c("geoid10", "sales_vol", "year")


# number of employees ####
esridata <- c("esridata07", "esridata08", "esridata09", 
							"esridata10", "esridata11")

count_empl <- list()
for (i in 1:length(esridata)) {
	dat <- as.data.frame(do.call(rbind, mget(esridata[i], envir = .GlobalEnv)))
	count_empl[[i]] <- do.call(rbind, 
															as.list(by(dat$number_emp, 
																				 dat$geoid10, 
																				 sum, na.rm = T)))
	count_empl[[i]] <- cbind(as.numeric(row.names(count_empl[[i]])), 
														count_empl[[i]], 
														as.numeric(rep(paste("20", 
																					 sub("esridata/*", "", esridata[i]), 
																				 	 sep = ""), 
																			 		length(count_empl[[i]]))))
}
names(count_empl) <- esridata

count_empl_var <- as.data.frame(rbind(count_empl[[1]], 
												 count_empl[[2]], 
												 count_empl[[3]], 
											   count_empl[[4]], 
												 count_empl[[5]]))
colnames(count_empl_var) <- c("geoid10", "count_empl", "year")

# new business counts ####
esridata <- c("esridata07", "esridata08", "esridata09", 
							"esridata10", "esridata11")

count_newfirms <- list()
for (i in 1:length(esridata)) {
	dat <- as.data.frame(do.call(rbind, mget(esridata[i], envir = .GlobalEnv)))
	count_newfirms[[i]] <- do.call(rbind, 
															as.list(by(dat$new[dat$new == "t"], 
																				 dat$geoid10[dat$new == "t"], 
																				 length)))
	count_newfirms[[i]] <- cbind(as.numeric(row.names(count_newfirms[[i]])), 
														count_newfirms[[i]], 
														as.numeric(rep(paste("20", 
																					 sub("esridata/*", "", esridata[i]), 
																				 	 sep = ""), 
																			 		length(count_newfirms[[i]]))))
}
names(count_newfirms) <- esridata

count_newfirms_var <- as.data.frame(rbind(count_newfirms[[1]], 
												 count_newfirms[[2]], 
												 count_newfirms[[3]], 
											   count_newfirms[[4]], 
												 count_newfirms[[5]]))
colnames(count_newfirms_var) <- c("geoid10", "count_newfirms", "year")

# closed businesses ####
esridata <- c("esridata07", "esridata08", "esridata09", 
							"esridata10", "esridata11")

count_closedfirms <- list()
for (i in 1:length(esridata)) {
	dat <- as.data.frame(do.call(rbind, mget(esridata[i], envir = .GlobalEnv)))
	count_closedfirms[[i]] <- do.call(rbind, 
															as.list(by(dat$closed[dat$closed == "t"], 
																				 dat$geoid10[dat$closed == "t"], 
																				 length)))
	count_closedfirms[[i]] <- cbind(as.numeric(row.names(count_closedfirms[[i]])), 
														count_closedfirms[[i]], 
														as.numeric(rep(paste("20", 
																					 sub("esridata/*", "", esridata[i]), 
																				 	 sep = ""), 
																			 		length(count_closedfirms[[i]]))))
}
names(count_closedfirms) <- esridata

count_closedfirms_var <- as.data.frame(rbind(count_closedfirms[[1]], 
												 count_closedfirms[[2]], 
												 count_closedfirms[[3]], 
											   count_closedfirms[[4]], 
												 count_closedfirms[[5]]))
colnames(count_closedfirms_var) <- c("geoid10", "count_closedfirms", "year")

# merge business count variables
newdata <- merge(count_firms_var, sales_vol_var, by = c("geoid10", "year"))
newdata <- merge(newdata, count_empl_var, by = c("geoid10", "year"))
newdata <- merge(newdata, count_newfirms_var, by = c("geoid10", "year"))
newdata <- merge(newdata, count_closedfirms_var, by = c("geoid10", "year"))

setwd("C:/Users/Jackie/Dropbox/Civic Tech/Dataswap/dataswap/Tax Assessor's Database and Auxiliary Data/output/data")
write.csv(newdata, file = "biz_bg_vars.csv", row.names = F, na = '')


# inspection data ####
# create variable categories ####
inspectdata$Maintain <- 
	as.numeric(inspectdata$description %in% 
						 	c("Fail maintain foreclosed prop", 
						 		"Failure clean sidewalk com", 
						 		"Failure clear sidewalk - snow", 
						 		"Failure clear sidewalk - snow:", 
						 		"No Number On A Building", 
						 		"Overgrown Weeds On Property", 
						 		"Removal snow non-res property", 
						 		"Removal snow private prop", 
						 		"Removal snow private property", 
						 		"Site Cleanliness license - VIO", 
						 		"Site Cleanliness license - WAR"))
inspectdata$Trash <- 
	as.numeric(inspectdata$description %in% 
						 	c("disposal med waste", 
						 		"Illegal dumping  vehicle:", 
						 		"Illegal Dumping (vehicle)", 
						 		"Illegal dumping < 1 cubic yd", 
						 		"Illegal dumping 1-5 cubic yd.:", 
						 		"Illegal dumping 1-5 cuyd.", 
						 		"Illegal dumping 5 cubic yd.", 
						 		"Illegal dumping 5+ cubic yd", 
						 		"Illegal dumping Const debris", 
						 		"Illegal dumping park", 
						 		"Illegal dumping solid waste", 
						 		"Illegal dumping w a vehicle", 
						 		"Illegal dumping: Haz Waste", 
						 		"Improper storage of trash outs", 
						 		"Improper storage trash: com", 
						 		"Improper storage trash: res", 
						 		"Large building recycling- 1", 
						 		"Large building recycling - 2", 
						 		"Littering", 
						 		"Littering From A Vehicle", 
						 		"Over 1 cubic yd. of debris", 
						 		"Overfilling of barrel", 
						 		"Overfilling of barrels or dump", 
						 		"Trash illegally dump container"))

# years for inspection data ####
library("stringr")
inspectdata$year <- str_sub(inspectdata$violationdate, 1, 4)

# total counts
years <- c(2007:2012)
count_inspect <- list()
for (i in 1:length(years)){
	dat <- inspectdata[inspectdata$year == years[i], ]
	count_inspect[[i]] <- do.call(rbind, 
													 as.list(by(dat$addressid, 
											dat$geoid10, 
											length)))
	count_inspect[[i]] <- cbind(as.numeric(row.names(count_inspect[[i]])), 
														count_inspect[[i]], 
														as.numeric(rep(years[i], 
																			 		length(count_inspect[[i]]))))
}
names(count_inspect) <- years

count_inspect_var <- as.data.frame(rbind(count_inspect[[1]], 
												 count_inspect[[2]], 
												 count_inspect[[3]], 
											   count_inspect[[4]], 
												 count_inspect[[5]], 
												 count_inspect[[6]]))
colnames(count_inspect_var) <- c("geoid10", "count_inspect", "year")

# total trash counts ####
years <- c(2007:2012)
count_inspecttrash <- list()
for (i in 1:length(years)){
	dat <- inspectdata[inspectdata$year == years[i], ]
	count_inspecttrash[[i]] <- do.call(rbind, 
													 as.list(by(dat$Trash, 
											dat$geoid10, 
											sum)))
	count_inspecttrash[[i]] <- cbind(as.numeric(row.names(count_inspecttrash[[i]])), 
														count_inspecttrash[[i]], 
														as.numeric(rep(years[i], 
																			 		length(count_inspecttrash[[i]]))))
}
names(count_inspecttrash) <- years

count_inspecttrash_var <- as.data.frame(rbind(count_inspecttrash[[1]], 
												 count_inspecttrash[[2]], 
												 count_inspecttrash[[3]], 
											   count_inspecttrash[[4]], 
												 count_inspecttrash[[5]], 
												 count_inspecttrash[[6]]))
colnames(count_inspecttrash_var) <- c("geoid10", "count_inspecttrash", "year")

library("stringr")
inspectdata$year <- str_sub(inspectdata$violationdate, 1, 4)

# total Maintain
years <- c(2007:2012)
count_inspectmaintain <- list()
for (i in 1:length(years)){
	dat <- inspectdata[inspectdata$year == years[i], ]
	count_inspectmaintain[[i]] <- do.call(rbind, 
													 as.list(by(dat$Maintain, 
											dat$geoid10, 
											sum)))
	count_inspectmaintain[[i]] <- cbind(as.numeric(row.names(count_inspectmaintain[[i]])), 
														count_inspectmaintain[[i]], 
														as.numeric(rep(years[i], 
																			 		length(count_inspectmaintain[[i]]))))
}
names(count_inspectmaintain) <- years

count_inspectmaintain_var <- as.data.frame(rbind(count_inspectmaintain[[1]], 
												 count_inspectmaintain[[2]], 
												 count_inspectmaintain[[3]], 
											   count_inspectmaintain[[4]], 
												 count_inspectmaintain[[5]], 
												 count_inspectmaintain[[6]]))
colnames(count_inspectmaintain_var) <- c("geoid10", "count_inspectmaintain", "year")

# merge inspection count variables
newdata <- merge(count_inspect_var, count_inspecttrash_var, by = c("geoid10", "year"))
newdata <- merge(newdata, count_inspectmaintain_var, by = c("geoid10", "year"))

setwd("C:/Users/Jackie/Dropbox/Civic Tech/Dataswap/dataswap/Tax Assessor's Database and Auxiliary Data/output/data")
write.csv(newdata, file = "inspect_bg_vars.csv", row.names = F, na = '')


# crime data ####
setwd("C:/Users/Jackie/Dropbox/Civic Tech/Dataswap/dataswap/Tax Assessor's Database and Auxiliary Data/output/data")
crimedata1 <- read.csv("crime_1.csv")
crimedata2 <- read.csv("crime_2.csv")
# geoids file duplicated each observation, 
# so counts are divided by 2

# merge crime data ####
crimedata <- as.data.frame(rbind(crimedata1, crimedata2))
years <- unique(crimedata$fromdate)

# crime counts ####
count_crime <- list()
for (i in 1:length(years)) {
	dat <- crimedata[crimedata$fromdate %in% years[i], ]
	count_crime[[i]] <- do.call(rbind, 
															as.list(by(dat$fromdate, 
																				 dat$geoid10, 
																				 length)))
	count_crime[[i]] <- cbind(as.numeric(row.names(count_crime[[i]])), 
														count_crime[[i]]/2, 
														as.numeric(rep(years[i],
																			 		length(count_crime[[i]]))))
}
names(count_crime) <- years

count_crime_var <- as.data.frame(rbind(count_crime[[1]], 
												 count_crime[[2]], 
												 count_crime[[3]], 
											   count_crime[[4]]))
colnames(count_crime_var) <- c("geoid10", "count_crime", "year")

# total robberies ####
count_robbery <- list()
for (i in 1:length(years)) {
	dat <- crimedata[crimedata$fromdate %in% years[i] &
									 	crimedata$robbery == 1, ]
	count_robbery[[i]] <- do.call(rbind, 
															as.list(by(dat$fromdate, 
																				 dat$geoid10, 
																				 length)))
	count_robbery[[i]] <- cbind(as.numeric(row.names(count_robbery[[i]])), 
														count_robbery[[i]]/2, 
														as.numeric(rep(years[i],
																			 		length(count_robbery[[i]]))))
}
names(count_robbery) <- years

count_robbery_var <- as.data.frame(rbind(count_robbery[[1]], 
												 count_robbery[[2]], 
												 count_robbery[[3]], 
											   count_robbery[[4]]))
colnames(count_robbery_var) <- c("geoid10", "count_robbery", "year")

# total burglaries ####
count_burglary <- list()
for (i in 1:length(years)) {
	dat <- crimedata[crimedata$fromdate %in% years[i] &
									 	crimedata$burglary == 1, ]
	count_burglary[[i]] <- do.call(rbind, 
															as.list(by(dat$fromdate, 
																				 dat$geoid10, 
																				 length)))
	count_burglary[[i]] <- cbind(as.numeric(row.names(count_burglary[[i]])), 
														count_burglary[[i]]/2, 
														as.numeric(rep(years[i],
																			 		length(count_burglary[[i]]))))
}
names(count_burglary) <- years

count_burglary_var <- as.data.frame(rbind(count_burglary[[1]], 
												 count_burglary[[2]], 
												 count_burglary[[3]], 
											   count_burglary[[4]]))
colnames(count_burglary_var) <- c("geoid10", "count_burglary", "year")

# total domestic crimes ####
count_domestic <- list()
for (i in 1:length(years)) {
	dat <- crimedata[crimedata$fromdate %in% years[i] &
									 	crimedata$domestic == 1, ]
	count_domestic[[i]] <- do.call(rbind, 
															as.list(by(dat$fromdate, 
																				 dat$geoid10, 
																				 length)))
	count_domestic[[i]] <- cbind(as.numeric(row.names(count_domestic[[i]])), 
														count_domestic[[i]]/2, 
														as.numeric(rep(years[i],
																			 		length(count_domestic[[i]]))))
}
names(count_domestic) <- years

count_domestic_var <- as.data.frame(rbind(count_domestic[[1]], 
												 count_domestic[[2]], 
												 count_domestic[[3]], 
											   count_domestic[[4]]))
colnames(count_domestic_var) <- c("geoid10", "count_domestic", "year")

# total weapon crimes ####
count_weapon <- list()
for (i in 1:length(years)) {
	dat <- crimedata[crimedata$fromdate %in% years[i] &
									 	crimedata$weapon == 1, ]
	count_weapon[[i]] <- do.call(rbind, 
															as.list(by(dat$fromdate, 
																				 dat$geoid10, 
																				 length)))
	count_weapon[[i]] <- cbind(as.numeric(row.names(count_weapon[[i]])), 
														count_weapon[[i]]/2, 
														as.numeric(rep(years[i],
																			 		length(count_weapon[[i]]))))
}
names(count_weapon) <- years

count_weapon_var <- as.data.frame(rbind(count_weapon[[1]], 
												 count_weapon[[2]], 
												 count_weapon[[3]], 
											   count_weapon[[4]]))
colnames(count_weapon_var) <- c("geoid10", "count_weapon", "year")

# total assault crimes ####
# assault variable is currently incorrect in file ####
# fixed in import data files but not corrected for the geoid'd files ####
count_assault <- list()
for (i in 1:length(years)) {
	dat <- crimedata[crimedata$fromdate %in% years[i] &
									 	crimedata$assault == 1, ]
	count_assault[[i]] <- do.call(rbind, 
															as.list(by(dat$fromdate, 
																				 dat$geoid10, 
																				 length)))
	count_assault[[i]] <- cbind(as.numeric(row.names(count_assault[[i]])), 
														count_assault[[i]]/2, 
														as.numeric(rep(years[i],
																			 		length(count_assault[[i]]))))
}
names(count_assault) <- years

count_assault_var <- as.data.frame(rbind(count_assault[[1]], 
												 count_assault[[2]], 
												 count_assault[[3]], 
											   count_assault[[4]]))
colnames(count_assault_var) <- c("geoid10", "count_assault", "year")

# merge crime count variables
newdata <- merge(count_crime_var, count_robbery_var, by = c("geoid10", "year"))
newdata <- merge(newdata, count_burglary_var, by = c("geoid10", "year"))
newdata <- merge(newdata, count_domestic_var, by = c("geoid10", "year"))
newdata <- merge(newdata, count_weapon_var, by = c("geoid10", "year"))
newdata <- merge(newdata, count_assault_var, by = c("geoid10", "year"))

setwd("C:/Users/Jackie/Dropbox/Civic Tech/Dataswap/dataswap/Tax Assessor's Database and Auxiliary Data/output/data")
write.csv(newdata, file = "crime_bg_vars.csv", row.names = F, na = '')

