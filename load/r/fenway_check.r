# call this
#source('/Users/djq/repos/analysis/boston/fenway_check.r')

# connect to postgres
library(RPostgreSQL)
library(ggplot2)
library(doBy)

# # boston
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host="***", user="david", password="***", dbname="analysis", port="5432")
rs <- dbSendQuery(con, "select elev_gl, fy2013, pop_den, nbhd from building_tax_neighborhood_census where nbhd='Fenway'");                           
df <- fetch(rs, n = -1); dbClearResult(rs) 
dbDisconnect(con) # Close the connection

# make a facet plot
p <- ggplot(df, aes(x=fy2013)) + geom_histogram(binwidth=1000)
p <- ggplot(df, aes(x=fy2013)) + geom_histogram(binwidth=100000)
#p <- p + facet_wrap( ~ nbhd, ncol = 5, nrow = 8) + ylim(1, 2000000) + xlim(1, 75)  

# store plot
ggsave("/Users/djq/Dropbox/fenway_hist.png", p, height=16, width=12)

