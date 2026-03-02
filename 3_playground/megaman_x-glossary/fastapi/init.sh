#!/usr/bin/env bash
# ──────────────────────────────────────────────
# init.sh — Crea venv, instala dependencias y arranca uvicorn
# Guarda el PID del servidor en .pid para exit.sh.
# ──────────────────────────────────────────────
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
VENV_DIR="$PROJECT_DIR/.venv"
PID_FILE="$PROJECT_DIR/.pid"
APP_PORT="${APP_PORT:-8000}"

# ── Verificar que no hay otra instancia corriendo ──
if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
  echo "⚠️  El servidor ya está corriendo (PID $(cat "$PID_FILE")). Usa ./exit.sh para detenerlo primero."
  exit 1
fi

# ── 1. Crear virtualenv si no existe ──
if [ ! -d "$VENV_DIR" ]; then
  echo "📦  Creando virtualenv en .venv ..."
  python3 -m venv "$VENV_DIR"
fi

# ── 2. Activar virtualenv ──
# shellcheck disable=SC1091
source "$VENV_DIR/bin/activate"

# ── 3. Instalar dependencias ──
echo "📥  Instalando dependencias..."
pip install --quiet --upgrade pip
pip install --quiet -r "$PROJECT_DIR/requirements.txt"

# ── 4. Arrancar uvicorn en background ──
echo "🟢  Iniciando servidor FastAPI en puerto $APP_PORT..."
uvicorn app.main:app --host 0.0.0.0 --port "$APP_PORT" --reload --app-dir "$PROJECT_DIR" > "$PROJECT_DIR/.server.log" 2>&1 &
SERVER_PID=$!
echo "$SERVER_PID" > "$PID_FILE"

echo ""
echo "   PID    → $SERVER_PID"
echo "   Puerto → $APP_PORT"
echo "   Docs   → http://localhost:$APP_PORT/docs"
echo "   Log    → $PROJECT_DIR/.server.log"
echo ""
echo "🚀  ¡Servidor arriba! Para detener:  ./exit.sh"
