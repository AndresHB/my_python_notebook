import os
import json
from pathlib import Path
from pymongo import MongoClient, ReplaceOne


def main() -> None:
    db_name = os.getenv("MONGO_DB", "megaman_x_glossary")
    mongo_uri = os.getenv("MONGO_URI", "mongodb://localhost:27017")

    base_dir = Path(__file__).resolve().parents[1]  # mongo_db/
    backup_path = base_dir / "backup.json"

    if not backup_path.exists():
        raise FileNotFoundError(f"Cannot find backup.json at: {backup_path}")

    with backup_path.open("r", encoding="utf-8") as f:
        payload = json.load(f)

    games = payload.get("games", [])
    collection_name = payload.get("collection")
    schema_version = payload.get("schema_version")

    if not collection_name or not isinstance(games, list):
        raise ValueError("backup.json must include 'collection' and 'games' (list).")

    client = MongoClient(mongo_uri)
    db = client[db_name]
    col = db[collection_name]

    db["_meta"].replace_one(
        {"_id": "seed_info"},
        {"schema_version": schema_version, "source": "backup.json"},
        upsert=True,
    )

    ops = []
    for g in games:
        game_id = g.get("id")
        if not game_id:
            continue
        ops.append(ReplaceOne({"id": game_id}, g, upsert=True))

    if ops:
        result = col.bulk_write(ops, ordered=False)
        print(
            f"Seed OK → db={db_name} collection={collection_name} | "
            f"upserts={result.upserted_count} modified={result.modified_count}"
        )
    else:
        print("No valid games to insert (missing ids).")


if __name__ == "__main__":
    main()
