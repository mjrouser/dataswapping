drop table original.inspection_violations;
create table original.inspection_violations (
	x numeric,
	y numeric,
	addressid integer,
	violationdate date, 
	description character varying(50)
);

-- copy data from CSV
\COPY original.inspection_violations FROM '/Volumes/SaoirseMor/Dropbox/dataswap/BostonBlightBuilding/Inspection_Violations_forimport.csv' WITH CSV HEADER DELIMITER AS ',' ;

-- add points
ALTER TABLE original.inspection_violations ADD COLUMN geom geometry(POINT, 26986);
UPDATE original.inspection_violations SET geom = ST_Transform(ST_SetSRID(ST_MakePoint(x,y),2894), 26986);
CREATE INDEX idx_inspection_violations ON original.inspection_violations USING GIST ( geom );