#!/usr/bin/env bash
# ──────────────────────────────────────────────
# init.sh — Levanta MongoDB + ejecuta seed en un solo paso
# Guarda el PID de mongod en data/mongod.pid para exit.sh.
# ──────────────────────────────────────────────
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_DIR="$PROJECT_DIR/scripts"
DATA_DIR="$PROJECT_DIR/.data"
PID_FILE="$DATA_DIR/mongod.pid"
MONGO_PORT=27017

# ── Verificar que mongod está instalado ──
if ! command -v mongod &>/dev/null; then
  echo "❌  mongod no encontrado. Instálalo con:  brew install mongodb-community"
  exit 1
fi

# ── Verificar que no hay otra instancia corriendo ──
if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
  echo "⚠️  mongod ya está corriendo (PID $(cat "$PID_FILE")). Usa ./exit.sh para detenerlo primero."
  exit 1
fi

# ── Crear carpeta de datos ──
mkdir -p "$DATA_DIR"

# ── 1. Levantar mongod en background ──
echo "🟢  Iniciando mongod en background..."
mongod --dbpath "$DATA_DIR" --bind_ip 127.0.0.1 --port "$MONGO_PORT" > "$DATA_DIR/mongod.log" 2>&1 &
MONGOD_PID=$!
echo "$MONGOD_PID" > "$PID_FILE"

echo "   PID     → $MONGOD_PID"
echo "   dbpath  → $DATA_DIR"
echo "   puerto  → $MONGO_PORT"
echo "   log     → $DATA_DIR/mongod.log"
echo ""

# ── 2. Esperar a que mongod acepte conexiones ──
echo "⏳  Esperando a que mongod esté listo..."
for i in $(seq 1 15); do
  if mongosh --quiet --port "$MONGO_PORT" --eval "db.runCommand({ping:1})" &>/dev/null; then
    echo "✅  mongod listo."
    break
  fi
  if [ "$i" -eq 15 ]; then
    echo "❌  mongod no respondió tras 15 segundos. Revisa $DATA_DIR/mongod.log"
    exit 1
  fi
  sleep 1
done

echo ""

# ── 3. Ejecutar setup (venv + seed) ──
"$SCRIPT_DIR/setup.sh"

echo ""
echo "🚀  ¡Todo arriba! MongoDB corriendo en puerto $MONGO_PORT."
echo "    Para detener:  ./exit.sh"
