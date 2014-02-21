#Program to count crime 311 calls by block group and year (reshape needed)
#Output to CSV for joining with 'MetroBostonBG.shp' shapefile and inputing into PostgreSQL

# Libraries
library(RPostgreSQL)
library(gdata)

#Path 
setwd('/home/tom/dataswap_tax/analysis')

# Connect to database
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host="66.228.36.34",user='dataswap',password = 'taxtaxtax',dbname="dataswap", port="5432")

#Get variables by year
query = dbSendQuery(con, paste("select geoid10, opendate, type from joined.crime_311"))
df = fetch(query, n = -1); dbClearResult(query)
df$year <- substr(df[,2], 1,4) #creating a 'year' variable for aggregation

#Aggregate and save dataframe
countval = aggregate(df$type, by = list(df$geoid10, df$year), FUN = length)
countval = rename.vars(countval, from = c('Group.1','Group.2','x'), to = c('GEOID10','year','311call_count'))

attach(countval)
countval_sorted <-countval[order(GEOID10,year),]
detach(countval)
row.names(countval_sorted) <- NULL

#Save data as .csv
write.csv(countval_sorted, "311_count.csv", row.names = F)

#Write dataframe to Postgres
dbRemoveTable(con, c("aggregated","crime_311"))
dbWriteTable(con, c("aggregated","crime_311"), value=countval_sorted)
dbDisconnect(con)