#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
PY="$ROOT/.venv-dev/bin/python"
UV=/home/dmh/.local/bin/uv
cd "$(dirname "$0")"
rm -rf build dist clean-venv src/*.egg-info
{
  echo "=== Q09 STEP 1: source tree ==="
  find src -maxdepth 3 -type f -print | sort
  sed -n '1,120p' pyproject.toml
  echo "=== Q09 STEP 2: build wheel ==="
  "$PY" -m build --no-isolation
  ls -lh dist
  echo "=== Q09 STEP 3: clean venv and wheel-only install ==="
  "$UV" venv --python /home/dmh/.local/bin/python3.12 clean-venv
  "$UV" pip install --python clean-venv/bin/python --no-index --find-links dist greetlab-25020007021
  clean-venv/bin/python -c 'from importlib.metadata import version; print("installed_version=", version("greetlab-25020007021"))'
  echo "=== Q09 STEP 4: execute outside q09 ==="
  cd /tmp
  "$OLDPWD/clean-venv/bin/sdt-greet" --name 25020007021
} 2>&1 | tee experiment.log
