"""Execute every portfolio SQL query and report failures and runtimes."""

from __future__ import annotations

import argparse
import re
import time
from pathlib import Path

import duckdb


PROJECT_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_DATABASE = PROJECT_ROOT / "instacart.duckdb"
QUERY_PATTERN = re.compile(r"^(\d{2})_.+\.sql$")


def discover_queries() -> list[tuple[int, Path]]:
    queries: list[tuple[int, Path]] = []
    for path in (PROJECT_ROOT / "sql").glob("*/*.sql"):
        match = QUERY_PATTERN.match(path.name)
        if match:
            queries.append((int(match.group(1)), path))

    queries.sort(key=lambda item: item[0])
    identifiers = [identifier for identifier, _ in queries]
    expected = list(range(1, 41))
    if identifiers != expected:
        raise SystemExit(
            "Expected query IDs 01-40 exactly once; found: "
            + ", ".join(f"{identifier:02d}" for identifier in identifiers)
        )
    return queries


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--database",
        type=Path,
        default=DEFAULT_DATABASE,
        help="Path to the DuckDB database (default: instacart.duckdb)",
    )
    args = parser.parse_args()
    database = args.database.expanduser().resolve()
    if not database.is_file():
        raise SystemExit(
            f"Database not found: {database}\n"
            "Run `python scripts/build_database.py` first."
        )

    queries = discover_queries()
    failures: list[tuple[Path, Exception]] = []
    total_started = time.perf_counter()

    with duckdb.connect(str(database), read_only=True) as connection:
        for identifier, path in queries:
            started = time.perf_counter()
            try:
                connection.execute(path.read_text()).fetchone()
                elapsed = time.perf_counter() - started
                print(f"[OK] {identifier:02d} {path.name} ({elapsed:.3f}s)")
            except Exception as error:  # Continue so one run reports every failure.
                failures.append((path, error))
                print(f"[FAIL] {identifier:02d} {path.name}: {error}")

    total_elapsed = time.perf_counter() - total_started
    if failures:
        raise SystemExit(f"{len(failures)} of {len(queries)} queries failed.")
    print(f"All {len(queries)} queries passed in {total_elapsed:.3f}s.")


if __name__ == "__main__":
    main()
