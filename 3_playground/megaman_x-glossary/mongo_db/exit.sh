#!/usr/bin/env bash
# ──────────────────────────────────────────────
# exit.sh — Detiene la instancia de mongod levantada por init.sh
# ──────────────────────────────────────────────
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
PID_FILE="$PROJECT_DIR/.data/mongod.pid"

if [ ! -f "$PID_FILE" ]; then
  echo "⚠️  No se encontró $PID_FILE — ¿mongod no fue iniciado con init.sh?"
  exit 1
fi

PID="$(cat "$PID_FILE")"

if ! kill -0 "$PID" 2>/dev/null; then
  echo "⚠️  El proceso mongod (PID $PID) ya no está corriendo."
  rm -f "$PID_FILE"
  exit 0
fi

echo "🛑  Deteniendo mongod (PID $PID)..."
kill "$PID"

# Esperar a que termine
for i in $(seq 1 10); do
  if ! kill -0 "$PID" 2>/dev/null; then
    echo "✅  mongod detenido correctamente."
    rm -f "$PID_FILE"
    exit 0
  fi
  sleep 1
done

echo "⚠️  mongod no se detuvo a tiempo, forzando (SIGKILL)..."
kill -9 "$PID" 2>/dev/null || true
rm -f "$PID_FILE"
echo "✅  mongod terminado."
