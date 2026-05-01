-- Spot-check that AllCirc equals sum of all circuits at each timestamp
SELECT
    p."ee_site_id",
    p."min_t_l",
    SUM(p."power") AS "sum_all_power",
    MAX(IFF(p."end_use"='Mains All Circ', p."power", NULL)) AS "allcirc_power"
FROM "HEMS"."SANDBOX"."POWER60_RAWT" p
WHERE p."ee_site_id" IN (
    SELECT "ee_site_id" FROM "HEMS"."SANDBOX"."MAINS_ALLCIRC_POINT_MAP_60T"
)
GROUP BY p."ee_site_id", p."min_t_l"
QUALIFY ABS("sum_all_power" - "allcirc_power") > 0.0001
ORDER BY p."ee_site_id", p."min_t_l";
