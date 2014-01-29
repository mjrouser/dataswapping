drop table crime_data;
create table crime_data (
	computercrimecode character varying(10), 
	weapontype character varying(10),
	fromdate date,
	x numeric, 
	y numeric
);

-- copy data from CSV
\COPY acs_data FROM '/Volumes/SaoirseMor/Dropbox/dataswap/Open_Gov_Boston/Crime_Incident_Reports.csv' WITH CSV HEADER DELIMITER AS ',';

-- add points
ALTER TABLE crime_data ADD COLUMN geom geometry(POINT, 26986);
UPDATE crime_data SET geom = ST_SetSRID(ST_MakePoint(x,y),26986);
