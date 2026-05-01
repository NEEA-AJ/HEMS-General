# scripts/run_power60_allcirc.py
import pyodbc
from pathlib import Path

# DSN must exist (per internal guide)
cnxn = pyodbc.connect("DSN=HEMS")
cur = cnxn.cursor()

def run_sql_file(path):
    sql = Path(path).read_text(encoding="utf-8")
    print(f"Running: {path}")
    cur.execute(sql)
    try:
        cnxn.commit()
    except Exception:
        pass

files = [
  "sql/power60_allcirc/01_create_working_table_POWER60_RAWT.sql",
  "sql/power60_allcirc/02_list_flagged_sites_missing_or_invalid_mains.sql",
  "sql/power60_allcirc/03_count_flagged_sites.sql",
  "sql/power60_allcirc/04_create_point_map_9990x.sql",
  "sql/power60_allcirc/05_insert_mains_all_circ_rows.sql",
  "sql/power60_allcirc/06_validate_added_rows.sql",
  "sql/power60_allcirc/07_validate_one_row_per_timestamp.sql",
  "sql/power60_allcirc/08_validate_spotcheck_sums.sql",
]

for f in files:
    run_sql_file(f)

cur.close()
cnxn.close()
