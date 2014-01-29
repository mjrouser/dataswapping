drop table original.fires;
create table original.fires (
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
\COPY original.fires FROM '/Volumes/SaoirseMor/Dropbox/dataswap/BostonBlightBuilding/Fires_Final_forimport.csv' WITH CSV HEADER DELIMITER AS ',';

-- add points
ALTER TABLE original.fires ADD COLUMN geom geometry(POINT, 26986);
UPDATE original.fires SET geom = ST_SetSRID(ST_MakePoint(x,y),26986);
CREATE INDEX idx_fires ON original.fires USING GIST ( geom );