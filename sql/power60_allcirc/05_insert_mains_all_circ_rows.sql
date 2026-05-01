-- Insert synthetic whole-home rows for flagged sites, one per (ee_site_id, min_t_l)
-- Uses MIN(min_t) as UTC timestamp representative for that hour.
INSERT INTO "HEMS"."SANDBOX"."POWER60_RAWT"
(
    "ee_site_id","point_id","min_t","power","apparent_power","pf",
    "circuit","end_use","category","min_t_l","state","hz","cz"
)
WITH "map" AS (
    SELECT *
    FROM "HEMS"."SANDBOX"."MAINS_ALLCIRC_POINT_MAP_60T"
),
"agg" AS (
    SELECT
        p."ee_site_id",
        p."min_t_l",
        MIN(p."min_t") AS "min_t_any",
        SUM(p."power") AS "power_sum",
        SUM(p."apparent_power") AS "apparent_power_sum",
        MAX(p."state") AS "state_any",
        MAX(p."hz") AS "hz_any",
        MAX(p."cz") AS "cz_any"
    FROM "HEMS"."SANDBOX"."POWER60_RAWT" p
    JOIN "map" m
      ON p."ee_site_id" = m."ee_site_id"
    GROUP BY p."ee_site_id", p."min_t_l"
)
SELECT
    a."ee_site_id",
    m."point_id_allcirc",
    a."min_t_any",
    a."power_sum",
    a."apparent_power_sum",
    CASE
        WHEN a."apparent_power_sum" = 0 OR a."apparent_power_sum" IS NULL THEN NULL
        ELSE a."power_sum" / a."apparent_power_sum"
    END,
    'Mains_All_Circ_01',
    'Mains All Circ',
    'Service',
    a."min_t_l",
    a."state_any",
    a."hz_any",
    a."cz_any"
FROM "agg" a
JOIN "map" m
  ON a."ee_site_id" = m."ee_site_id"
WHERE NOT EXISTS (
    SELECT 1
    FROM "HEMS"."SANDBOX"."POWER60_RAWT" x
    WHERE x."ee_site_id" = a."ee_site_id"
      AND x."point_id"   = m."point_id_allcirc"
      AND x."min_t_l"    = a."min_t_l"
);
