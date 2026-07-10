"""Validate the source files and build the local DuckDB database."""

from __future__ import annotations

import os
from pathlib import Path

import duckdb


PROJECT_ROOT = Path(__file__).resolve().parents[1]
DATA_DIR = PROJECT_ROOT / "data" / "raw"
DATABASE_PATH = PROJECT_ROOT / "instacart.duckdb"
REQUIRED_FILES = (
    "aisles.csv",
    "departments.csv",
    "orders.csv",
    "products.csv",
    "order_products__prior.csv",
    "order_products__train.csv",
)


def validate_source_files() -> None:
    missing = [name for name in REQUIRED_FILES if not (DATA_DIR / name).is_file()]
    if missing:
        formatted = "\n".join(f"  - data/raw/{name}" for name in missing)
        raise SystemExit(
            "Missing required Kaggle source files:\n"
            f"{formatted}\n"
            "Download them using the link in README.md."
        )


def main() -> None:
    validate_source_files()
    create_tables_sql = (PROJECT_ROOT / "sql" / "create_tables.sql").read_text()

    # DuckDB resolves CSV paths relative to the process working directory.
    previous_directory = Path.cwd()
    try:
        os.chdir(PROJECT_ROOT)
        with duckdb.connect(str(DATABASE_PATH)) as connection:
            connection.execute(create_tables_sql)
            tables = connection.execute(
                "SELECT table_name FROM information_schema.tables "
                "WHERE table_schema = 'main' ORDER BY table_name"
            ).fetchall()
    finally:
        os.chdir(previous_directory)

    print(f"Database created: {DATABASE_PATH}")
    print("Tables: " + ", ".join(row[0] for row in tables))


if __name__ == "__main__":
    main()
