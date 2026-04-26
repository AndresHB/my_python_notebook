#!/usr/bin/env bash
# ──────────────────────────────────────────────
# setup_db.sh — Creates venv, installs dependencies and runs seed.py
# Prerequisite: mongod must be running (use start_db.sh).
# ──────────────────────────────────────────────
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
VENV_DIR="$PROJECT_DIR/.venv"

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

# ── 4. Run seed ──
echo "🌱  Running seed.py..."
python "$SCRIPT_DIR/seed.py"

echo ""
echo "✅  Done! Database seeded successfully."
