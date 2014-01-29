dataswap_tax
============
code to analyze Boston's tax assessor data


connect to database
-------------------

Using QGIS, R or PgAdmin

R
---

```
# connect to postgres
library(RPostgreSQL)


# boston
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host="***", user="dataswap", password="***", dbname="analysis", port="5432")
rs <- dbSendQuery(con, "
	select * from 
	building_tax_neighborhood 
	LIMIT 100
");                           
df <- fetch(rs, n = -1); dbClearResult(rs) 
dbDisconnect(con) # Close the connection
```


Info
-------------------

Everything is projected in 
Mass State Plane - meters
SRID = 26986





