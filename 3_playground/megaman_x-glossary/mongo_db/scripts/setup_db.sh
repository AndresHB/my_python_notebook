#!/usr/bin/env bash
# ──────────────────────────────────────────────
# setup_db.sh — Crea venv, instala dependencias y ejecuta seed.py
# Prerrequisito: mongod debe estar corriendo (usa start_db.sh).
# ──────────────────────────────────────────────
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
VENV_DIR="$PROJECT_DIR/.venv"

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

# ── 4. Ejecutar seed ──
echo "🌱  Ejecutando seed.py..."
python "$SCRIPT_DIR/seed.py"

echo ""
echo "✅  ¡Listo! Base de datos sembrada correctamente."
