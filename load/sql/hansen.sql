drop table original.permits;
create table original.permits (
	x numeric,
	y numeric,
	addressid character varying(6),
	permittype character varying(10), 
	adddate date, 
	permittype_long character varying(50), 
	descript character varying(50)
);

-- copy data from CSV
\COPY original.permits FROM '/Volumes/SaoirseMor/Dropbox/dataswap/BostonBlightBuilding/Hansen_Permits_2009_2012_forimport.csv' WITH CSV HEADER DELIMITER AS ',' ;

-- add points
ALTER TABLE original.permits ADD COLUMN geom geometry(POINT, 26986);
UPDATE original.permits SET geom = ST_Transform(ST_SetSRID(ST_MakePoint(x,y),2894), 26986);
CREATE INDEX idx_permits ON original.permits USING GIST ( geom );

