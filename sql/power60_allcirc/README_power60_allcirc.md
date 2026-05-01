# POWER60 AllCirc (Mains All Circ) Patch



Purpose
Creates a synthetic whole-home circuit (end_use = 'Mains All Circ', category='Service') for sites where Mains / Mains With Solar are missing or have only zero/NULL power.
Run order
1) 01_create_working_table_POWER60_RAWT.sql 2) 02_list_flagged_sites_missing_or_invalid_mains.sql 3) 03_count_flagged_sites.sql 4) 04_create_point_map_9990x.sql 5) 05_insert_mains_all_circ_rows.sql 6) 06_validate_added_rows.sql 7) 07_validate_one_row_per_timestamp.sql 8) 08_validate_spotcheck_sums.sql
Promote to prod



