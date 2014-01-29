drop table original.crime_311;
create table original.crime_311 (
	computercrimecode character varying(10), 
	weapontype character varying(10),
	fromdate date,
	x numeric, 
	y numeric
);

-- copy data from CSV
\COPY original.crime_311 FROM '/Volumes/SaoirseMor/Dropbox/dataswap/Open_Gov_Boston/Crime_Incident_Reports.csv' WITH CSV HEADER DELIMITER AS ',';

-- add points
ALTER TABLE original.crime_311 ADD COLUMN geom geometry(POINT, 26986);
UPDATE original.crime_311 SET geom = ST_SetSRID(ST_MakePoint(x,y),26986);
CREATE INDEX idx_crime_311 ON original.crime_311 USING GIST ( geom );