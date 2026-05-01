-- List ee_site_id where:
-- (a) no end_use in ('Mains','Mains With Solar'), OR
-- (b) those mains rows exist but power is always NULL/0 (sum abs(power)=0)
WITH "all_sites" AS (
    SELECT DISTINCT "ee_site_id"
    FROM "HEMS"."SANDBOX"."POWER60_RAWT"
),
"mains_summary" AS (
    SELECT
        "ee_site_id",
        COUNT(*) AS "mains_row_count",
        SUM(ABS(COALESCE("power", 0))) AS "mains_sum_abs_power",
        SUM(COALESCE("power", 0)) AS "mains_sum_power",
        SUM(IFF("power" IS NULL, 1, 0)) AS "mains_null_count"
    FROM "HEMS"."SANDBOX"."POWER60_RAWT"
    WHERE "end_use" IN ('Mains', 'Mains With Solar')
    GROUP BY "ee_site_id"
),
"flagged_sites" AS (
    SELECT
        s."ee_site_id",
        COALESCE(m."mains_row_count", 0) AS "mains_row_count",
        COALESCE(m."mains_sum_abs_power", 0) AS "mains_sum_abs_power",
        COALESCE(m."mains_sum_power", 0) AS "mains_sum_power",
        COALESCE(m."mains_null_count", 0) AS "mains_null_count",
        CASE
            WHEN m."ee_site_id" IS NULL THEN 'NO_MAINS_END_USE'
            WHEN COALESCE(m."mains_sum_abs_power", 0) = 0 THEN 'MAINS_ALL_ZERO_OR_NULL'
            ELSE 'OK'
        END AS "flag_reason"
    FROM "all_sites" s
    LEFT JOIN "mains_summary" m
        ON s."ee_site_id" = m."ee_site_id"
    WHERE m."ee_site_id" IS NULL
       OR COALESCE(m."mains_sum_abs_power", 0) = 0
)
SELECT *
FROM "flagged_sites"
ORDER BY "flag_reason", "ee_site_id";
