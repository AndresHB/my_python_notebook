# MongoDB — Megaman X Glossary

Local MongoDB database with the Mega Man X saga glossary.

## Requirements

- **Python 3.10+**
- **MongoDB** (`mongod`) — install with `brew install mongodb-community`

## Quick Start

### All in one step

```bash
./init.sh
```

Starts `mongod` in background, creates the virtualenv, installs dependencies and runs the seed.

### Stop MongoDB

```bash
./exit.sh
```

### Manual usage (2 terminals)

If you prefer manual control:

```bash
# Terminal 1 — start mongod in foreground
./scripts/start_db.sh

# Terminal 2 — install deps and seed
./scripts/setup_db.sh
```

### Verify data

```bash
mongosh --eval 'db = db.getSiblingDB("megaman_x_glossary"); print("documents:", db.megaman_x_mainline.countDocuments({}))'
```

## Structure

```
mongo_db/
├── init.sh              # Starts everything (mongod + seed)
├── exit.sh              # Stops mongod
├── backup.json          # Glossary source data
├── requirements.txt     # pymongo>=4.6
├── README.md
├── .data/               # mongod data (git-ignored)
├── .venv/               # Virtualenv  (git-ignored)
└── scripts/
    ├── start_db.sh      # Starts mongod in foreground
    ├── setup_db.sh      # Installs deps + runs seed
    └── seed.py          # Insertion script (upsert)
```
