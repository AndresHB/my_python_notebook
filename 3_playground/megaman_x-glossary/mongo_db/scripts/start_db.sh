#!/usr/bin/env bash
# ──────────────────────────────────────────────
# start_db.sh — Starts a local MongoDB instance
# Uses a "data/" folder inside mongo_db/ as dbpath.
# Stop with Ctrl+C.
# ──────────────────────────────────────────────
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DATA_DIR="$PROJECT_DIR/.data"

# Check that mongod is installed
if ! command -v mongod &>/dev/null; then
  echo "❌  mongod not found. Install it with:  brew install mongodb-community"
  exit 1
fi

# Create data folder if it does not exist
mkdir -p "$DATA_DIR"

echo "🟢  Starting mongod..."
echo "   dbpath  → $DATA_DIR"
echo "   port    → 27017"
echo "   Stop with Ctrl+C"
echo ""

exec mongod --dbpath "$DATA_DIR" --bind_ip 127.0.0.1 --port 27017
