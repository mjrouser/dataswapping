-- JOIN PARCELS AND TAX DATA
DROP TABLE parcels_tax;
CREATE TABLE parcels_tax AS 
SELECT p.geom, t.*
FROM parcels as p
LEFT JOIN tax_assessor as t
ON p.pid_long = t.parcel_id;
CREATE INDEX idx_parcels_tax ON parcels_tax USING gist (geom);

-- JOIN NEIGHBORHOODS TO PARCELS
DROP TABLE parcels_tax_neighborhood;
CREATE TABLE parcels_tax_neighborhood AS 
SELECT p.*, n.nbhd
FROM parcels_tax as p
JOIN neighborhoods as n
ON ST_Contains(n.geom, p.geom);
CREATE INDEX idx_parcels_tax_neighborhood ON parcels_tax_neighborhood USING gist (geom);


-- JOIN BUILDINGS AND TAX DATA
DROP TABLE building_tax;
CREATE TABLE building_tax AS 
SELECT t.*, b.geom, b.elev_gl, b.top_gl
FROM buildings as b 
LEFT JOIN tax_assessor as t
ON t.parcel_id = b.parcel_id;
CREATE INDEX idx_building_tax ON building_tax USING gist (geom);

-- JOIN NEIGHBORHOODS TO BUILDINGS
DROP TABLE building_tax_neighborhood;
CREATE TABLE building_tax_neighborhood AS 
SELECT b.*, n.nbhd
FROM building_tax as b 
JOIN neighborhoods as n
ON ST_Contains(n.geom, b.geom);
CREATE INDEX idx_building_tax_neighborhood ON building_tax_neighborhood USING gist (geom);

-- JOIN BUILDINGS TO CENSUS BLOCKS
DROP TABLE building_tax_neighborhood_census;
CREATE TABLE building_tax_neighborhood_census AS 
SELECT b.*, c.pop_den, c.geoid10
FROM building_tax_neighborhood as b 
JOIN census as c
ON ST_Contains(c.geom, b.geom);
CREATE INDEX idx_building_tax_neighborhood_census ON building_tax_neighborhood_census USING gist (geom);

-- summarize by census block
DROP TABLE building_tax_neighborhood_census_summary;
CREATE TABLE building_tax_neighborhood_census_summary AS 
SELECT geoid10, AVG(elev_gl) as elev_gl, AVG(fy2013) as fy2013, AVG(pop_den) as pop_den
FROM building_tax_neighborhood_census
GROUP BY geoid10
ORDER BY geoid10;

-- join census block to nbhd
DROP TABLE building_tax_neighborhood_census_summary_nbhd;
CREATE TABLE building_tax_neighborhood_census_summary_nbhd AS 
SELECT b.*, c.nbhd
FROM building_tax_neighborhood_census_summary as b
LEFT JOIN census_neighborhood as c
ON b.geoid10 = c.geoid10
WHERE b.pop_den < 30000;

-- JOIN NEIGHBORHOODS TO CENSUS BLOCKS
DROP TABLE census_neighborhood;
CREATE TABLE census_neighborhood AS 
SELECT c.*, n.nbhd
FROM census as c
JOIN neighborhoods as n
ON ST_Contains(n.geom, ST_Centroid(c.geom));
CREATE INDEX idx_census_neighborhood ON census_neighborhood USING gist (geom);

-- summarize height by neighborhood
DROP TABLE analysis.avg_hgt;
CREATE TABLE analysis.avg_hgt as 
SELECT AVG(b.top_gl) as top_gl_avg, b.nbhd
FROM building_tax_neighborhood as b
GROUP BY b.nbhd ORDER BY b.nbhd;

-- summarize assesed value by neighborhood
DROP TABLE analysis.avg_tax;
CREATE TABLE analysis.avg_tax as 
SELECT AVG(p.fy2013) as fy2013, p.nbhd
FROM parcels_tax_neighborhood as p
GROUP BY p.nbhd ORDER BY p.nbhd;

-- summarize pop_den by neighborhood
DROP TABLE analysis.avg_pop;
CREATE TABLE analysis.avg_pop as 
SELECT SUM(c.population)/SUM(c.aland10/10^6) as pop_den_avg, c.nbhd
FROM census_neighborhood as c
GROUP BY c.nbhd ORDER BY c.nbhd;

-- join these tables to neighborhood
DROP TABLE analysis.neighborhood_summary;
CREATE TABLE analysis.neighborhood_summary as
SELECT n.geom, n.nbhd, h.top_gl_avg, t.fy2013, p.pop_den_avg * 2.5899 as pop_den_avg
FROM neighborhoods as n
LEFT JOIN analysis.avg_hgt as h
ON h.nbhd = n.nbhd
LEFT JOIN analysis.avg_tax as t
ON t.nbhd = n.nbhd
LEFT JOIN analysis.avg_pop as p
ON p.nbhd = n.nbhd
ORDER BY n.nbhd;

-- tallest buildings
SELECT parcel_id, top_gl, address
FROM buildings
ORDER BY top_gl DESC
LIMIT 5;

-- most expensive parcel
SELECT parcel_id, fy2013
FROM parcels_tax
WHERE fy2013 > 0
ORDER BY fy2013 DESC
LIMIT 5;


--
--FIX CENSUS PROBLEM
CREATE TABLE census_tmp AS
SELECT DISTINCT geoid10, population, pdens_mile, tot_mile, aland10, tot_area_m, pop_den, land_den, h_units, hu_den, geom
FROM census
ORDER BY geoid10;
CREATE INDEX census_geom_gist
  ON census
  USING gist
  (geom);

