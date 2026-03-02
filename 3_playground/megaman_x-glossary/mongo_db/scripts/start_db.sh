#!/usr/bin/env bash
# ──────────────────────────────────────────────
# start_db.sh — Levanta una instancia local de MongoDB
# Usa una carpeta "data/" dentro de mongo_db/ como dbpath.
# Detén con Ctrl+C.
# ──────────────────────────────────────────────
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DATA_DIR="$PROJECT_DIR/data"

# Verificar que mongod está instalado
if ! command -v mongod &>/dev/null; then
  echo "❌  mongod no encontrado. Instálalo con:  brew install mongodb-community"
  exit 1
fi

# Crear carpeta de datos si no existe
mkdir -p "$DATA_DIR"

echo "🟢  Iniciando mongod..."
echo "   dbpath  → $DATA_DIR"
echo "   puerto  → 27017"
echo "   Detén con Ctrl+C"
echo ""

exec mongod --dbpath "$DATA_DIR" --bind_ip 127.0.0.1 --port 27017
