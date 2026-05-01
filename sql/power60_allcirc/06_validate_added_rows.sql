-- Validate number of inserted rows and sites
SELECT
    COUNT(*) AS "n_allcirc_rows",
    COUNT(DISTINCT "ee_site_id") AS "n_sites"
FROM "HEMS"."SANDBOX"."POWER60_RAWT"
WHERE "end_use" = 'Mains All Circ'
  AND "circuit" = 'Mains_All_Circ_01'
  AND "category" = 'Service';

