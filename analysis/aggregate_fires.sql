DROP TABLE aggregated.fires;
CREATE TABLE aggregated.fires as
SELECT 
 f.geoid10,
 COUNT(*),
 SUM(total_loss) as sum_total_loss
FROM 
 joined.fires as f
GROUP BY geoid10;