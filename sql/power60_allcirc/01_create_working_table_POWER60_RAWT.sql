-- Create working table for development (prefer CLONE for zero-copy)
CREATE OR REPLACE TABLE "HEMS"."SANDBOX"."POWER60_RAWT"
CLONE "HEMS"."SANDBOX"."POWER60_RAW";
