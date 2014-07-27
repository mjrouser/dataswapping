#Program to bring in CRM 311 Data and calculate statistics by block group. 
#All 2011

setwd('Dropbox/dataswap/')

library(gdata)

aggplus = function(data,aggvar, byvar,fun ) {
	retval = aggregate(data[,aggvar],list(data[,byvar]), FUN = fun)
	retval = rename.vars(retval, from = c("Group.1",'x'), to = c(byvar,aggvar))
}

crm = read.csv('output/data/crime_311.csv')
crm$total = 1
crm$nonemp = crm$source %in% c('Citizens Connect App','Constituent Call','Maximo Integration','Self Service')

total = aggplus(crm,'total','geoid10',sum)
problem = aggplus(crm, 'problem','geoid10',sum)
nonemp = aggplus(crm, 'nonemp','geoid10',sum)

"""
Oops originally broke down int each of the categories; we just want the total
Keeping this just in case

breakdown = aggregate(crm$total, list(crm$geoid10,crm$source),FUN = sum)
bd = reshape(breakdown, idvar = 'Group.1', timevar = 'Group.2', direction = 'wide')
bd = rename.vars(bd, from = c('Group.1','x.','x.Citizens Connect App','x.City Worker App','x.Constituent Call','x.Employee Generated','x.Maximo Integration','x.Self Service'), to = c('geoid10','other_source','cit_connect','city_worker','const_call','employee','maximo','self_service'))
"""

output = merge(total,problem, by = "geoid10", all = T)
output = merge(output, nonemp, by = "geoid10", all = T)
output[is.na(output)] = 0
output$year = 2011

write.csv(output,'output/data/bg_crm_311.csv', row.names = F)