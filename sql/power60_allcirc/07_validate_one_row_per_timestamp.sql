-- For flagged sites, verify one synthetic row per timestamp
WITH "flagged" AS (
    SELECT "ee_site_id"
    FROM "HEMS"."SANDBOX"."MAINS_ALLCIRC_POINT_MAP_60T"
)
SELECT
    p."ee_site_id",
    COUNT(DISTINCT p."min_t_l") AS "n_hours_any",
    COUNT(DISTINCT IFF(p."end_use"='Mains All Circ', p."min_t_l", NULL)) AS "n_hours_allcirc"
FROM "HEMS"."SANDBOX"."POWER60_RAWT" p
JOIN "flagged" f
  ON p."ee_site_id" = f."ee_site_id"
GROUP BY p."ee_site_id"
HAVING "n_hours_any" <> "n_hours_allcirc"
ORDER BY p."ee_site_id";
