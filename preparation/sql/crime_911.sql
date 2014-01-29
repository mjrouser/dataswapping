-- make/drop table
-- run commands in psql or similar
drop table crime_911;
create table crime_911 (
	x numeric,
	y numeric, 
	type character varying(10), 
	priority integer, 
	closedate date, 
	disorder  integer,
	medemerg integer,
	violent integer
);

-- copy data from CSV
\COPY crime_911 FROM '/Volumes/SaoirseMor/Dropbox/dataswap/BostonBlightBuilding/CAD_Final_911Reports_forimport.csv' WITH CSV HEADER DELIMITER AS ',';

-- create spatial col
-- is this feet or meter?
-- --2894 = ft; 26986 = m
SELECT AddGeometryColumn('public', 'crime_911', 'geom', 26986, 'POINT', 2); 
UPDATE crime_911 set geom = ST_Transform(ST_SetSRID(ST_MakePoint(x, y), 2894), 26986);
CREATE INDEX idx_nineoneone ON crime_911 USING GIST ( geom );
