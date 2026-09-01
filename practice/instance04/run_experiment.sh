#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/../.." && pwd)
PY="$ROOT/.venv-dev/bin/python"
UV=/home/dmh/.local/bin/uv
cd "$(dirname "$0")"
rm -rf package-src dist clean-venv
cp -r "$ROOT/q10" package-src
rm -rf package-src/.pytest_cache package-src/src/greetlab_25020007021.egg-info
{
  echo "=== INSTANCE 04: build fixed package ==="
  (cd package-src && "$PY" -m build --wheel --no-isolation --outdir ../dist)
  ls -lh dist
  echo "=== CLEAN WHEEL-ONLY INSTALL ==="
  "$UV" venv --python /home/dmh/.local/bin/python3.12 clean-venv
  "$UV" pip install --python clean-venv/bin/python --no-index --find-links dist greetlab-25020007021
  echo "=== REAL CONSOLE CONTRACT ==="
  "$PY" integration_test.py
} 2>&1 | tee experiment.log

