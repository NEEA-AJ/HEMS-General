from pathlib import Path
import pyarrow.parquet as pq
import pyarrow as pa

input_dir = Path(r"D:\DOWNLOADS")
tables = [pq.read_table(file) for file in sorted(input_dir.glob("*.parquet"))]
combined = pa.concat_tables(tables, promote=True)
pq.write_table(combined, input_dir / "POWER60_combined.parquet")