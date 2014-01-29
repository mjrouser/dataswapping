# call this
#source('/Users/djq/repos/analysis/boston/analyze.r')

# connect to postgres
library(RPostgreSQL)
library(ggplot2)
library(doBy)

# # boston
# drv <- dbDriver("PostgreSQL")
# con <- dbConnect(drv, host="66.228.36.34", user="david", password="sebenta", dbname="analysis", port="5432")
# rs <- dbSendQuery(con, "select elev_gl, fy2013, nbhd from building_tax_neighborhood");                           
# df <- fetch(rs, n = -1); dbClearResult(rs) 
# dbDisconnect(con) # Close the connection

# # make a facet plot
# p <- ggplot(data = df, aes(x = elev_gl, y = fy2013)) + geom_point(aes(nbhd)) 
# p <- p + facet_wrap( ~ nbhd, ncol = 5, nrow = 8) + ylim(1, 2000000) + xlim(1, 100)  

# # store plot
# ggsave("/Users/djq/Dropbox/elevation_value.png", p, height=16, width=12)


# census block
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host="66.228.36.34", user="david", password="sebenta", dbname="analysis", port="5432")
rs <- dbSendQuery(con, "select elev_gl, fy2013, pop_den, nbhd from building_tax_neighborhood_census_summary_nbhd");                           
df <- fetch(rs, n = -1); dbClearResult(rs) 
dbDisconnect(con) # Close the connection

# make a facet plot
p <- ggplot(data = df, aes(x = elev_gl, y = fy2013)) + geom_point(aes(colour=pop_den)) 
p <- p + facet_wrap( ~ nbhd, ncol = 5, nrow = 8) + ylim(1, 2000000) + xlim(1, 75)  

# store plot
ggsave("/Users/djq/Dropbox/elevation_value_popden.png", p, height=16, width=12)


# non facet plot
p <- ggplot(data = df, aes(x = elev_gl, y = fy2013)) + geom_point(aes(colour=pop_den)) 
p <- p + ylim(1, 2000000) + xlim(1, 75)  
ggsave("/Users/djq/Dropbox/elevation_value_popden_nofacet.png", p, height=6, width=4)