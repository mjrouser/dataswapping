drop table crime_data;
create table crime_data (
	computercrimecode 
	weapontype character varying(10),
	fromdate date
	x numeric, 
	y numeric
);

-- copy data from CSV
\COPY acs_data FROM '/Volumes/SaoirseMor/Dropbox/dataswap/Open_Gov_Boston/Crime_Incident_Reports.csv' WITH CSV HEADER DELIMITER AS ',';
