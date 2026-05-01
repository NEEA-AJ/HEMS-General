-- Create deterministic 9990x point_id mapping for flagged sites
CREATE OR REPLACE TABLE "HEMS"."SANDBOX"."MAINS_ALLCIRC_POINT_MAP_60T" AS
WITH "flagged" AS (
    SELECT
        s."ee_site_id"
    FROM (SELECT DISTINCT "ee_site_id" FROM "HEMS"."SANDBOX"."POWER60_RAWT") s
    LEFT JOIN (
        SELECT
            "ee_site_id",
            SUM(ABS(COALESCE("power", 0))) AS "mains_sum_abs_power"
        FROM "HEMS"."SANDBOX"."POWER60_RAWT"
        WHERE "end_use" IN ('Mains', 'Mains With Solar')
        GROUP BY "ee_site_id"
    ) m ON s."ee_site_id" = m."ee_site_id"
    WHERE m."ee_site_id" IS NULL
       OR COALESCE(m."mains_sum_abs_power", 0) = 0
)
SELECT
    "ee_site_id",
    99900 + ROW_NUMBER() OVER (ORDER BY "ee_site_id") AS "point_id_allcirc"
FROM "flagged";


