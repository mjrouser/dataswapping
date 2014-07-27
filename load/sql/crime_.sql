drop table original.crime_;
create table original.crime_ (
	computercrimecode character varying(10), 
	weapontype character varying(10),
	fromdate date,
	x numeric, 
	y numeric
);

-- copy data from CSV
\COPY original.crime_ FROM '/Volumes/SaoirseMor/Dropbox/dataswap/Open_Gov_Boston/Crime_Incident_Reports.csv' WITH CSV HEADER DELIMITER AS ',';

-- add points
ALTER TABLE original.crime_ ADD COLUMN geom geometry(POINT, 26986);
UPDATE original.crime_ SET geom = ST_SetSRID(ST_MakePoint(x,y),26986);
CREATE INDEX idx_crime_ ON original.crime_311 USING GIST ( geom );