#Program to count inspection violations data by block group and year (reshape needed)
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
query = dbSendQuery(con, paste("select geoid10, alm_date, alm_type, total_loss from joined.fires"))
df = fetch(query, n = -1); dbClearResult(query)
df$year <- substr(df[,2], 1,4) #creating a 'year' variable for aggregation

#Aggregate and save dataframe
countval = aggregate(df$alm_type, by = list(df$geoid10, df$year), FUN = length)
countval = rename.vars(countval, from = c('Group.1','Group.2','x'), to = c('GEOID10','year','alarm_count'))
totalloss = aggregate(df$total_loss, by = list(df$geoid10, df$year), FUN = sum)
totalloss = rename.vars(totalloss, from = c('Group.1','Group.2','x'), to = c('GEOID10','year','total_loss'))

merged = merge(countval, totalloss, by = c("GEOID10","year"))

attach(merged)
merged_sorted <-merged[order(GEOID10,year),]
detach(merged)
row.names(merged_sorted) <- NULL

#Save data as .csv
write.csv(merged_sorted, "fires_count.csv", row.names = F)

#Write dataframe to Postgres
dbRemoveTable(con, c("aggregated","fires"))
dbWriteTable(con, c("aggregated","fires"), value=merged_sorted)
dbDisconnect(con)