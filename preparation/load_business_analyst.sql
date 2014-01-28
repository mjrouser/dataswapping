
------------------------------------------
-- START 2007 2007 2007 2007
-- create table
drop table biz_data_2007;
create table biz_data_2007 (
	sic character varying(10),
	naics_ext character varying(10),
	sales_vol numeric,
	number_emp numeric,
	x numeric,
	y numeric,
	new boolean,
	closed boolean
);

-- copy data from CSV
\COPY biz_data_2007 FROM '/Volumes/SaoirseMor/Dropbox/dataswap/ESRI_Business_Analyst/ba_boston_forimport_2007.csv' WITH CSV HEADER DELIMITER AS ',';

-- add points
ALTER TABLE biz_data_2007 ADD COLUMN geom geometry(POINT, 26986);
UPDATE biz_data_2007 SET geom = ST_Transform(ST_SetSRID(ST_MakePoint(x,y),4326), 26986);

-- END 2007 2007 2007 2007
------------------------------------------

------------------------------------------
-- START 2008 2008 2008 2008
-- create table
drop table biz_data_2008;
create table biz_data_2008 (
	sic character varying(10),
	naics_ext character varying(10),
	sales_vol numeric,
	number_emp numeric,
	x numeric,
	y numeric,
	new boolean,
	closed boolean
);

-- copy data from CSV
\COPY biz_data_2008 FROM '/Volumes/SaoirseMor/Dropbox/dataswap/ESRI_Business_Analyst/ba_boston_forimport_2008.csv' WITH CSV HEADER DELIMITER AS ',';

-- add points
ALTER TABLE biz_data_2008 ADD COLUMN geom geometry(POINT, 26986);
UPDATE biz_data_2008 SET geom = ST_Transform(ST_SetSRID(ST_MakePoint(x,y),4326), 26986);

-- END 2008 2008 2008 2008
------------------------------------------

------------------------------------------
-- START 2009 2009 2009 2009
-- create table
drop table biz_data_2009;
create table biz_data_2009 (
	sic character varying(10),
	naics_ext character varying(10),
	sales_vol numeric,
	number_emp numeric,
	x numeric,
	y numeric,
	new boolean,
	closed boolean
);

-- copy data from CSV
\COPY biz_data_2009 FROM '/Volumes/SaoirseMor/Dropbox/dataswap/ESRI_Business_Analyst/ba_boston_forimport_2009.csv' WITH CSV HEADER DELIMITER AS ',';

-- add points
ALTER TABLE biz_data_2009 ADD COLUMN geom geometry(POINT, 26986);
UPDATE biz_data_2009 SET geom = ST_Transform(ST_SetSRID(ST_MakePoint(x,y),4326), 26986);

-- END 2009 2009 2009 2009
------------------------------------------

------------------------------------------
-- START 2010 2010 2010 2010
-- create table
drop table biz_data_2010;
create table biz_data_2010 (
	sic character varying(10),
	naics_ext character varying(10),
	sales_vol numeric,
	number_emp numeric,
	x numeric,
	y numeric,
	new boolean,
	closed boolean
);

-- copy data from CSV
\COPY biz_data_2010 FROM '/Volumes/SaoirseMor/Dropbox/dataswap/ESRI_Business_Analyst/ba_boston_forimport_2010.csv' WITH CSV HEADER DELIMITER AS ',';

-- add points
ALTER TABLE biz_data_2010 ADD COLUMN geom geometry(POINT, 26986);
UPDATE biz_data_2010 SET geom = ST_Transform(ST_SetSRID(ST_MakePoint(x,y),4326), 26986);

-- END 2010 2010 2010 2010
------------------------------------------

------------------------------------------
-- START 2011 2011 2011 2011
-- create table
drop table biz_data_2011;
create table biz_data_2011 (
	sic character varying(10),
	naics_ext character varying(10),
	sales_vol numeric,
	number_emp numeric,
	x numeric,
	y numeric,
	new boolean,
	closed boolean
);

-- copy data from CSV
\COPY biz_data_2011 FROM '/Volumes/SaoirseMor/Dropbox/dataswap/ESRI_Business_Analyst/ba_boston_forimport_2011.csv' WITH CSV HEADER DELIMITER AS ',';

-- add points
ALTER TABLE biz_data_2011 ADD COLUMN geom geometry(POINT, 26986);
UPDATE biz_data_2011 SET geom = ST_Transform(ST_SetSRID(ST_MakePoint(x,y),4326), 26986);

-- END 2011 2011 2011 2011
------------------------------------------
