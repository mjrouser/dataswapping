#Program to Calculate the median assessed values by block group and year for R1, R2+R3, and Condos
#Output to CSV for joining with 'MetroBostonBG.shp' shapefile and inputing into PostgreSQL

# Libraries
library(RPostgreSQL)
library(gdata)

#Path 
setwd('/home/tom/dataswap_tax/analysis')

# Connect to database
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host="66.228.36.34",user='dataswap',password = 'taxtaxtax',dbname="dataswap", port="5432")

#Get R1s, R2-3s, and Condos by year

for(yr in 2000:2013){
	for(type in c('R1','R23','CD')){
		if(type == "R23"){
			qstring = paste("'R2' or fy",yr,"_lu = 'R3'",sep = "")
		}
		else{
			qstring = paste("'",type,"'",sep = "")
		}
		query = dbSendQuery(con, paste("select fy",yr,'_lu, fy',yr,'_av, geoid10 from joined.tax where fy',yr,'_lu = ',qstring, sep = ""))
		df = fetch(query, n = -1); dbClearResult(query)
		
		#Aggregate and save dataframe
		medval = aggregate(df[,paste('fy',yr,'_av',sep = "")],by = list(df$geoid10), FUN = median)
		medval = rename.vars(medval, from = c('Group.1','x'), to = c('GEOID10',paste('av_',yr,sep = '')))
		assign(paste("mv",yr,type,sep = ""),medval)
	}
}

#Combine years
for(type in c('R1','R23','CD')){
	mv = get(paste('mv2000',type,sep = ''))

	for(yr in 2001:2013){
		toadd = get(paste('mv',yr,type,sep = ''))
		mv = merge(mv, toadd, by = "GEOID10", all = T)
		mv[is.na(mv)] <- 0
	}
  #Reshape to long
	mvlong <-reshape(mv, 
	                 idvar = "GEOID10", 
	                 varying = list(
	                   c("av_2000", "av_2001", "av_2002", "av_2003", "av_2004", "av_2005","av_2006","av_2007","av_2008","av_2009","av_2010","av_2011","av_2012","av_2013")),
	                 v.names = "med_value",
	                 times = c(2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013),
	                 timevar = "year",
	                 direction = "long")
	attach(mvlong)
	mvlong_sorted <-mvlong[order(GEOID10,year),]
	detach(mvlong)
	row.names(mvlong_sorted) <- NULL
  
  #Save as .csv
  write.csv(mvlong_sorted, paste('median_values_bg_',type,'.csv', sep = ''), row.names = F)
  
}



