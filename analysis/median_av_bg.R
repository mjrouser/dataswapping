#Program to Calculate the median assessed values by block group and year for R1, R2+R3, and Condos
#Output to CSV for joining with 'MetroBostonBG.shp' shapefile and inputing into PostgreSQL

# Libraries
library(RPostgreSQL)
library(gdata)

#Path 
setwd('/Users/Eyota/Dropbox/dataswap/')

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
		
		#Make sure no zeros or NAs
		stopifnot(df[,paste('fy',yr,'_av',sep = "")] != 0)
		stopifnot(is.na(df[,paste('fy',yr,'_av',sep = "")]) == F)
		
		#Aggregate and save dataframe
		medval = aggregate(df[,paste('fy',yr,'_av',sep = "")],by = list(df$geoid10), FUN = median)
		medval = rename.vars(medval, from = c('Group.1','x'), to = c('GEOID10',paste('av_',yr,sep = '')))
		assign(paste("mv",yr,type,sep = ""),medval)
	}
}

dbDisconnect(con) # Close the connection

#Combine years
#Woot
for(type in c('R1','R23','CD')){
	mv = get(paste('mv2000',type,sep = ''))

	for(yr in 2001:2013){
		toadd = get(paste('mv',yr,type,sep = ''))
		mv = merge(mv, toadd, by = "GEOID10", all = T)
	}
	write.csv(mv, paste('Median Values BG/median_values_bg_',type,'.csv', sep = ''), row.names = F)
}
