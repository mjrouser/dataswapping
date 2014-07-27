#Program to count fires and fire damage by block group and year (reshape needed)
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
query = dbSendQuery(con, paste("select geoid10, year, med_value from aggregated.r1_tax"))
r1_tax = fetch(query, n = -1); dbClearResult(query)

query = dbSendQuery(con, paste("select geoid10, year, med_value from aggregated.r23_tax"))
r23_tax = fetch(query, n = -1); dbClearResult(query)

query = dbSendQuery(con, paste("select geoid10, year, med_value from aggregated.cd_tax"))
cd_tax = fetch(query, n = -1); dbClearResult(query)

query = dbSendQuery(con, paste("select geoid10, year, mean_salesvol, mean_numberemp, count_firms from aggregated.biz_data"))
biz_data = fetch(query, n = -1); dbClearResult(query)

query = dbSendQuery(con, paste("select geoid10, year, crime_311_count from aggregated.crime_311"))
crime_311 = fetch(query, n = -1); dbClearResult(query)

query = dbSendQuery(con, paste("select geoid10, year, alarm_count, total_loss from aggregated.fires"))
fires = fetch(query, n = -1); dbClearResult(query) 

query = dbSendQuery(con, paste("select geoid10, year, permit_count from aggregated.permits"))
permits = fetch(query, n = -1); dbClearResult(query)

query = dbSendQuery(con, paste("select geoid10, year, violation_count from aggregated.violation_inspections"))
violations = fetch(query, n = -1); dbClearResult(query)

merged = merge(r1_tax,r23_tax, by = c("geoid10","year"), all=T)
merged = rename.vars(merged, from = c('geoid10','year','med_value.x','med_value.y'), to = c('geoid10','year','med_value_R1','med_value_R23'))

merged = merge(merged,cd_tax, by = c("geoid10","year"), all=T)
merged = rename.vars(merged, from = 'med_value', to = 'med-value_CD')

merged = merge(merged,biz_data, by = c("geoid10","year"), all=T)

merged = merge(merged,crime_311, by = c("geoid10","year"), all=T)

merged = merge(merged,permits, by = c("geoid10","year"), all=T)

merged = merge(merged,violations, by = c("geoid10","year"), all=T)

merged[is.na(merged)] <- 0

attach(merged)
merged_sorted <-merged[order(geoid10,year),]
detach(merged)
row.names(merged_sorted) <- NULL

#Save data as .csv
write.csv(merged_sorted, "full_data.csv", row.names = F)

#Write dataframe to Postgres
dbRemoveTable(con, c("aggregated","full_data"))
dbWriteTable(con, c("aggregated","full_data"), value=merged_sorted)
dbDisconnect(con)
                                             