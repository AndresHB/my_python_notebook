#!/usr/bin/env bash
# ──────────────────────────────────────────────
# exit.sh — Stops the mongod instance started by init.sh
# ──────────────────────────────────────────────
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
PID_FILE="$PROJECT_DIR/.data/mongod.pid"

if [ ! -f "$PID_FILE" ]; then
  echo "⚠️  $PID_FILE not found — was mongod started with init.sh?"
  exit 1
fi

PID="$(cat "$PID_FILE")"

if ! kill -0 "$PID" 2>/dev/null; then
  echo "⚠️  The mongod process (PID $PID) is no longer running."
  rm -f "$PID_FILE"
  exit 0
fi

echo "🛑  Stopping mongod (PID $PID)..."
kill "$PID"

# Wait for it to terminate
for i in $(seq 1 10); do
  if ! kill -0 "$PID" 2>/dev/null; then
    echo "✅  mongod stopped successfully."
    rm -f "$PID_FILE"
    exit 0
  fi
  sleep 1
done

echo "⚠️  mongod did not stop in time, forcing (SIGKILL)..."
kill -9 "$PID" 2>/dev/null || true
rm -f "$PID_FILE"
echo "✅  mongod terminated."
