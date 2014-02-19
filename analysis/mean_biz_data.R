#Program to calculate the mean sales volume and number of employees by block group and year
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
for(yr in 2007:2011){
    query = dbSendQuery(con, paste("select sic, geoid10, sales_vol, number_emp from joined.biz_data_",yr, sep=""))
    df = fetch(query, n = -1); dbClearResult(query)
    
    #Aggregate and save dataframe
    meanval = aggregate(df [c("sales_vol","number_emp")], by = list(df$geoid10), FUN = mean)
    meanval = rename.vars(meanval, from = c("Group.1", "sales_vol","number_emp"), to = c('GEOID10',paste('sales_vol_',yr,sep=''),paste('number_emp_',yr,sep='')))
    countval = aggregate(df ["sic"], by = list(df$geoid10), FUN = length)
    countval = rename.vars(countval, from = c('Group.1','sic'), to = c('GEOID10', paste('sic_',yr,sep='')))
    merged = merge(meanval, countval, by = "GEOID10")
    assign(paste("biz",yr,sep = ""),merged)
 }

dbDisconnect(con) # Close the connection

#Combine years, inner join only, replace NAs with 0s (won't upload to PostgreSQL otherwise)
mv = get('biz2007')
for(yr in 2008:2011){
  toadd = get(paste('biz',yr,sep=''))
    mv = merge(mv, toadd, by = "GEOID10")
    mv[is.na(mv)] <- 0
    }

#Reshape dataframe to long format by GEOID10 and year
mvlong <-reshape(mv, 
             idvar = "GEOID10", 
             varying = list(
               c("sales_vol_2007", "sales_vol_2008", "sales_vol_2009", "sales_vol_2010", "sales_vol_2011"),
               c("number_emp_2007", "number_emp_2008", "number_emp_2009", "number_emp_2010", "number_emp_2011"),
               c("sic_2007", "sic_2008", "sic_2009", "sic_2010", "sic_2011")),
                v.names = c("mean_salesvol", "mean_numberemp", "count_firms"),
             times = c(2007, 2008, 2009, 2010, 2011),
             timevar = "year",
             direction = "long") 
            
      attach(mvlong)
      mvlong_sorted <-mvlong[order(GEOID10,year),]
      detach(mvlong)
      row.names(mvlong_sorted) <- NULL
      
#Save data as .csv
write.csv(mvlong_sorted, "mean_values_biz.csv", row.names = F)

#Write dataframe to Postgres
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host="66.228.36.34",user='dataswap',password = 'taxtaxtax',dbname="dataswap", port="5432")
    dbRemoveTable(con, c("aggregated","biz_data"))
    dbWriteTable(con, c("aggregated","biz_data"), value=mvlong_sorted)
dbDisconnect(con)

