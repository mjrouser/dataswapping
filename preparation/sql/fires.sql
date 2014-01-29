drop table fires_data;
create table fires_data (
	x numeric, 
	y numeric, 
	locationid integer, 
	alm_date date, 
	alm_type integer,  
	cause_ign integer, 
	descript_b character varying(50), 
	total_loss integer
);

-- copy data from CSV
\COPY fires_data FROM '/Volumes/SaoirseMor/Dropbox/dataswap/BostonBlightBuilding/Fires_Final_forimport.csv' WITH CSV HEADER DELIMITER AS ',';

-- add points
ALTER TABLE fires_data ADD COLUMN geom geometry(POINT, 26986);
UPDATE fires_data SET geom = ST_SetSRID(ST_MakePoint(x,y),26986);
CREATE INDEX idx_fires_data ON fires_data USING GIST ( geom );