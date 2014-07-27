DROP TABLE aggregated.test_map;
CREATE TABLE aggregated.test_map as
SELECT f.*, c.geom
FROM 
  aggregated.r1_tax as f,
  original.census_2010 as c
WHERE
  c.geoid10 = f.geoid10
AND 
  f.year = 2000
LIMIT 100;
