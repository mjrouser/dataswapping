drop table original.crm;
create table original.crm (
	x  numeric,
	y numeric, 
	x_alt numeric, 
	y_alt numeric, 
	propid character varying(7), 
	opendate date, 
	subject character varying(50), 
	reason character varying(50), 
	type character varying(50), 
	channel character varying(50), 
	source character varying(50), 
	unciviluse integer, 
	housing integer,    
	bigbuilt integer, 
	graffiti integer, 
	trash integer, 
	privateneglect integer, 
	problem integer, 
	publicdenig integer
);

-- copy data from CSV
\COPY original.crm FROM '/Volumes/SaoirseMor/Dropbox/dataswap/BostonBlightBuilding/CRM_Final_forimport.csv' WITH CSV HEADER DELIMITER AS ',';


ALTER TABLE original.crm ADD COLUMN geom geometry(POINT, 26986);
UPDATE original.crm SET geom = ST_SetSRID(ST_MakePoint(x,y),26986);
CREATE INDEX idx_crm ON original.crm USING GIST ( geom );