#!/usr/bin/env bash
# ──────────────────────────────────────────────
# init.sh — Creates venv, installs dependencies and starts uvicorn
# Saves the server PID in .pid for exit.sh.
# ──────────────────────────────────────────────
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
VENV_DIR="$PROJECT_DIR/.venv"
PID_FILE="$PROJECT_DIR/.pid"
APP_PORT="${APP_PORT:-8000}"

# ── Check that no other instance is running ──
if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
  echo "⚠️  The server is already running (PID $(cat "$PID_FILE")). Use ./exit.sh to stop it first."
  exit 1
fi

# ── 1. Create virtualenv if it does not exist ──
if [ ! -d "$VENV_DIR" ]; then
  echo "📦  Creating virtualenv in .venv ..."
  python3 -m venv "$VENV_DIR"
fi

# ── 2. Activate virtualenv ──
# shellcheck disable=SC1091
source "$VENV_DIR/bin/activate"

# ── 3. Install dependencies ──
echo "📥  Installing dependencies..."
pip install --quiet --upgrade pip
pip install --quiet -r "$PROJECT_DIR/requirements.txt"

# ── 4. Start uvicorn in background ──
echo "🟢  Starting FastAPI server on port $APP_PORT..."
uvicorn app.main:app --host 0.0.0.0 --port "$APP_PORT" --reload --app-dir "$PROJECT_DIR" > "$PROJECT_DIR/.server.log" 2>&1 &
SERVER_PID=$!
echo "$SERVER_PID" > "$PID_FILE"

echo ""
echo "   PID    → $SERVER_PID"
echo "   Port   → $APP_PORT"
echo "   Docs   → http://localhost:$APP_PORT/docs"
echo "   Log    → $PROJECT_DIR/.server.log"
echo ""
echo "🚀  Server is up! To stop:  ./exit.sh"
