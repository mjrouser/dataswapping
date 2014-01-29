drop table original.permit_data;
create table original.permit_data (
	x numeric,
	y numeric,
	addressid character varying(6),
	permittype character varying(10), 
	adddate date, 
	permittype_long character varying(50), 
	descript character varying(50)
);

-- copy data from CSV
\COPY original.permit_data FROM '/Volumes/SaoirseMor/Dropbox/dataswap/BostonBlightBuilding/Hansen_Permits_2009_2012_forimport.csv' WITH CSV HEADER DELIMITER AS ',' ;

-- add points
ALTER TABLE original.permit_data ADD COLUMN geom geometry(POINT, 26986);
UPDATE original.permit_data SET geom = ST_Transform(ST_SetSRID(ST_MakePoint(x,y),2894), 26986);
CREATE INDEX idx_permit_data ON original.permit_data USING GIST ( geom );

