#Program to bring in CRM 911 Data and calculate statistics by block group. 
#All 2011

setwd('Dropbox/dataswap/')

library(gdata)

aggplus = function(data,aggvar, byvar,fun ) {
	retval = aggregate(data[,aggvar],list(data[,byvar]), FUN = fun)
	retval = rename.vars(retval, from = c("Group.1",'x'), to = c(byvar,aggvar))
}

crm = read.csv('output/data/crime_911.csv')
crm$total = 1

#Remove Records from Jan 1 2012
crm = crm[as.character(crm$closedate) != '2012-01-01',]


total = aggplus(crm,'total','geoid10',sum)
disorder = aggplus(crm, 'disorder','geoid10',sum)
violent = aggplus(crm, 'violent','geoid10',sum)


output = merge(total,disorder, by = "geoid10", all = T)
output = merge(output, violent, by = "geoid10", all = T)
output[is.na(output)] = 0
output$year = 2011

write.csv(output,'output/data/bg_crm_911.csv', row.names = F)