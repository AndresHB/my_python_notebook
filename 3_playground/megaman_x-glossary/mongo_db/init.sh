#!/usr/bin/env bash
# ──────────────────────────────────────────────
# init.sh — Starts MongoDB + runs seed in a single step
# Saves the mongod PID in data/mongod.pid for exit.sh.
# ──────────────────────────────────────────────
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_DIR="$PROJECT_DIR/scripts"
DATA_DIR="$PROJECT_DIR/.data"
PID_FILE="$DATA_DIR/mongod.pid"
MONGO_PORT=27017

# ── Check that mongod is installed ──
if ! command -v mongod &>/dev/null; then
  echo "❌  mongod not found. Install it with:  brew install mongodb-community"
  exit 1
fi

# ── Check that no other instance is running ──
if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
  echo "⚠️  mongod is already running (PID $(cat "$PID_FILE")). Use ./exit.sh to stop it first."
  exit 1
fi

# ── Create data folder ──
mkdir -p "$DATA_DIR"

# ── 1. Start mongod in background ──
echo "🟢  Starting mongod in background..."
mongod --dbpath "$DATA_DIR" --bind_ip 127.0.0.1 --port "$MONGO_PORT" > "$DATA_DIR/mongod.log" 2>&1 &
MONGOD_PID=$!
echo "$MONGOD_PID" > "$PID_FILE"

echo "   PID     → $MONGOD_PID"
echo "   dbpath  → $DATA_DIR"
echo "   port    → $MONGO_PORT"
echo "   log     → $DATA_DIR/mongod.log"
echo ""

# ── 2. Wait for mongod to accept connections ──
echo "⏳  Waiting for mongod to be ready..."
for i in $(seq 1 15); do
  if mongosh --quiet --port "$MONGO_PORT" --eval "db.runCommand({ping:1})" &>/dev/null; then
    echo "✅  mongod is ready."
    break
  fi
  if [ "$i" -eq 15 ]; then
    echo "❌  mongod did not respond after 15 seconds. Check $DATA_DIR/mongod.log"
    exit 1
  fi
  sleep 1
done

echo ""

# ── 3. Run setup (venv + seed) ──
"$SCRIPT_DIR/setup_db.sh"

echo ""
echo "🚀  All up! MongoDB running on port $MONGO_PORT."
echo "    To stop:  ./exit.sh"
