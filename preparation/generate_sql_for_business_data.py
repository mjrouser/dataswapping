import csv
import pystache
# print pystache.render('Hi {{person}}!', {'person': 'Mom'})

sql_template = '''
------------------------------------------
-- START {{year}} {{year}} {{year}} {{year}}
-- create table
drop table biz_data_{{year}};
create table biz_data_{{year}} (
	sic character varying(10),
	naics_ext character varying(10),
	sales_vol numeric,
	number_emp numeric,
	x numeric,
	y numeric,
	new boolean,
	closed boolean
);

-- copy data from CSV
\COPY biz_data_{{year}} FROM '/Volumes/SaoirseMor/Dropbox/dataswap/ESRI_Business_Analyst/ba_boston_forimport_{{year}}.csv' WITH CSV HEADER DELIMITER AS ',';

-- add points
ALTER TABLE biz_data_{{year}} ADD COLUMN geom geometry(POINT, 26986);
UPDATE biz_data_{{year}} SET geom = ST_Transform(ST_SetSRID(ST_MakePoint(x,y),4326), 26986);

-- END {{year}} {{year}} {{year}} {{year}}
------------------------------------------
'''


def generate_sql_code():
	"""
	loop through year ranges, and generate SQL code to load esri business analyst data
	"""
	# open file
	sql = open('/Users/djq/repos/dataswap_tax/preparation/load_business_analyst.sql', "wb")
		
	# loop through years
	for year in range(2007, 2012):	
		# import ipdb; ipdb.set_trace()
		# print pystache.render(sql_template, {'year': year})
		sql.write(pystache.render(sql_template, {'year': year}))	
		
	
	sql.close()


generate_sql_code()

