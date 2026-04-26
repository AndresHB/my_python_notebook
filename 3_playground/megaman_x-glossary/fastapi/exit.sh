#!/usr/bin/env bash
# ──────────────────────────────────────────────
# exit.sh — Stops the FastAPI server started by init.sh
# ──────────────────────────────────────────────
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
PID_FILE="$PROJECT_DIR/.pid"

if [ ! -f "$PID_FILE" ]; then
  echo "⚠️  $PID_FILE not found — was the server started with init.sh?"
  exit 1
fi

PID="$(cat "$PID_FILE")"

if ! kill -0 "$PID" 2>/dev/null; then
  echo "⚠️  The process (PID $PID) is no longer running."
  rm -f "$PID_FILE"
  exit 0
fi

echo "🛑  Stopping FastAPI server (PID $PID)..."
kill "$PID"

# Wait for it to terminate
for i in $(seq 1 10); do
  if ! kill -0 "$PID" 2>/dev/null; then
    echo "✅  Server stopped successfully."
    rm -f "$PID_FILE"
    exit 0
  fi
  sleep 1
done

echo "⚠️  The server did not stop in time, forcing (SIGKILL)..."
kill -9 "$PID" 2>/dev/null || true
rm -f "$PID_FILE"
echo "✅  Server terminated."
