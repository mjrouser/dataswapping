-- make/drop table
-- run commands in psql or similar
drop table original.crime;
create table original.crime (
	fromdate integer,
	x numeric,
	y numeric,
	robbery integer,
	burglary integer,
	domestic integer,
	weapon  integer,
	assault integer
);

-- copy data from CSV
\COPY original.crime FROM '/Volumes/SaoirseMor/Dropbox/dataswap/Open_Gov_Boston/crimedata_forimport1.csv' WITH CSV HEADER DELIMITER AS ',';

-- create spatial col
-- is this feet or meter?
-- --2894 = ft; 26986 = m
SELECT AddGeometryColumn('original', 'crime', 'geom', 26986, 'POINT', 2); 
UPDATE original.crime set geom = ST_Transform(ST_SetSRID(ST_MakePoint(x, y), 2894), 26986);
CREATE INDEX idx_crime ON original.crime USING GIST ( geom );

-- OTHER PROJECT
drop table original.crime2;
create table original.crime2 (
	fromdate integer,
	x numeric,
	y numeric,
	robbery integer,
	burglary integer,
	domestic integer,
	weapon  integer,
	assault integer
);

-- copy data from CSV
\COPY original.crime2 FROM '/Volumes/SaoirseMor/Dropbox/dataswap/Open_Gov_Boston/crimedata_forimport2.csv' WITH CSV HEADER DELIMITER AS ',';

-- create spatial col
-- is this feet or meter?
-- --2894 = ft; 26986 = m
SELECT AddGeometryColumn('original', 'crime2', 'geom', 26986, 'POINT', 2); 
UPDATE original.crime2 set geom = ST_SetSRID(ST_MakePoint(x, y), 26986);
CREATE INDEX idx_crime2 ON original.crime2 USING GIST ( geom );
