# call this
#source('/Users/djq/repos/analysis/boston/analyze_dataswap.r')

# connect to postgres
library(RPostgreSQL)
library(ggplot2)
library(doBy)
library(reshape2)

# boston
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host="***", user="david", password="***", dbname="analysis", port="5432")
rs <- dbSendQuery(con, "select elev_gl, fy2004, fy2005, fy2006, fy2007, fy2008, fy2009, fy2010, fy2011, fy2012, fy2013, nbhd from building_tax_neighborhood LIMIT 100");                           
df <- fetch(rs, n = -1); dbClearResult(rs) 
dbDisconnect(con) # Close the connection

# reshape the data
df_reshape = melt(df, measure.vars = c('fy2004', 'fy2005', 'fy2006', 'fy2007', 'fy2008', 'fy2009', 'fy2010', 'fy2011', 'fy2012', 'fy2013'))

# make a facet plot
# p <- ggplot(data = df_reshape, aes(x = elev_gl, y = value)) + geom_point() 
# p <- p + facet_grid( variable ~ nbhd) + ylim(1, 2000000) + xlim(1, 100)  

# # # store plot
# ggsave("/Users/djq/Dropbox/dataswap.png", p, height=16, width=12)


# hist

p <- ggplot(data = df_reshape, aes(x = value)) + geom_histogram(binwidth=50000, colour="blue")
p <- p + facet_grid( ~ variable) #+ ylim(1, 2000000) + xlim(1, 100)  

# store plot
ggsave("/Users/djq/Dropbox/dataswap_hist.png", p, height=16, width=12)




# # census block
# drv <- dbDriver("PostgreSQL")
# con <- dbConnect(drv, host="66.228.36.34", user="david", password="sebenta", dbname="analysis", port="5432")
# rs <- dbSendQuery(con, "select elev_gl, fy2013, pop_den, nbhd from building_tax_neighborhood_census_summary_nbhd LIMIT 100");                           
# df <- fetch(rs, n = -1); dbClearResult(rs) 
# dbDisconnect(con) # Close the connection

# # make a facet plot
# p <- ggplot(data = df, aes(x = elev_gl, y = fy2013)) + geom_point(aes(colour=pop_den)) 
# p <- p + facet_wrap( ~ nbhd, ncol = 5, nrow = 8) + ylim(1, 2000000) + xlim(1, 75)  

# # store plot
# ggsave("/Users/djq/Dropbox/elevation_value_popden.png", p, height=16, width=12)


# # non facet plot
# p <- ggplot(data = df, aes(x = elev_gl, y = fy2013)) + geom_point(aes(colour=pop_den)) 
# p <- p + ylim(1, 2000000) + xlim(1, 75)  
# ggsave("/Users/djq/Dropbox/elevation_value_popden_nofacet.png", p, height=6, width=4)