library("foreign")

dat <- read.dta("C:/Users/Jackie/Documents/GitHub/dataswap_tax/analysis/full_data_factors.dta")
dat[, 1] <- as.character(dat[, 1])

setwd("C:/Users/Jackie/Dropbox/Civic Tech/Dataswap/dataswap/Tax Assessor's Database and Auxiliary Data/ACS_2008_2012")
acsdata <- read.csv("acs0812_bg_suffolk_clean.csv")
names(acsdata)[1] <- c("geoid10")
acsdata[, 1] <- as.character(acsdata[, 1])

# median values ####
setwd("C:/Users/Jackie/Dropbox/Civic Tech/Dataswap/dataswap/Tax Assessor's Database and Auxiliary Data/Median Values BG")
values <- read.csv("median_values_bg_R1.csv")
names(values)[1] <- c("geoid10")
values[, 1] <- as.character(values[, 1])

# merge data ####
fulldata <- merge(dat, acsdata, by = "geoid10", all.x = T)
fulldata <- merge(fulldata, values, by = "geoid10", all.x = T)

# save data with all variables ####
setwd("C:/Users/Jackie/Dropbox/Civic Tech/Dataswap/dataswap/Tax Assessor's Database and Auxiliary Data/output/data")
write.csv(fulldata, "full_data_valuesacsfactors.csv", row.names = FALSE, na = '')

# keep only variables needed ####
finaldata <- fulldata[, c(1, 63:76, 30:34, 38:41, 46, 52:55, 58:59, 60:62)]
setwd("C:/Users/Jackie/Dropbox/Civic Tech/Dataswap/dataswap/Tax Assessor's Database and Auxiliary Data/output/data")
write.csv(finaldata, "final_data.csv", row.names = FALSE, na = '')
write.csv(finaldata[1:5, ], "final_data_head.csv", row.names = FALSE, na = '')
