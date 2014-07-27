-- JOIN TAX POINTS TO BLOCKGROUPS
DROP TABLE joined.tax;
CREATE TABLE joined.tax AS 
SELECT t.*, c.geoid10
FROM original.tax as t
JOIN original.census_2010 as c
ON ST_Contains(c.geom, t.geom);
CREATE INDEX idx_tax ON joined.tax USING gist (geom);

-- JOIN FIRES TO BLOCKGROUPS
DROP TABLE joined.fires;
CREATE TABLE joined.fires AS 
SELECT f.*, c.geoid10
FROM original.fires as f
JOIN original.census_2010 as c
ON ST_Contains(c.geom, f.geom);

-- JOIN CRIME_311 TO BLOCKGROUPS
DROP TABLE joined.crime_311;
CREATE TABLE joined.crime_311 AS 
SELECT f.*, c.geoid10
FROM original.crime_311 as f
JOIN original.census_2010 as c
ON ST_Contains(c.geom, f.geom);

-- JOIN PERMITS TO BLOCKGROUPS
DROP TABLE joined.permits;
CREATE TABLE joined.permits AS 
SELECT p.*, c.geoid10
FROM original.permits as p
JOIN original.census_2010 as c
ON ST_Contains(c.geom, p.geom);

-- JOIN VIOLATIONS TO BLOCKGROUPS
DROP TABLE joined.inspection_violations;
CREATE TABLE joined.inspection_violations AS 
SELECT p.*, c.geoid10
FROM original.inspection_violations as p
JOIN original.census_2010 as c
ON ST_Contains(c.geom, p.geom);

-- JOIN BUILDINGS AND TAX DATA
DROP TABLE joined.buildings;
CREATE TABLE joined.buildings AS 
SELECT b.*, c.geoid10
FROM original.buildings as b 
JOIN original.census_2010 as c
ON ST_Contains(c.geom, ST_Transform(b.geom, 26986));
CREATE INDEX idx_buildings ON joined.buildings USING gist (geom);

-- JOIN CRIME_911 TO BLOCKGROUPS
DROP TABLE joined.crime_911;
CREATE TABLE joined.crime_911 AS 
SELECT f.*, c.geoid10
FROM original.crime_911 as f
JOIN original.census_2010 as c
ON ST_Contains(c.geom, f.geom);

-- JOIN CRIME1 TO BLOCKGROUPS
DROP TABLE joined.crime;
CREATE TABLE joined.crime AS 
SELECT f.*, c.geoid10
FROM original.crime as f
JOIN original.census_2010 as c
ON ST_Contains(c.geom, f.geom);

-- JOIN CRIME2 TO BLOCKGROUPS
DROP TABLE joined.crime2;
CREATE TABLE joined.crime2 AS 
SELECT f.*, c.geoid10
FROM original.crime2 as f
JOIN original.census_2010 as c
ON ST_Contains(c.geom, f.geom);

-- JOIN factors TO BLOCKGROUPS
DROP TABLE joined.factors;
CREATE TABLE joined.factors AS 
SELECT f.*, c.geoid10
FROM 
  original.factors as f,
  original.census_2010 as c
WHERE f.geoid = c.geoid10;

