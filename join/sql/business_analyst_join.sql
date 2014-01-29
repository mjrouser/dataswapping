--This file is generated dynamically!
------------------------------------------
-- START 2007 
DROP TABLE joined.biz_data_2007;
CREATE TABLE joined.biz_data_2007 AS 
SELECT t.*, c.geoid10
FROM original.biz_data_2007 as t
JOIN original.census_2010 as c
ON ST_Contains(c.geom, t.geom);
CREATE INDEX idx_biz_data_2007 ON joined.biz_data_2007 USING gist (geom);
-- END 2007 
------------------------------------------

------------------------------------------
-- START 2008 
DROP TABLE joined.biz_data_2008;
CREATE TABLE joined.biz_data_2008 AS 
SELECT t.*, c.geoid10
FROM original.biz_data_2008 as t
JOIN original.census_2010 as c
ON ST_Contains(c.geom, t.geom);
CREATE INDEX idx_biz_data_2008 ON joined.biz_data_2008 USING gist (geom);
-- END 2008 
------------------------------------------

------------------------------------------
-- START 2009 
DROP TABLE joined.biz_data_2009;
CREATE TABLE joined.biz_data_2009 AS 
SELECT t.*, c.geoid10
FROM original.biz_data_2009 as t
JOIN original.census_2010 as c
ON ST_Contains(c.geom, t.geom);
CREATE INDEX idx_biz_data_2009 ON joined.biz_data_2009 USING gist (geom);
-- END 2009 
------------------------------------------

------------------------------------------
-- START 2010 
DROP TABLE joined.biz_data_2010;
CREATE TABLE joined.biz_data_2010 AS 
SELECT t.*, c.geoid10
FROM original.biz_data_2010 as t
JOIN original.census_2010 as c
ON ST_Contains(c.geom, t.geom);
CREATE INDEX idx_biz_data_2010 ON joined.biz_data_2010 USING gist (geom);
-- END 2010 
------------------------------------------

------------------------------------------
-- START 2011 
DROP TABLE joined.biz_data_2011;
CREATE TABLE joined.biz_data_2011 AS 
SELECT t.*, c.geoid10
FROM original.biz_data_2011 as t
JOIN original.census_2010 as c
ON ST_Contains(c.geom, t.geom);
CREATE INDEX idx_biz_data_2011 ON joined.biz_data_2011 USING gist (geom);
-- END 2011 
------------------------------------------
