# make/drop table
# psql
drop table nineoneone;
create table nineoneone (
	x numeric,
	y numeric, 
	type character varying(10), 
	priority integer, 
	closedate date, 
	disorder  integer,
	medemerg integer,
	violent integer
);

# copy data from CSV
\COPY nineoneone FROM '/Volumes/SaoirseMor/Dropbox/dataswap/BostonBlightBuilding/CAD_Final_911Reports_forimport.csv' WITH CSV HEADER DELIMITER AS ',';

# create spatial col
SELECT AddGeometryColumn('public', 'nineoneone', 'geom', 2894, 'POINT', 2); --2894 = ft; 26986 = m
UPDATE nineoneone set geom = ST_SetSRID(ST_MakePoint(x, y), 2894);
CREATE INDEX idx_nineoneone ON nineoneone USING GIST ( geom );

-- grant permissions to all users 
GRANT ALL ON ALL TABLES IN SCHEMA public to dataswap;

--make small sample to check ok and overlay on map
drop table nineoneone_temp;
create table nineoneone_temp as 
select x, y, ST_Transform(geom, 26986) 
from nineoneone limit 10;
