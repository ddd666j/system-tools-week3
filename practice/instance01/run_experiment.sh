#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/../.." && pwd)
cd "$(dirname "$0")"
{
  echo "=== INSTANCE 01: inspect wheel as ZIP artifact ==="
  sha256sum ../../q09/dist/*.whl
  "$ROOT/.venv-dev/bin/python" inspect_wheel.py
  echo "verification=passed"
} 2>&1 | tee experiment.log

