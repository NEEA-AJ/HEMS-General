-- If POWER60_RAWT becomes the validated canonical table, swap it into place.
-- (This is fast but should only be done once you’re satisfied.)
ALTER TABLE "HEMS"."SANDBOX"."POWER60_RAW" SWAP WITH "HEMS"."SANDBOX"."POWER60_RAWT";
