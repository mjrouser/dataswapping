import csv
import pystache
# print pystache.render('Hi {{person}}!', {'person': 'Mom'})

sql_template = '''
------------------------------------------
-- START {{year}} 
DROP TABLE joined.biz_data_{{year}};
CREATE TABLE joined.biz_data_{{year}} AS 
SELECT t.*, c.geoid10
FROM original.biz_data_{{year}} as t
JOIN original.census_2010 as c
ON ST_Contains(c.geom, t.geom);
CREATE INDEX idx_biz_data_{{year}} ON joined.biz_data_{{year}} USING gist (geom);
-- END {{year}} 
------------------------------------------
'''


def generate_sql_code():
	"""
	loop through year ranges, and generate SQL code to load esri business analyst data
	"""
	# open file
	sql = open('/Users/djq/repos/dataswap_tax/join/sql/business_analyst_join.sql', "wb")
	sql.write('--This file is generated dynamically!')
		
	# loop through years
	for year in range(2007, 2012):	
		# import ipdb; ipdb.set_trace()
		# print pystache.render(sql_template, {'year': year})
		sql.write(pystache.render(sql_template, {'year': year}))	
		
	
	sql.close()


generate_sql_code()

