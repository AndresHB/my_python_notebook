#!/usr/bin/env bash
# ──────────────────────────────────────────────
# exit.sh — Detiene el servidor FastAPI levantado por init.sh
# ──────────────────────────────────────────────
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
PID_FILE="$PROJECT_DIR/.pid"

if [ ! -f "$PID_FILE" ]; then
  echo "⚠️  No se encontró $PID_FILE — ¿el servidor no fue iniciado con init.sh?"
  exit 1
fi

PID="$(cat "$PID_FILE")"

if ! kill -0 "$PID" 2>/dev/null; then
  echo "⚠️  El proceso (PID $PID) ya no está corriendo."
  rm -f "$PID_FILE"
  exit 0
fi

echo "🛑  Deteniendo servidor FastAPI (PID $PID)..."
kill "$PID"

# Esperar a que termine
for i in $(seq 1 10); do
  if ! kill -0 "$PID" 2>/dev/null; then
    echo "✅  Servidor detenido correctamente."
    rm -f "$PID_FILE"
    exit 0
  fi
  sleep 1
done

echo "⚠️  El servidor no se detuvo a tiempo, forzando (SIGKILL)..."
kill -9 "$PID" 2>/dev/null || true
rm -f "$PID_FILE"
echo "✅  Servidor terminado."
